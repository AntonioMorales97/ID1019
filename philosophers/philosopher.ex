defmodule Philosopher do
    @dream 1000
    @eat 50
    @delay 200

    def start(hunger, strength, left, right, name, ctrl, seed) do
        spawn_link(fn -> init(hunger, strength, left, right, name, ctrl, seed) end)
    end

    defp init(hunger, strength, left, right, name, ctrl, seed) do
        :rand.seed(:exsplus, {seed, seed, seed})
        dreaming(hunger, strength, left, right, name, ctrl)
    end

    defp dreaming(0, strength, _, _, name, ctrl) do
        IO.puts("#{name} is happy, strength is still #{strength}!")
        send(ctrl, :done)
    end
    defp dreaming(hunger, 0, _, _, name, ctrl) do
        IO.puts("#{name} is starved to death, hunger is down to #{hunger}!")
        send(ctrl, :done)
    end
    defp dreaming(hunger, strength, left, right, name, ctrl) do
        IO.puts("#{name} is dreaming...")
        delay(@dream)
        waiting(hunger, strength, left, right, name, ctrl)
    end

    defp waiting(hunger, strength, left, right, name, ctrl) do
        IO.puts("#{name} is waiting, #{hunger} to go!")

        case Chopstick.request(left) do
            :ok ->
                delay(@delay)

                case Chopstick.request(right) do
                    :ok ->
                        IO.puts("#{name} received both sticks!")
                        eating(hunger, strength, left, right, name, ctrl)
                end
        end
    end

    defp eating(hunger, strength, left, right, name, ctrl) do
        IO.puts("#{name} is eating...")

        delay(@eat)

        Chopstick.return(left)
        Chopstick.return(right)

        dreaming(hunger - 1, strength, left, right, name, ctrl)
    end

    defp delay(t) do sleep(t) end

    defp sleep(0) do :ok end
    defp sleep(t) do :timer.sleep(:rand.uniform(t)) end

end
