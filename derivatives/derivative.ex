defmodule Derivative do
    @type constant() :: {:const, number()} | {:const, atom()}
    @type literal :: constant() | {:var, atom()}
    @type expr() :: {:exp, constant(), literal(), integer()} | {:mul, constant(), literal()} | literal()

    @spec deriv(expr(), atom()) :: expr()

    def test() do
        #4x^2 + 3x + 42
        test = {:add, {:mul, {:const, 4}, {:exp, {:var, :x}, {:const, 2}}},
       {:add, {:mul, {:const, 3}, {:var, :x}}, {:const, 42}}}
        der = deriv(test, :x)
        simple = simplify(der)
        printp(test)
        IO.write("\n")
        printp(der)
        IO.write("\n")
        printp(simple)
        IO.write("\n")
    end

    def test_trig() do
        test = {:mul, {:sin, {:cos, {:var, :x}}}, {:cos, {:var, :x}}}
        der = deriv(test, :x)
        simple = simplify(der)
        printp(test)
        IO.write("\n")
        printp(der)
        IO.write("\n")
        printp(simple)
        IO.write("\n")
    end

    def test_ln() do
        test = {:ln, {:exp, {:var, :x}, {:const, 2}}}
        der = deriv(test, :x)
        simple = simplify(der)
        printp(test)
        IO.write("\n")
        printp(der)
        IO.write("\n")
        printp(simple)
        IO.write("\n")
    end

    def test_div() do
        test = {:div, {:const, 2}, {:exp, {:var, :x}, {:const, 3}}}
        der = deriv(test, :x)
        simple = simplify(der)
        printp(test)
        IO.write("\n")
        printp(der)
        IO.write("\n")
        printp(simple)
        IO.write("\n")
    end

    def test_all() do
        test = {:add, {:add, {:sin, {:add, {:exp, {:var, :x}, {:const, 2}}, {:var, :x}}}, {:div, {:const, 1}, {:ln, {:var, :x}}}}, {:sqroot, {:var, :x}}}
        der = deriv(test, :x)
        simple = simplify(der)
        printp(test)
        IO.write("\n")
        printp(der)
        IO.write("\n")
        printp(simple)
        IO.write("\n")
    end

    def deriv({:const, _}, _) do {:const, 0} end
    def deriv({:var, v}, v) do {:const, 1} end
    def deriv({:var, y}, _) do {:var, y} end
    def deriv({:mul, e1, e2}, v) do
        {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
    end
    def deriv({:exp, {:var, v}, {:const, c}}, v) do
        {:mul, {:const, c}, {:exp, {:var, v}, {:const, c - 1}}}
    end
    def deriv({:exp, e1, {:const, c}}, v) do
        {:mul, {:mul, {:const, c}, {:exp, e1, {:const, c - 1}}}, deriv(e1, v)}
    end
    def deriv({:add, e1, e2}, v) do
        {:add, deriv(e1, v), deriv(e2, v)}
    end
    def deriv({:sin, e1}, v) do
        {:mul, {:cos, e1}, deriv(e1, v)}
    end
    def deriv({:cos, e1}, v) do
        {:mul, {:const, -1}, {:mul, {:sin, e1}, deriv(e1, v)}}
    end
    def deriv({:ln, e1}, v) do
        {:div, deriv(e1, v), e1}
    end
    def deriv({:div, e1, e2}, v) do
        {:div, {:add, {:mul, deriv(e1, v), e2}, {:mul, {:const, -1}, {:mul, e1, deriv(e2, v)}}}, {:exp, e2, {:const, 2}}}
    end
    def deriv({:sqroot, e1}, v) do
        deriv({:exp, e1, {:const, 1/2}}, v)
    end

    def simplify({:const, c}) do {:const, c} end
    def simplify({:var, c}) do {:var, c} end
    def simplify({:ln, e1}) do {:ln, simplify(e1)} end
    def simplify({:exp, e1, {:const, c}}) when c < 0 do
        toggle = -1 * c
        simplify({:div, {:const, 1}, {:exp, e1, {:const, toggle}}})
    end
    def simplify({:exp, e1, {:const, c}}) when c == 1/2 do
        simplify({:sqroot, e1})
    end
    def simplify({:exp, {:sqroot, e1}, {:const, 2}}) do
        simplify(e1)
    end
    def simplify({:exp, e1, e2}) do
        case simplify(e2) do
            {:const, 0} ->
                {:const, 1}

            {:const, 1} ->
                simplify(e1)

            s2 ->
                case simplify(e1) do
                    {:const, 0} ->
                        {:const, 0}

                    {:const, 1} ->
                        {:const, 1}

                    s1 ->
                        {:exp, s1, s2}
                end
        end
    end
    def simplify({:mul, e1, e2}) do
        case simplify(e1) do
            {:const, 0} ->
                {:const, 0}

            {:const, 1} ->
                simplify(e2)

            s1 ->
                case simplify(e2) do
                    {:const, 0} ->
                        {:const, 0}

                    {:const, 1} ->
                        s1

                    s2 ->
                        {:mul, s1, s2}
                end
        end
    end
    def simplify({:add, e1, e2}) do
        case simplify(e1) do
            {:const, 0} ->
                simplify(e2)

            s1 ->
                case simplify(e2) do
                    {:const, 0} ->
                        s1

                    s2 ->
                        {:add, s1, s2}
                end
        end
    end
    #In case it can be simplified...
    def simplify({:sin, e1}) do
        case simplify(e1) do
            {:const, 0} ->
                {:const, 0}

            s1 ->
                {:sin, s1}
        end
    end
    def simplify({:cos, e1}) do
        case simplify(e1) do
            s1 ->
                {:cos, s1}
        end
    end
    def simplify({:div, e1, e2}) do
        case simplify(e1) do
            {:const, 0} ->
                {:const, 0}
            s1 ->
                case simplify(e2) do
                    {:const, 0} ->
                        raise "Division by 0"
                    s2 ->
                        {:div, s1, s2}
                end
        end
    end
    def simplify({:sqroot, e1}) do
        case simplify(e1) do
            {:const, 0} ->
                {:const, 0}
            {:const, 1} ->
                {:const, 1}
            s1 ->
                {:sqroot, s1}
        end
    end

    def printp({:const, c}) do IO.write("#{c}") end
    def printp({:var, v}) do IO.write("#{v}") end
    def printp({:exp, e1, e2}) do
        IO.write("(")
        printp(e1)
        IO.write(")")
        IO.write("^")
        printp(e2)
    end
    def printp({:mul, e1, e2}) do
        printp(e1)
        IO.write(" * ")
        printp(e2)
    end
    def printp({:add, e1, e2}) do
        printp(e1)
        IO.write(" + ")
        printp(e2)
    end
    def printp({:sin, e1}) do
        IO.write("sin(")
        printp(e1)
        IO.write(")")
    end
    def printp({:cos, e1}) do
        IO.write("cos(")
        printp(e1)
        IO.write(")")
    end
    def printp({:ln, e1}) do
        IO.write("ln(")
        printp(e1)
        IO.write(")")
    end
    def printp({:div, e1, e2}) do
        IO.write("(")
        printp(e1)
        IO.write(")/(")
        printp(e2)
        IO.write(")")
    end
    def printp({:sqroot, e1}) do
        IO.write("sqroot(")
        printp(e1)
        IO.write(")")
    end

end
