defmodule Ackermann do
    def ack(0, n) do n + 1 end
    def ack(m, 0) when m > 0 do
        ack(m - 1, 1)
    end
    def ack(m, n) do
        ack(m - 1, ack(m, n - 1))
    end
end
