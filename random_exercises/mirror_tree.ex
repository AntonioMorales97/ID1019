defmodule MirrorTree do
    def mirror(nil) do nil end

    def mirror({:node, v, left, right}) do
        {:node, v, mirror(right), mirror(left)}
    end
end
