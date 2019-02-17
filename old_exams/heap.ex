defmodule Heap do
    def pop(nil) do
        false
    end
    def pop({:node, v, _s, lh, nil}) do
        {v, lh}
    end
    def pop({:node, v, _s, nil, rh}) do
        {v, rh}
    end
    def pop({:node, v, s, lh, rh}) do
        {:node, l, _, _, _} = lh
        {:node, r, _, _, _} = rh
        cond do
            l > r ->
                {l, poped} = pop(lh)
                {v, {:node, l, s - 1, poped, rh}}
            true ->
                {r, poped} = pop(rh)
                {v, {:node, r, s - 1, lh, poped}}
        end
    end

    def insert(v, nil) do {:node, v, 1, nil, nil} end
    def insert(v, {:node, n, s, lh, rh}) do
        lhs = heap_size(lh)
        rhs = heap_size(rh)
        cond do
            (v < n) && (lhs < rhs) ->
                {:node, n, s + 1, insert(v, lh), rh}
            (v < n) ->
                {:node, n, s + 1, lh, insert(v, rh)}
            (lhs < rhs) ->
                {:node, v, s + 1, insert(n, lh), rh}
            true ->
                {:node, v, s + 1, lh, insert(n, rh)}
        end
    end
    #def insert(v, {:node, n, lh, rh}) when v < n do
        #{:node, n, rh, insert(v, lh)}
    #end
    #def insert(v, {:node, n, lh, rh}) do
    #    {:node, v, rh, insert(n, lh)}
    #end

    def heap_size(nil) do 0 end
    def heap_size({:node, _, size, _, _}) do size end
end
