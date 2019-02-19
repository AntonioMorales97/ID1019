defmodule RemoveRepetition do
    def reduce([]) do [] end
    def reduce([h, h | t]) do
        reduce([h | t])
    end
    def reduce([h | t]) do
        [h | reduce(t)]
    end
end
