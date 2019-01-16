defmodule Test do
    def double(n) do
        n*2
    end

    def fahrenheit_to_celsius(f) do
        (f-32)/1.8
    end

    def square_area(n) do
        n*n
    end

    def circle_area(r) do
        :math.pi*:math.pow(r,2)
    end

    def product_case(m, n) do
        case m do
            0 -> 0

            _ -> product_case(m-1, n) + n
        end
    end

    def product_clauses(0, _) do
        0
    end
    def product_clauses(m, n) do
        product_clauses(m-1, n) + n
    end

    def exp_clauses(_, 0) do 1 end
    def exp_clauses(x, n) do
        x * exp_clauses(x, n-1)
    end

    def exp_faster(_, 0) do 1 end
    def exp_faster(x, n) do
        case rem(n, 2) do
            0 ->
                e = exp_faster(x, div(n, 2))
                e * e

            1 ->
                exp_faster(x, n-1) * x
        end
    end

    def naive_reverse([]) do [] end
    def naive_reverse([head | tail]) do
        naive_reverse(tail) ++ [head]
    end

    def reverse(l) do reverse(l, []) end
    def reverse([], rev) do rev end
    def reverse([head | tail], rev) do
        reverse(tail, [head | rev])
    end

    # Benchmark for the list reverse functions.
    def bench() do
    ls = [16, 32, 64, 128, 256, 512]
    n = 100
    # bench is a closure: a function with an environment.
    bench = fn(l) ->
      seq = Enum.to_list(1..l)
      tn = time(n, fn -> naive_reverse(seq) end)
      tr = time(n, fn -> reverse(seq) end)
      :io.format("length: ~10w  naive_rev: ~8w us    reverse: ~8w us~n", [l, tn, tr])
    end

    # We use the library function Enum.each that will call
    # bench(l) for each element l in ls
    Enum.each(ls, bench)
  end

  # Time the execution time of the a function.
  def time(n, fun) do
    start = System.monotonic_time(:milliseconds)
    loop(n, fun)
    stop = System.monotonic_time(:milliseconds)
    stop - start
  end

  # Apply the function n times.
  def loop(n, fun) do
    if n == 0 do
      :ok
    else
      fun.()
      loop(n - 1, fun)
    end
  end

  #using accumulator
  def to_binary_better(n) do to_binary_better(n, []) end
  def to_binary_better(0, b) do b end
  def to_binary_better(n, b) do
      to_binary_better(div(n, 2), [rem(n, 2) | b])
  end

  def to_integer(x) do to_integer(x, 0) end
  def to_integer([], n) do n end
  def to_integer([x | r], n) do
      to_integer(r, 2 * n + x)
  end

  #fib
  def fib(0) do 0 end
  def fib(1) do 1 end
  def fib(n) do fib(n - 1) + fib(n - 2) end

  # Benchmark for Fibonacci sequence.
  def bench_fib() do
      ls = [8,10,12,14,16,18,20,22,24,26,28,30,32]
      n = 10

      bench = fn(l) ->
          t = time(n, fn() -> fib(l) end)
          :io.format("n: ~4w  fib(n) calculated in: ~8w us~n", [l, t])
      end

      Enum.each(ls, bench)
  end

end
