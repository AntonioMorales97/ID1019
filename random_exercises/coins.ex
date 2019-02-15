# 100% brute force (it is more of an Elixir exercise than a math/algorithm exercise)
defmodule Coins do
    def run(n, heads, total) do
        coins = generate_set(0, [], heads, total)
        run(1, n, heads, total, coins)
    end
    def run(n, m, _, _, _) when n > m do :completed end
    def run(i, n, heads, total, coins) do
        shuffled = Enum.shuffle(coins)
        case test_theory(heads, shuffled) do
            true ->
                IO.write("Test number: #{i} resulted in true\n")
                run(i + 1, n, heads, total, coins)
            false ->
                IO.write("Test number: #{i} resulted in false!\n")
        end
    end

    #heads = krona, tails = klave
    def generate_set(i, coins, _, i) do coins end
    def generate_set(i, coins, heads, total) when i >= heads do
        generate_set(i + 1, [:tails | coins], heads, total)
    end
    def generate_set(i, coins, heads, total) do
        generate_set(i + 1, [:heads | coins], heads, total)
    end

    def flip_coins([], flipped) do flipped end
    def flip_coins([coin | coins], flipped) do
        case coin do
            :heads ->
                flip_coins(coins, [:tails | flipped])
            :tails ->
                flip_coins(coins, [:heads | flipped])
        end
    end

    #pure brute force
    def test_theory(heads, coins) do
        {a, b} = Enum.split(coins, heads) #split into two piles: a = pile of #heads, b with rest...
        #IO.puts("List before flip: #{inspect(a)}")
        flipped = flip_coins(a, [])
        #IO.puts("List after flip: #{inspect(flipped)}")
        heads_flipped = Enum.count(flipped, fn(x) -> x == :heads end)
        #heads_b should have the same amount of heads as heads_flipped
        heads_b = Enum.count(b, fn(x) -> x == :heads end)
        heads_flipped == heads_b
    end
end
