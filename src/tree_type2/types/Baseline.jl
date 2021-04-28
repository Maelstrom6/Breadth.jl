abstract type ABasic end

struct Node{T<:ABasic}
    data::String
    class::Type{T}
    args::NTuple{N,Node} where N  # array does not work since Node([]]) == Node([]]) returns false
end
Node(data::String, class::Type{<:ABasic}) = Node(data, class, ())
data(self::Node) = self.data
class(self::Node) = self.class
args(self::Node) = self.args

abstract type ANode <: ABasic end
abstract type AAtom <: ANode end
abstract type AOperator <: ANode end

abstract type AUnknown <: AAtom end
abstract type AVariable <: AUnknown end
struct Variable{T} <: AVariable
end

abstract type AWild <: AUnknown end
struct Wild{T} <: AWild
end

abstract type ASingleton <: AAtom end

abstract type ASingletonStatement <: ASingleton end
abstract type ASingletonSet <: ASingleton end
abstract type ASingletonExpression <: ASingleton end

wild_symbol(name::String, set::Type{<:ASingletonSet}) = Node(name, Wild{set})
wild_symbol(name::String, set::Node) = Node(name, Wild{class(set)})

symbol(name::String, set::Type{<:ASingletonSet}) = Node(name, Variable{set})
symbol(name::String, set::Node) = Node(name, Variable{class(set)})
export symbol

# External types
abstract type ANonBasic <: ABasic end
convert(::Type{Node}, x::Number) = Node(String(x), ANonBasic)
