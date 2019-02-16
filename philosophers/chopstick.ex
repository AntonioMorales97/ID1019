defmodule Chopstick do
    def start do
      stick = spawn_link(fn -> available() end)
      {:stick, stick}
    end

    defp available() do
      receive do
        {:request, from} ->
            send(from, :granted)
            gone()
        :quit -> :ok
      end
    end

    defp gone() do
      receive do
        :return -> available()
        :quit -> :ok
      end
    end

    def request({:stick, pid}) do
      send(pid, {:request, self()})
      receive do
        :granted -> :ok
      end
    end

    def return({:stick, pid}) do
        send(pid, :return)
    end

    def quit({:stick, pid}) do
        send(pid, :quit)
    end


end
