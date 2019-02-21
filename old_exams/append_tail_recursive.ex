defmodule AppendTail do
    def append(l, []) do l end
    def append([], l) do l end
    def append(l1, [h2 | t2]) do
        reversed = reverse(l1)
        appended = reverse([h2 | reversed])
        append(appended, t2)
    end


    def reverse(l) do reverse(l, []) end
    def reverse([], rev) do rev end
    def reverse([h | t], rev) do reverse(t, [h | rev]) end
end
