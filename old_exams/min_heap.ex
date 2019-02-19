defmodule MinHeap do
    def heap_to_list(nil) do [] end
    def heap_to_list({:heap, v, l, r}) do
        lh = heap_to_list(l)
        rh = heap_to_list(r)
        [v | MergeSort.merge(lh, rh)]
    end

    def pop(nil) do false end
    def pop({:heap, v, l, nil}) do {:ok, v, l} end
    def pop({:heap, v, nil, r}) do {:ok, v, r} end
    def pop({:heap, v, l, r}) do
        {_, lv, _, _} = l
        {_, rv, _, _} = r
        if lv < rv do
            {:ok, lv, poped} = pop(l)
            {:ok, v, {:heap, lv, poped, r}}
        else
            {:ok, rv, poped} = pop(r)
            {:ok, v, {:heap, rv, l, poped}}
        end
    end

end
