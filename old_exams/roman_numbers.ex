defmodule Roman do
    def translate_simple(n) do
        translate_simple(n, 0)
    end
    def translate_simple([], n) do n end
    def translate_simple([h | t], n) do
        case h do
            ?X ->
                translate_simple(t, n + 10)
            ?V ->
                translate_simple(t, n + 5)
            ?I ->
                translate_simple(t, n + 1)
        end
    end

    def translate([]) do 0 end
    def translate([?I, ?X | t]) do 9 + translate(t) end
    def translate([?I, ?V | t]) do 4 + translate(t) end
    def translate([?X | t]) do 10 + translate(t) end
    def translate([?V | t]) do 5 + translate(t) end
    def translate([?I | t]) do 1 + translate(t) end
end
