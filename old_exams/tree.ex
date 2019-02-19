defmodule Tree do
    def traverse(nil) do [] end
    def traverse({:node, v, l, r}) do
        traverse(l) ++ [v | traverse(r)]
    end

    def better(tree) do
        traverse(tree, [])
    end
    def traverse(nil, acc) do acc end
    def traverse({:node, v, l, r}, acc) do
        traverse(l, [v | traverse(r, acc)])
    end

    def insert(nil, e) do {:node, e, nil, nil} end
    def insert({:node, v, l, r}, e) when e < v do
        {:node, v, insert(l, e), r}
    end
    def insert({:node, v, l, r}, e) do
        {:node, v, l, insert(r, e)}
    end

    def delete(nil, _) do nil end
    def delete({:node, v, nil, r}, v) do
        r
    end
    def delete({:node, v, l, nil}, v) do
        l
    end
    def delete({:node, v, l, r}, v) do
        {rest, max} = rightmost(l)
        {:node, max, rest, r}
    end
    def delete({:node, v, l, r}, e) when e < v do
        {:node, v, delete(l, e), r}
    end
    def delete({:node, v, l, r}, e) do
        {:node, v, l, delete(r, e)}
    end

    def rightmost(nil) do :empty end
    def rightmost({:node, a, l, {:node, v, nil, nil}}) do
        {{:node, a, l, nil}, v}
    end
    def rightmost({:node, v, l, r}) do
        {rest, max} = rightmost(r)
        {{:node, v, l, rest}, max}
    end

end
