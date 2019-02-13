defmodule Brot do
    def mandelbrot(c, m) do
      z0 = Cmplx.new(0, 0)
      i = 0
      test(i, z0, c, m)
    end

    def test(m, _z, _c, m) do 0 end #maximum iteration reached
    def test(i, z, c, m) do
        abs = Cmplx.abs(z)

        if abs <= 2.0 do
            z1 = Cmplx.add(Cmplx.sqr(z), c)
            test(i + 1, z1, c, m)
        else
            i
        end
    end
end
