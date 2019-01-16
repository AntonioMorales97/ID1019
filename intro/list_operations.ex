defmodule ListOps do
    def nth(0, [head|_tail]) do
        head
    end
    def nth(n, [_head|tail]) do
        nth(n - 1, tail)
    end

    def len([]) do 0 end
    def len([_head|tail]) do
        1 + len(tail)
    end

    def sum([]) do 0 end
    def sum([head|tail]) do
        head + sum(tail)
    end

    def duplicate([]) do [] end
    def duplicate([head|tail]) do
        [head, head | duplicate(tail)]
    end

    def add(x, []) do [x] end
    def add(x, [x|tail]) do [x|tail] end
    def add(x, [head|tail]) do [head | add(x, tail)] end

    def remove(_, []) do [] end
    def remove(x, [x | tail]) do remove(x, tail) end
    def remove(x, [head | tail]) do [head | remove(x, tail)] end

    def unique([]) do [] end
    def unique([x | tail]) do [x | unique(remove(x, tail))] end

    #Returns a list of lists of equal elements
    def pack([]) do [] end
    def pack([x | tail]) do
        {all, rest} = match(x, tail, [x], [])
        [all | pack(rest)]
    end

    #Returns a list of all the instances matching x
    #and a list with the rest
    def match(_, [], all, rest) do {all, rest} end
    def match(x, [x | tail], all, rest) do
        match(x, tail, [x | all], rest)
    end
    def match(x, [y | tail], all, rest) do
        match(x, tail, all, [y | rest])
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

end
