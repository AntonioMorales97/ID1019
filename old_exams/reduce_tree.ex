defmodule Reduce do
    def reduce(nil, acc, _) do acc end
    def reduce({:node, v, l, r}, acc, op) do
        reduce(r, op.(reduce(l, acc, op), v), op)
    end

    def to_list(nil) do [] end
    def to_list(tree) do
        reduce(tree, [], fn(acc, x)-> acc ++ [x] end)
    end
end
