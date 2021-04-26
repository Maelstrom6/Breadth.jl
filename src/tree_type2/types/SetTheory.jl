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
