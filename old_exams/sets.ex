defmodule Set do
    #allow duplicates
    def union([], b) do b end
    def union([h | t], b) do [h | union(t, b)] end

    def is_elem(_n, []) do false end
    def is_elem(n, [n | _t]) do true end
    def is_elem(n, [_ | t]) do is_elem(n, t) end

    def isec([], _) do [] end
    def isec([h | t], b) do
        case is_elem(h, b) do
            true ->
                [h | isec(t, b)]
            false ->
                isec(t, b)
        end
    end

    def diff([], _) do [] end
    def diff([h | t], b) do
        case is_elem(h, b) do
            true ->
                diff(t, b)
            false ->
                [h | diff(t, b)]
        end
    end
end
