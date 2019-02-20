defmodule SumAndLength do

    #def once(l) do
    #    once(l, 0, 0)
    #end
    #def once([], s, l) do {s, l} end
    #def once([h | t], s, l) do
    #    once(t, h + s, 1 + l)
    #end

    def once([]) do {0, 0} end
    def once([h | t]) do
        {s, l} = once(t)
        {h + s, l + 1}
    end

end
