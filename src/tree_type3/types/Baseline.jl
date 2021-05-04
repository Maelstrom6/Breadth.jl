"""
The type of which all objects in the class are a subtype
"""
abstract type ABasic end

### Terms ###

struct Term{T<:ABasic}
    data::Symbol
    class::Type{T}
    args::NTuple{N,Term} where N
    hash::Ref{UInt}
end

# constructors
Term(data::Symbol, class::Type{<:ABasic}, args::NTuple{N,Term} where N) = Term(data, class, args, Ref{UInt}(0))
Term(data::Symbol, class::Type{<:ABasic}) = Term(data, class, ())

# helper functions for Term
data(self::Term) = self.data
class(self::Term) = self.class
func(self::Term) = func(class(self))
domain(::Term) = ∅
codomain(::Term) = ∅
args(self::Term) = self.args
export domain, codomain, arity

### Symbols ###
"""
function symbols and constant symbols
    """
abstract type AFixed <: ABasic end
"""
any "known" function with arity of one or more
    """
abstract type AFunctionSymbol <: AFixed end
"""
roots of trees can only ever be a subtype of this
can also be called singletons or atoms
"""
abstract type AConstantSymbol <: AFixed end
domain(::Term{<:AConstantSymbol}) = ∅

### Variables ###
"""
unknowns like `x` and `f`
all unknwons have domains (values that they can take in) and
a codomain (values that it can take on)
"""
abstract type AVariable <: ABasic end
struct Variable <: AVariable end

Variable(name::Symbol, codomain::Term) = Term(name, Variable, (codomain,))
Variable(name::String, codomain::Term) = Variable(Symbol(name), codomain)
Base.show(io::IO, self::Term{<:AVariable}) = print(io, data(self))
codomain(self::Term{<:AVariable}) = args(self)[1]
export Variable

struct FuncVariable <: AVariable end
FuncVariable(name::Symbol, domain::Term, codomain::Term) = Term(name, FuncVariable, (domain, codomain))
(f::Term{FuncVariable})(x...) = Term(data(f), FuncVariable, x)
domain(f::Term{<:FuncVariable}) = args(f)[1]
codomain(f::Term{<:FuncVariable}) = args(f)[2]
export FuncVariable

### Macros for new constants ###
macro new_constant(parent::Symbol, abstract_type::Symbol, name::Symbol)
    x = esc(name)
    return quote
        abstract type $(esc(abstract_type)) <: $(esc(parent)) end
        $(esc(name)) = Term($(Meta.quot(name)), $(esc(abstract_type)))
        Base.show(io::IO, x::Term{<:$(esc(abstract_type))}) = print(io, $(Meta.quot(name)))
        export $(esc(name))
    end
end

macro new_constant(parent::Symbol, abstract_type::Symbol, name::Symbol, codomain::Symbol)
    x = esc(name)
    return quote
        abstract type $(esc(abstract_type)) <: $(esc(parent)) end
        $(esc(name)) = Term($(Meta.quot(name)), $(esc(abstract_type)))
        Base.show(io::IO, x::Term{<:$(esc(abstract_type))}) = print(io, $(Meta.quot(name)))
        $(esc(:codomain))(::Term{<:$(esc(abstract_type))}) = $(esc(codomain))
        export $(esc(name))
    end
end

macro new_function(parent::Symbol, abstract_type::Symbol, name::Symbol, domain, codomain, arity)
    return quote
        abstract type $(esc(abstract_type)) <: $(esc(parent)) end
        struct $(esc(name)) <: $(esc(abstract_type)) end
        $(esc(name))(x::Vararg{Term}) = Term($(Meta.quot(name)), $(esc(name)), x)
        $(esc(:domain))(::Term{<:$(esc(abstract_type))}) = $(esc(domain))
        $(esc(:codomain))(::Term{<:$(esc(abstract_type))}) = $(esc(codomain))
        $(esc(:arity))(::Term{<:$(esc(abstract_type))}) = $(esc(arity))

        export $(esc(name))
    end
end

macro new_function(parent::Symbol, abstract_type::Symbol, name::Symbol, domain, codomain, arity, latex_name, should_export::Bool=true)
    if should_export
        return quote
            abstract type $(esc(abstract_type)) <: $(esc(parent)) end
            struct $(esc(name)) <: $(esc(abstract_type)) end
            $(esc(name))(x::Vararg{Term}) = Term($(Meta.quot(latex_name)), $(esc(name)), x)
            $(esc(:domain))(::Term{<:$(esc(abstract_type))}) = $(esc(domain))
            $(esc(:codomain))(::Term{<:$(esc(abstract_type))}) = $(esc(codomain))
            $(esc(:arity))(::Term{<:$(esc(abstract_type))}) = $(esc(arity))

            $(esc(latex_name))(x::Vararg{Term}) = $(esc(name))(x...)

            export $(esc(name)), $(esc(latex_name))
        end
    else
        return quote
            abstract type $(esc(abstract_type)) <: $(esc(parent)) end
            struct $(esc(name)) <: $(esc(abstract_type)) end
            $(esc(name))(x::Vararg{Term}) = Term($(Meta.quot(latex_name)), $(esc(name)), x)
            $(esc(:domain))(::Term{<:$(esc(abstract_type))}) = $(esc(domain))
            $(esc(:codomain))(::Term{<:$(esc(abstract_type))}) = $(esc(codomain))
            $(esc(:arity))(::Term{<:$(esc(abstract_type))}) = $(esc(arity))

            $(esc(latex_name))(x::Vararg{Term}) = $(esc(name))(x...)

            export $(esc(name))
        end
    end
end
