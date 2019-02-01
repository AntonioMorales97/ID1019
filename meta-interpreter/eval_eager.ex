defmodule Eager do
    def eval_expr({:atm, id}, _, _) do {:ok, id} end
    def eval_expr({:var, id}, env, _) do
        case Env.lookup(id, env) do
            nil ->
                :error
            {_, str} ->
                {:ok, str}
        end
    end
    def eval_expr({:cons, a, b}, env, prog) do
      case eval_expr(a, env, prog) do
        :error ->
          :error
        {:ok, str1} ->
          case eval_expr(b, env, prog) do
            :error ->
              :error
            {:ok, str2} ->
              {:ok, [str1 | str2]}
          end
      end
    end
    def eval_expr({:case, expr, cls}, env, prog) do
        case eval_expr(expr, env, prog) do
            :error ->
                :error
            {:ok, str} ->
                eval_clause(cls, str, env, prog)
        end
    end
    def eval_expr({:lambda, par, free, seq}, env, _) do
      case Env.closure(free, env) do
        :error ->
          :error
        closure ->
          {:ok, {:closure, par, seq, closure}}
      end
    end
    def eval_expr({:apply, expr, args}, env, prog) do
      case eval_expr(expr, env, prog) do
        :error ->
          :error
        {:ok, {:closure, par, seq, closure}} ->
          case eval_args(args, closure, prog) do
            :error ->
              :foo
            strs ->
              env = Env.args(par, strs, closure)
              eval_seq(seq, env, prog)
          end
      end
    end
    def eval_expr({:call, id, args}, env, prg) when is_atom(id) do
      case List.keyfind(prg, id, 0) do
        nil ->
          :error
        {_, par, seq} ->
          case eval_args(args, env, prg) do
            :error ->
              :error

            strs ->
              env = Env.args(par, strs, [])
              eval_seq(seq, env, prg)
          end
      end
    end

    def eval_args(args, env, prog) do
        #must be in right order...
        Enum.reverse(eval_args(args, [], env, prog))
    end
    def eval_args([], acc, _env, _prog) do acc end
    def eval_args([expr | tail], acc, env, prog) do
        case eval_expr(expr, env, prog) do
            :error ->
                :error
            {:ok, str} ->
                eval_args(tail, [str | acc], env, prog)
        end
    end

    def eval_clause([], _, _, _) do :error end
    def eval_clause([{:clause, pattern, sequence} | rest], str, env, prog) do
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)
        case eval_match(pattern, str, env) do
            :fail ->
                eval_clause(rest, str, env, prog)
            {:ok, env} ->
                eval_seq(sequence, env, prog)
        end
    end

    def eval_match(:ignore, _, env) do
      {:ok, env}
    end
    def eval_match({:atm, id}, id, env) do
      {:ok, env}
    end
    def eval_match({:var, id}, str, env) do
      case Env.lookup(id, env) do
        nil ->
          {:ok, Env.add(id, str, env)}
        {_, ^str} ->
          {:ok, env}
        {_, _} ->
          :fail
      end
    end
    def eval_match({:cons, hp, tp}, [hs | ts], env) do
      case eval_match(hp, hs, env) do
        :fail ->
          :fail
        {:ok, env} ->
          eval_match(tp, ts, env)
      end
    end
    def eval_match(_, _, _) do
        :fail
    end

    def eval_seq([exp], env, prog) do
      eval_expr(exp, env, prog)
    end
    def eval_seq([{:match, pattern, expression} | seq], env, prog) do
      case eval_expr(expression, env, prog) do
        :error ->
          :error
        {:ok, str} ->
          vars = extract_vars(pattern)
          env = Env.remove(vars, env)

          case eval_match(pattern, str, env) do
            :fail ->
              :error
            {:ok, env} ->
              eval_seq(seq, env, prog)
          end
      end
    end

    def eval(seq, prog) do
        eval_seq(seq, Env.new(), prog)
    end

    def extract_vars(p) do extract_vars(p, []) end
    def extract_vars({:atm, _}, vars) do vars end
    def extract_vars(:ignore, vars) do vars end
    def extract_vars({:var, var}, vars) do
        [var | vars]
    end
    def extract_vars({:cons, first, second}, vars) do
        extract_vars(second, extract_vars(first, vars))
    end



end
