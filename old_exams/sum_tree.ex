defmodule SumTree do
    def sum(nil) do 0 end
    def sum({:node, v, l, r}) do
        v + sum(l) + sum(r)
    end
end
