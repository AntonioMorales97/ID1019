defmodule Backslang do

    #Backslang.translate_to_slang([?h, ?e, ?l, ?t, ?\s, ?o, ?b, ?e, ?g, ?r, ?i, ?p, ?l, ?i, ?g, ?t])
    def translate_to_slang([]) do [] end
    def translate_to_slang([h | t]) do
        case is_vowel(h) do
            true ->
                [h | translate_to_slang(t)]
            false ->
                [h, ?o, h | translate_to_slang(t)]
        end
    end

    #Backslang.translate_from_slang([?h, ?o, ?h, ?e, ?l, ?o, ?l, ?t, ?o, ?t, ?\s, ?o, ?b, ?o, ?b, ?e, ?g,
    #                               ?o, ?g, ?r, ?o, ?r, ?i, ?p, ?o, ?p, ?l, ?o, ?l, ?i, ?g, ?o, ?g, ?t, ?o, ?t])
    def translate_from_slang([]) do [] end
    def translate_from_slang([a, ?o, a | t]) do
        case is_vowel(a) do
            false ->
                [a | translate_from_slang(t)]
            true ->
                [a, ?o, a | translate_from_slang(t)]
        end
    end
    def translate_from_slang([h | t]) do
        [h | translate_from_slang(t)]
    end

    def is_vowel(a) do
        cond do
            a >= 66 && a <= 68 ->
                false

            a >= 70 && a <= 72 ->
                    false

            a >= 74 && a <= 78 ->
                    false

            a >= 80 && a <= 84 ->
                    false

            a >= 86 && a <= 90 ->
                    false

            a >= 98 && a <= 100 ->
                    false

            a >= 102 && a <= 104 ->
                    false

            a >= 106 && a <= 110 ->
                    false

            a >= 112 && a <= 116 ->
                    false

            a >= 118 && a <= 122 ->
                    false

            true -> true
        end
    end
end
