abstract type ALogicOperator <: AOperator end
abstract type AAnd <: ALogicOperator end
struct And <: AAnd
end
∧(x::Node, y::Node) = Node("∧", AAnd, (x, y))
export ∧

abstract type AForAll <: ALogicOperator end
ForAll(variable::Node, set::Node, statement::Node) = Node("A", AForAll, (variable, set, statement))

abstract type AOr <: ALogicOperator end
struct Or <: AOr
end
∨(x::Node, y::Node) = Node("∨", AOr, (x, y))
export ∨

abstract type AExists <: ALogicOperator end
Exists(variable::Node, set::Node, statement::Node) = Node("E", AOr, (variable, set, statement))
export Exists

abstract type ANot <: ALogicOperator end
struct Not <: ANot
end
Base.:(~)(x::Node) = Node("~", ANot, (x,))

abstract type AImplies <: ALogicOperator end
struct Implies <: AImplies
end
⟹(x::Node, y::Node) = Node("⟹", AImplies, (x, y))
export ⟹

abstract type AEquivalent <: ALogicOperator end
struct Equivalent <: AEquivalent
end
≡(x::Node, y::Node) = Node("≡", AEquivalent, (x, y))
export ≡

abstract type ASubset <: ALogicOperator end
struct Subset <: ASubset
end
⊂(x::Node, y::Node) = Node("⊂", ASubset, (x, y))
export ⊂

abstract type AElementOf <: ALogicOperator end
struct ElementOf <: AElementOf
end
∈(x::Node, y::Node) = Node("∈", AElementOf, (x, y))
export ∈
