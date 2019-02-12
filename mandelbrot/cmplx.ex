defmodule Cmplx do

    def new(r, i) do
        {:cmplx, r, i}
    end

    def add({:cmplx, a, b}, {:cmplx, c, d}) do
        {:cmplx, a + c, b + d}
    end

    def sqr({:cmplx, a, b}) do
        {:cmplx, (r * r) - (i * i), 2 * r * i}
    end

    def abs({:cmplx}, a, b) do
        :math.sqrt((a * a) + (b * b))
    end

end
