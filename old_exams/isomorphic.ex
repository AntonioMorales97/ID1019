defmodule Isomorphic do
    def isomorfic(nil, nil) do true end
    def isomorfic({:tree, _, l1, r1}, {:tree, _, l2, r2}) do
        #isomorfic(l1, l2) == isomorfic(r1, r2)
        case isomorfic(l1, l2) do
            true ->
                isomorfic(r1, r2)
            false ->
                false
        end
    end
    def isomorfic(_, _) do false end
end
