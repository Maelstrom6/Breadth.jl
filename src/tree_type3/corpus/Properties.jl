macro associative(f::Symbol, x::Symbol, y::Symbol, z::Symbol)
    return quote
        $(esc(f))($(esc(f))($(esc(x)), $(esc(y))), $(esc(z))) ⩶
        $(esc(f))($(esc(x)), $(esc(f))($(esc(y)), $(esc(z))))
    end
end

"""
f is commutative if f(x, y) = f(y, x)
"""
macro commutative(f::Symbol, x::Symbol, y::Symbol)
    return quote
        $(esc(f))($(esc(x)), $(esc(y))) ⩶
        $(esc(f))($(esc(y)), $(esc(x)))
    end
end

"""
A function f is left distributive over g if f(x, g(y, z)) = g(f(x, y), f(x, z))
"""
macro distributive(f::Symbol, g::Symbol, x::Symbol, y::Symbol, z::Symbol)
    return quote
        $(esc(f))($(esc(x)), $(esc(g))($(esc(y)), $(esc(z)))) ⩶
        $(esc(g))($(esc(f))($(esc(x)), $(esc(y))), $(esc(f))($(esc(x)), $(esc(z))))
    end
end

"""
A function f is left factorisable over g iff f(g(x, y), g(x, z)) = g(x, f(y, z))
"""
macro factorisable(f::Symbol, g::Symbol, x::Symbol, y::Symbol, z::Symbol)
    return quote
        $(esc(f))($(esc(g))($(esc(x)), $(esc(y))), $(esc(g))($(esc(x)), $(esc(z)))) ⩶
        $(esc(g))($(esc(x)), $(esc(f))($(esc(y)), $(esc(z))))
    end
end

"""
f is idempotent if f(x, x) = x
"""
macro idempotent(f::Symbol, x::Symbol)
    return quote
        $(esc(f))($(esc(x)), $(esc(x))) ⩶ $(esc(x))
    end
end

"""
A function f is invloute if f(f(x)) = x
"""
macro involute(f::Symbol, x::Symbol)
    return quote
        $(esc(f))($(esc(f))($(esc(x)))) ⩶ $(esc(x))
    end
end
