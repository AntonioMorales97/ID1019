defmodule Color do
    def convert(depth, max) do
        red(depth, max)
        #long_rainbow(depth, max)
    end

    def red(depth, max) do
        f = depth / max
        a = f * 4
        x = trunc(a)
        y = trunc(255 * (a - x))
        case x do
          0 ->
            {:rgb, y, 0, 0}

          1 ->
            {:rgb, 255, y, 0}

          2 ->
            {:rgb, 255 - y, 255, 0}

          3 ->
            {:rgb, 0, 255, y}

          4 ->
            {:rgb, 0, 255 - y, 255}
        end
    end

    def long_rainbow(depth, max) do
        f = depth/max
        a = (1- f) * 5 #0 map to blue and 1 to red, invert and group
        x = trunc(a)
        y = trunc(255 * (a - x))
        case x do
            0 ->
                {:rgb, 255, y, 0}
            1 ->
                {:rgb, 255 - y, 255, 0}
            2 ->
                {:rgb, 0, 255, y}
            3 ->
                {:rgb, 0, 255 - y, 255}
            4 ->
                {:rgb, y, 0, 255}
            5 ->
                {:rgb, 255, 0, 255}
            true ->
                :error
        end
    end
end
