using InternedStrings

abstract type ABasic end

### Terms ###

struct Term#{T<:ABasic}  # Don't really need the specialisation
    class::T where T <: ABasic
    args::NTuple{N,Term} where N
end

abstract type AVariable <: ABasic end  # Atom

struct FreeVariable <: AVariable
    symbol::Symbol
end

# FreeVariable(symbol::Symbol) = FreeVariable(symbol)()

# function (p::FreeVariable)(x::NTuple{N,Term}) where N
#     Term(p, x)
# end

function (p::FreeVariable)(x...)
    Term(p, x)
end

struct RemovedVariable <: AVariable
    symbol::Symbol
    ref::Ref{UInt8}  # Will always be an empty reference. Just so RemovedVariable(:x) != RemovedVariable(:x)
end

RemovedVariable(symbol::Symbol) = RemovedVariable(symbol, Ref{UInt8}())

struct BoundVariable <: AVariable
    symbol::Symbol
    depth::Int64
end
