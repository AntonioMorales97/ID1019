defmodule Caesarchiffer do
    def encode([]) do [] end
    def encode([?a | t]) do [?x | encode(t)] end
    def encode([?b | t]) do [?y | encode(t)] end
    def encode([?c | t]) do [?z | encode(t)] end
    def encode([?\s | t]) do [?\s | encode(t)] end
    def encode([h | t]) do
        if (h < 99) || (h > 122) do
            :fail
        else
            [h - 3 | encode(t)]
        end
    end

end
