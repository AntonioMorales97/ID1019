defmodule Poly do
    def calc(poly, x) do
        calc_poly(poly, x, 0)
    end

    def calc_poly([], _, s) do s end
    def calc_poly([k | poly], x, s) do
        calc_poly(poly, x, s*x + k)
    end
end
