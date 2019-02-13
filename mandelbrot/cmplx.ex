defmodule Cmplx do

    def new(r, i) do
        {:cmplx, r, i}
    end

    def add({:cmplx, a, b}, {:cmplx, c, d}) do
        {:cmplx, a + c, b + d}
    end

    def sqr({:cmplx, a, b}) do
        {:cmplx, (a * a) - (b * b), 2 * a * b}
    end

    def abs({:cmplx, a, b}) do
        :math.sqrt((a * a) + (b * b))
    end

end
