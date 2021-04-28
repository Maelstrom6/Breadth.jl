"""
https://github.com/JuliaLang/julia/blob/master/src/julia-parser.scm

"""
s = "= += -= *= /= //= |\\=| ^= ÷= %= <<= >>= >>>= ||=| &= ⊻= ≔ ⩴ ≕ ~ := \$= => "

bodmas(self::Node)::Int64 = bodmas(class(self))

bodmas(self::Node{<:AAnd})::Int64 = 10
bodmas(self::Node{<:AOr})::Int64 = 11

