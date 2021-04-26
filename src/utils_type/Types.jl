using SymbolicUtils

for f ∈ [:+, :-, :*, :/, :^] #Note, this is type piracy!
    @eval begin
        Base.$f(x::Union{Expr, Symbol}, y::Number) = Expr(:call, $f, x, y)
        Base.$f(x::Number, y::Union{Expr, Symbol}) = Expr(:call, $f, x, y)
        Base.$f(x::Union{Expr, Symbol}, y::Union{Expr, Symbol}) = (Expr(:call, $f, x, y))
    end
end


ex = 1 + (:x - 2)

SymbolicUtils.istree(ex::Expr) = ex.head == :call
SymbolicUtils.operation(ex::Expr) = ex.args[1]
SymbolicUtils.arguments(ex::Expr) = ex.args[2:end]

@rule(~x => ~x - 1)(ex)
SymbolicUtils.symtype(s::Expr) = Number
simplify(ex)
