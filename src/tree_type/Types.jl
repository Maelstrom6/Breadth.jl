
abstract type ABasic end

struct Node
    data::String
    class::Type{<:ABasic}
    args::NTuple{N,Node} where N  # array does not work since Node([]]) == Node([]]) returns false
end
Node(data::String, class::Type{<:ABasic}) = Node(data, class, ())
data(self::Node) = self.data
class(self::Node) = self.class
args(self::Node) = self.args



function Base.show(io::IO, self::Node)
    _show(io, self, class(self))
end
_show(io::IO, self::Node, ::Type{<:Any}) = print(io, "$(Meta.parse("($(args(self)[1])) $(data(self)) ($(args(self)[2]))"))")

abstract type ANode <: ABasic end
abstract type AAtom <: ANode end
abstract type AOperator <: ANode end

abstract type AUnknown <: AAtom end
abstract type AVariable <: AUnknown end
struct Variable{T} <: AVariable where T
end
_show(io::IO, self::Node, ::Type{<:AAtom}) = print(io, data(self))

# Only used for truth table purposes
abstract type AWild <: AUnknown end
struct Wild{T} <: AWild where T
end

abstract type ACall <: AOperator end
function (f::Node)(x::Node)
    return Node("()", ACall, (f, x))
end
function (f::Node)(Vararg...)
    return Node("()", f, Vararg)
end
_show(io::IO, self::Node, ::Type{<:ACall}) = print(io, "$(Meta.parse("$(args(self)[1])($(args(self)[2]))"))")

abstract type ASingleton <: AAtom end
abstract type ASingletonStatement <: ASingleton end
abstract type ASingletonSet <: ASingleton end

abstract type ASingletonExpression <: ASingleton end

wild_symbol(name::String, set::Type{<:ASingletonSet}) = Node(name, Wild{set})
wild_symbol(name::String, set::Node) = Node(name, Wild{class(set)})

symbol(name::String, set::Type{<:ASingletonSet}) = Node(name, Variable{set})
symbol(name::String, set::Node) = Node(name, Variable{class(set)})

# External types
abstract type ANonBasic <: ABasic end
convert(::Type{Node}, x::Number) = Node(String(x), ANonBasic)

abstract type ALogicOperator <: AOperator end
abstract type AAnd <: ALogicOperator end
struct And <: AAnd
end
∧(x::Node, y::Node) = Node("∧", AAnd, (x, y))

abstract type AForAll <: ALogicOperator end
ForAll(variable::Node, set::Node, statement::Node) = Node("A", AForAll, (variable, set, statement))

abstract type AOr <: ALogicOperator end
struct Or <: AOr
end
∨(x::Node, y::Node) = Node("∨", AOr, (x, y))

abstract type AExists <: ALogicOperator end
Exists(variable::Node, set::Node, statement::Node) = Node("E", AOr, (variable, set, statement))

abstract type ANot <: ALogicOperator end
struct Not <: ANot
end
~(x::Node) = Node("~", ANot, (x,))
_show(io::IO, self::Node, ::Type{<:ANot}) = print(io, "$(Meta.parse("$(data(self))($(args(self)[1]))"))")

abstract type AImplies <: ALogicOperator end
struct Implies <: AImplies
end
⟹(x::Node, y::Node) = Node("⟹", AImplies, (x, y))

abstract type AEquivalent <: ALogicOperator end
struct Equivalent <: AEquivalent
end
≡(x::Node, y::Node) = Node("≡", AEquivalent, (x, y))

abstract type ASubset <: ALogicOperator end
struct Subset <: ASubset
end
⊂(x::Node, y::Node) = Node("⊂", ASubset, (x, y))

abstract type AElementOf <: ALogicOperator end
struct ElementOf <: AElementOf
end
∈(x::Node, y::Node) = Node("∈", AElementOf, (x, y))

abstract type ASetOperator <: AOperator end
abstract type ASetUnion <: ASetOperator end
struct SetUnion <: ASetUnion
end
∪(x::Node, y::Node) = Node("∪", ASetUnion, (x, y))

abstract type ASetIntersection <: ASetOperator end
struct SetIntersection <: ASetIntersection
end
∩(x::Node, y::Node) = Node("∩", ASetIntersection, (x, y))

abstract type ASetDifference <: ASetOperator end
struct SetDifference <: ASetDifference
end

abstract type AConditionSet <: ASetOperator end
struct ConditionSet <: AConditionSet
end
ConditionSet(x::Node, condition::Node) = Node("|", AConditionSet, (x, condition))  # {x | condition}
_show(io::IO, self::Node, ::Type{<:AConditionSet}) = print(io, "$(Meta.parse("ConditionSet($(args(self)[1]), $(args(self)[2]))"))")

abstract type AExpressionOperator <: AOperator end
