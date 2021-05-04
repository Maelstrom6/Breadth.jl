### Singletons ###
abstract type ASetConstant <: AConstantSymbol end

# abstract type AΩ <: ASetConstant end
# Ω = Term(Symbol("Ω"), AΩ)

# ∅ = Term(Symbol("∅"), ASetConstant)
@new_constant ASetConstant AΩ Ω Sets
@new_constant ASetConstant A∅ ∅ Sets
@new_constant ASetConstant AStatements Statements Sets
@new_constant ASetConstant ASets Sets Sets

### Functions ###
abstract type ASetFunction <: AFunctionSymbol end

@new_function(ASetFunction, ASetUnion, SetUnion, (ASets, ASets), ASets, 2, ∪, false)
@new_function(ASetFunction, ASetIntersection, SetIntersection, (ASets, ASets), ASets, 2, ∩, false)
@new_function(ASetFunction, ASetDifference, SetDifference, (ASets, ASets), ASets, 2, -, false)

@new_function(ASetFunction, AConditionSet, ConditionSet, (AVariable, AStatements), ASets, 2)
ConditionSet(x::Term, condition::Term) = Term(:ConditionSet, AConditionSet, (x, condition))  # {x | condition}
Base.show(io::IO, self::Term{<:AConditionSet}) = print(io, "$(Meta.parse("$(data(self))($(args(self)[1]), $(args(self)[2]))"))")
