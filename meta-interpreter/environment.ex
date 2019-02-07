#Environment functions
defmodule Env do
    def new() do
        []
    end

    #def add(id, str, env) do
    #    [{id, str} | env]
    #end
    def add(id, str, []) do [{id, str}] end
    def add(id, str, [{id, _oldstr} | rest]) do
        [{id, str} | rest]
    end
    def add(id, str, [head | rest] ) do
        [head | add(id, str, rest)]
    end

    def lookup(_id, []) do nil end
    def lookup(id, [{id, str} | _]) do
        {id, str}
    end
    def lookup(id, [_ | tail]) do
        lookup(id, tail)
    end

    def remove(_, []) do [] end
    def remove([], env) do env end
    def remove([head | tail], env) do
        remove(tail, remove_id(head, env))
    end

    def remove_id(_id, []) do [] end
    def remove_id(id, [{id, _} | rest]) do rest end
    def remove_id(id, [head | rest]) do
        [head | remove_id(id, rest)]
    end

    def closure(l, env) do closure(l, [], env) end
    def closure([], acc, _env) do acc end
    def closure([head | tail], acc, env) do
        case lookup(head, env) do
            nil ->
                :error
            {id, str} ->
                closure(tail, [{id, str} | acc], env)
        end
    end

    def args([], _, env) do env end
    def args(_, [], env) do env end
    def args([var | tail], [str | rest], env) do
        args(tail, rest, [{var, str} | env])
    end


end
