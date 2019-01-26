defmodule TwoThreeTree do


    #insert into an empty tree, creating a leaf
    def insert_leaf(key, value, :nil) do
        {:leaf, key, value}
    end

    #insert into a leaf, creating a 2-node
    def insert_leaf(key, value, {:leaf, key1, _}=leaf) do
        cond do
            key <= key1 ->
                {:two, key, {:leaf, key, value}, leaf}
            true ->
                {:two, key1, leaf, {:leaf, key, value}}
        end
    end

    #insert into a 2-node containing leaves and create a 3-node
    def insert_leaf(key, value, {:two, key1, {:leaf, key1, _} = leaf1, {:leaf, key2, _} = leaf2}) do
        cond do
            key <= key1 ->
                {:three, key, key1, {:leaf, key, value}, leaf1, leaf2}
            key <= key2 ->
                {:three, key1, key, leaf1, {:leaf, key, value}, leaf2}
            true ->
                {:three, key1, key2, leaf1, leaf2, {:leaf, key, value}}
        end
    end

    #insert in a 3-node containing leaves and create a temp 4-node
    def insert_leaf(key, value, {:three, key1, key2, {:leaf, key1, _} = leaf1, {:leaf, key2, _} = leaf2, {:leaf, key3, _} = leaf3}) do
        cond do
            key <= key1 ->
                {:four, key, key1, key2, {:leaf, key, value}, leaf1, leaf2, leaf3}
            key <= key2 ->
                {:four, key1, key, key2, leaf1, {:leaf, key, value}, leaf2, leaf3}
            key <= key3 ->
                {:four, key1, key2, key, leaf1, leaf2, {:leaf, key, value}, leaf3}
            true ->
                {:four, key1, key2, key3, leaf1, leaf2, leaf3, {:leaf, key, value}}
        end
    end

    #insert into a 2-node and balance if a temp 4-node is created
    def insert_leaf(key, value, {:two, key1, left, right}) do
        cond do
            key <= key1 ->
                case insert_leaf(key, value, left) do
                    {:four, k1, k2, k3, l1, l2, l3, l4} ->
                        #move the middle in the 4-node to the parent and split into 2 2-nodes
                        #leave the right side unchanged
                        {:three, k2, key1, {:two, k1, l1, l2}, {:two, k3, l3, l4}, right}
                    done ->
                        {:two, key1, done, right}
                end
            true ->
                case insert_leaf(key, value, right) do
                    {:four, k1, k2, k3, l1, l2, l3 , l4} ->
                        #move the middle in the 4-node to the parent and split into 2 2-nodes
                        #leave the left side unchanged
                        {:three, key1, k2, left, {:two, k1, l1, l2}, {:two, k3, l3, l4}}
                    done ->
                        {:two, key1, left, done}
                end
        end
    end

    #insert into a 3-node and create a 3-node or a temp 4-node if necessary
    def insert_leaf(key, value, {:three, key1, key2, left, middle, right}) do
        cond do
            key <= key1 ->
                case insert_leaf(key, value, left) do
                    {:four, k1, k2, k3, l1, l2, l3, l4} ->
                        {:four, k2, key1, key2, {:two, k1, l1, l2}, {:two, k3, l3, l4}, middle, right}
                    done ->
                        {:three, key1, key2, done, middle, right}
                end
            key <= key2 ->
                case insert_leaf(key, value, middle) do
                    {:four, k1, k2, k3, l1, l2, l3, l4} ->
                        {:four, key1, k2, key2, left, {:two, k1, l1, l2}, {:two, k3, l3, l4}, right}
                    done ->
                        {:three, key1, key2, left, done, right}
                end
            true ->
                case insert_leaf(key, value, right) do
                    {:four, k1, k2, k3, l1, l2, l3, l4} ->
                        {:four, key1, key2, k2, left, middle, {:two, k1, l1, l2}, {:two, k3, l3, l4}}
                    done ->
                        {:three, key1, key2, left, middle, done}
                end
        end
    end

    #insert the key/value pairs here into a tree
    def insert(key, value, root) do
        case insert_leaf(key, value, root) do
            #In case a temp 4-node turns up
            {:four, k1, k2, k3, l1, l2, l3, l4} ->
                {:two, k2, {:two, k1, l1, l2}, {:two, k3, l3 ,l4}}
            done ->
                done
        end
    end

    #insert random key numbers with a default value into a tree
    def test(0, tree) do tree end
    def test(n, tree) do
        test(n-1, insert(Enum.random(0..1000), :foo, tree))
    end

    #Check if it is balanced!
    def depth({:leaf, _, _}), do: 0
    def depth({:two, _, l, r}) do
        1 + max(depth(l), depth(r))
    end
    def depth({:three, _, _, l, m, r}) do
        1 + max(depth(l), max(depth(m), depth(r)))
    end

end
