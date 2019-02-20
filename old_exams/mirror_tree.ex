defmodule MirrorTree do
    def mirror(nil) do nil end
    def mirror({:tree, v, l, r}) do
        {:tree, v, mirror(r), mirror(l)}
    end
end
