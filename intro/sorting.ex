defmodule Sorting do
    #Selection sort
    def sort(l) do
        reversed = selection(l, [])
        reverse(reversed, [])
    end
    def selection([], acc) do acc end
    def selection([h | t], acc) do
        min = smin(h, t)
        selection(delete(min, [h | t]), [min | acc])
    end

    def smin(min, []) do min end
    def smin(min, [h | t]) when h < min do
        smin(h, t)
    end
    def smin(min, [_ | t]) do smin(min, t) end

    def delete(_, []) do [] end
    def delete(m, [m | t]) do t end
    def delete(m, [h | t]) do [h | delete(m, t)] end

    def reverse([], rev) do rev end
    def reverse([h | t], rev) do reverse(t, [h | rev]) end

    #Insertion sort#
    def isort(l) do isort(l, []) end
    def isort([], sorted) do sorted end
    def isort([head | tail], sorted) do
        isort(tail, insert(head, sorted))
    end

    #Returns a list where x has been inserted
    #into the first place where it is smaller
    #than the next integer
    def insert(x, []) do [x] end
    def insert(x, [head | tail]) when x < head do
        [x, head | tail]
    end
    def insert(x, [head | tail]) do
        [head | insert(x, tail)]
    end

    #Merge sort#
    def msort([]) do [] end
    def msort([x]) do [x] end
    def msort(l) do
        {l1, l2} = split(l, [], [])
        merge(msort(l1), msort(l2))
    end

    #Split into equal sized lists
    def split([], l1, l2) do {l1, l2} end
    def split([x | tail], l1, l2) do
        split(tail, [x | l2], l1)
    end

    def merge([], l2) do l2 end
    def merge(l1, []) do l1 end
    def merge([x1 | l1], [x2 | _] = l2) when x1 < x2 do
        [x1 | merge(l1, l2)]
    end
    def merge(l1, [x2 | l2]) do
        [x2 | merge(l1, l2)]
    end

    #Quick sort#
    def qsort_capture([]) do [] end
    def qsort_capture([head | tail]) do
        {smaller, greater} = partition(head, tail)
        qsort_capture(smaller) ++ [head] ++ qsort_capture(greater)
    end

    def partition(pivot, l) do
        smaller = compareValues(pivot, l, &(&1 >= &2))
        greater = compareValues(pivot, l, &(&1 < &2))
        {smaller, greater}
    end

    def compareValues(_pivot, [], _comp) do [] end
    def compareValues(pivot, [head | tail], comp) do
        if comp.(pivot, head) do
            [head | compareValues(pivot, tail, comp)]
        else
            compareValues(pivot, tail, comp)
        end
    end

end
