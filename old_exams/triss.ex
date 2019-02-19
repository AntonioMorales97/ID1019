defmodule Triss do
    def triss([]) do false end
    def triss([h | t]) do
        case Enum.filter(t, fn(x) -> x == h end) do
            [_, _ | _] ->
                true
            _ ->
                triss(t)
        end
    end
end
