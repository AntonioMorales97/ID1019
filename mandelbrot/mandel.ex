defmodule Mandel do
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end

        rows(width, height, trans, depth, [])
    end

    def rows(_, 0, _, _, rows) do rows end
    def rows(w, h, trans, d, rows) do
        row = row(w, h, trans, d, [])
        rows(w, h - 1, trans, d, [row | rows])
    end

    def row(0, _, _, _, row) do row end
    def row(w, h, trans, d, row) do
        c = trans.(w, h)
        resMandelSet = Brot.mandelbrot(c, d)
        color = Color.convert(resMandelSet, d)
        row(w - 1, h, trans, d, [color | row])
    end

end
