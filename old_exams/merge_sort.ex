defmodule MergeSort do
    def msort([]) do [] end
    def msort([x]) do [x] end #otherwise infinity...
    def msort(list) do
        {l1, l2} = split(list, [], [])
        merge(msort(l1), msort(l2))
    end

    def split([], l1, l2) do {l1, l2} end
    def split([h | t], l1, l2) do
        split(t, [h | l2], l1)
    end

    def merge([], l2) do l2 end
    def merge(l1, []) do l1 end
    def merge([h1 | t1], [h2 | t2]) when h1 < h2 do
        [h1 | merge(t1, [h2 | t2])]
    end
    def merge([h1 | t1], [h2 | t2]) do
        [h2 | merge([h1 | t1], t2)]
    end


end
