defmodule ParallelSum do
    def sum({:leaf, v}) do v end
    def sum(nil) do 0 end
    def sum({:tree, left, right}) do
        me = self()
        spawn_link(fn() -> res = sum(left); send(me, {:res, res}) end)
        spawn_link(fn() -> res = sum(right); send(me, {:res, res}) end)
        receive do
            {:res, r1} ->
                receive do
                    {:res, r2} ->
                        r1 + r2
                end
        end
    end
end
