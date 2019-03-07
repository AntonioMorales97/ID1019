defmodule ParallelMergeSort do
    def pmsort(l) do
        me = self()
        pmsort(l, me)
        receive do
            {:ok, sorted} ->
                sorted
        end
    end

    def pmsort([], clr) do send(clr, {:ok, []}) end
    def pmsort([x], clr) do send(clr, {:ok, [x]}) end
    def pmsort(l, clr) do
        me = self()
        {l1, l2} = split(l)
        spawn(fn() -> pmsort(l1, me) end)
        spawn(fn() -> pmsort(l2, me) end)

        receive do
            {:ok, s1} ->
                receive do
                    {:ok, s2} ->
                        send(clr, {:ok, merge(s1, s2)})
                end
        end
    end

    def split(l) do split(l, [], []) end
    def split([], l1, l2) do {l1, l2} end
    def split([h | t], l1, l2) do split(t, [h | l2], l1) end

    def merge([], l2) do l2 end
    def merge(l1, []) do l1 end
    def merge([h1 | l1], [h2 | _] = l2) when h1 < h2 do
        [h1 | merge(l1, l2)]
    end
    def merge(l1, [h2 | l2]) do
        [h2 | merge(l1, l2)]
    end

end
