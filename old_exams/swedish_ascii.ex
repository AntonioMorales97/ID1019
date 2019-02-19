defmodule SwedishAscii do
    def seven([]) do [] end
    def seven([h | t]) do
        cond do
            h == ?å ->
                [?} | seven(t)]
            h == ?ä ->
                [?{ | seven(t)]
            h == ?ö ->
                [?| | seven(t)]
            h == ?Å ->
                [?] | seven(t)]
            h == ?Ä ->
                [?[ | seven(t)]
            h == ?Ö ->
                [?\ | seven(t)]
            true ->
                [h | seven(t)]
        end
    end
end
