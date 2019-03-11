defmodule Proc do
    def start(user) do
        collector = spawn(fn() -> collector(user, 0) end)
        {:ok, spawn(fn() -> proc(collector, 0) end)}
    end

    def proc(collector, n) do
        receive do
            {:process, task} ->
                spawn(fn() -> done = do_it(task); send(collector, {:done, n, done}) end)
                proc(collector, n + 1)
            :quit ->
                send(collector, :quit)
                :ok
        end
    end

    def collector(user, n) do
        receive do
            {:done, ^n, done} ->
                send(user, done)
                collector(user, n + 1)
            :quit ->
                :ok
        end
    end

    def do_it(task) do
        fib(task)
    end

    def fib(0) do 1 end
    def fib(1) do 1 end
    def fib(n) do fib(n - 1) + fib(n - 2) end
end
