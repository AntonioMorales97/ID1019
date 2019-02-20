defmodule ArithmeticExpression do
    def eval([]) do 0 end
    def eval([n | t]) do
        eval(t, n)
    end

    def eval([], s) do s end
    def eval(['+', n | t], s) do eval(t, n + s) end
    def eval(['-', n | t], s) do eval(t, s - n) end
end
