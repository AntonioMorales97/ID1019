defmodule LinearFalc do
    def falc(0) do [1] end
    def falc(h) do
        rest = falc(h - 1)
        [f | _] = rest
        [h * f | rest]
    end
end
