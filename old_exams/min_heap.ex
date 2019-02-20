defmodule MinHeap do
    def heap_to_list(nil) do [] end
    def heap_to_list({:heap, v, _, l, r}) do
        lh = heap_to_list(l)
        rh = heap_to_list(r)
        [v | MergeSort.merge(lh, rh)]
    end

    def pop(nil) do false end
    def pop({:heap, v, _, l, nil}) do {:ok, v, l} end
    def pop({:heap, v, _, nil, r}) do {:ok, v, r} end
    def pop({:heap, v, s, l, r}) do
        {_, lv, _, _, _} = l
        {_, rv, _, _, _} = r
        if lv < rv do
            {:ok, lv, poped} = pop(l)
            {:ok, v, {:heap, lv, s - 1, poped, r}}
        else
            {:ok, rv, poped} = pop(r)
            {:ok, v, {:heap, rv, s - 1, l, poped}}
        end
    end

    def insert(v, nil) do {:heap, v, 1, nil, nil} end
    def insert(v, {:heap, n, s, l, r}) do
        ls = heap_size(l)
        rs = heap_size(r)
        cond do
            (v > n) && (ls > rs) ->
                {:heap, n, s + 1, l, insert(v, r)}
            (v > n) ->
                {:heap, n, s + 1, insert(v, l), r}
            (ls > rs) ->
                {:heap, v, s + 1, l, insert(n, r)}
            true ->
                {:heap, v, s + 1, insert(n, l), r}
        end
    end

    def heap_size(nil) do 0 end
    def heap_size({:heap, _, s, _, _}) do s end
end
