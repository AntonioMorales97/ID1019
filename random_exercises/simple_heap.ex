defmodule Heap do

    def new() do
        {:heap, nil, nil, nil}
    end

    def insert({:heap, nil, nil, nil}, a) do
        {:heap, a, nil, nil}
    end
    def insert(nil, a) do
        {:heap, a, nil, nil}
    end
    def insert({:heap, node, left, right}, a) when a > node do
        {:heap, a, insert(right, node), left}
    end
    def insert({:heap, node, left, nil}, a) do
        {:heap, node, {:heap, a, nil, nil}, left}
    end
    def insert({:heap, node, left, right}, a) do
        {:heap, node, insert(right, a), left}
    end

    def pop({:heap, nil, _, _}) do :fail end
    def pop({:heap, node, nil, nil}) do {:ok, node, {:heap, nil, nil, nil}} end
    def pop({:heap, node, _, _} = heap) do
        case last(heap) do
            :fail ->
                :fail
            l ->
                case remove_last(heap) do
                    :fail ->
                        :fail
                    nil ->
                        {:ok, node, {:heap, nil, nil, nil}}
                    {:heap, _, left, right} ->
                        {:ok, node, repair({:heap, l, left, right})}
                end
        end
    end

    def repair({:heap, a, nil, nil}) do {:heap, a, nil, nil} end
    def repair({:heap, a, {:heap, node, left, right}, r}) when a < node do
        {:heap, node, repair({:heap, a, left, right}), r}
    end
    def repair({:heap, a, l, {:heap, node, left, right}}) when a < node do
        {:heap, node, repair({:heap, a, left, right}), l}
    end
    def repair(heap) do
        heap
    end

    def last({:heap, nil, nil, nil}) do :fail end
    def last({:heap, node, nil, nil}) do
        node
    end
    def last({:heap, _, {:heap, node, _, _}, nil}) do
        node
    end
    def last({:heap, _, left, _}) do
        last(left)
    end

    def remove_last({:heap, nil, nil, nil}) do :fail end
    def remove_last({:heap, _, nil, nil}) do nil end
    def remove_last({:heap, node, {:heap, _, _, _}, nil}) do
        {:heap, node, nil, nil}
    end
    def remove_last({:heap, node, left, right}) do
        {:heap, node, right, remove_last(left)}
    end

end
