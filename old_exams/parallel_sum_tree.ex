defmodule ParallelSumTree do
    def sum(nil) do 0 end
    def sum({:tree, v, l, r}) do
        me = self()
        spawn_link(fn() -> value = sum(l); send(me, {:value, value}) end)
        spawn_link(fn() -> value = sum(r); send(me, {:value, value}) end)
        receive do
            {:value, v1} ->
                receive do
                    {:value, v2} ->
                        v + v1 + v2
                end
        end

    end

end
