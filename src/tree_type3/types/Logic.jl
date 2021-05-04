### Singletons ###
abstract type ALogicConstant <: AConstantSymbol end

# starts with capital so as not to conflict with `true`
@new_constant ALogicConstant ATrue True Statements
@new_constant ALogicConstant AFalse False Statements
# not yet computed
@new_constant ALogicConstant AUnknown Unknown Statements
# computed and the result could not be obtained within the constraints
@new_constant ALogicConstant AUnknowable Unknowable Statements

### Functions ###
abstract type ALogicFunction <: AFunctionSymbol end

@new_function(ALogicFunction, AAnd, And, (Statements, Statements), Statements, 2, ∧)
@new_function(ALogicFunction, AOr, Or, (Statements, Statements), Statements, 2, ∨)
@new_function(ALogicFunction, ANot, Not, (Statements,), Statements, 2, ~, false)
Base.show(io::IO, self::Term{<:ANot}) = print(io, "$(Meta.parse("$(data(self))($(args(self)[1]))"))")

@new_function(ALogicFunction, AImplies, Implies, (Statements, Statements), Statements, 2, ⟹)
@new_function(ALogicFunction, AEquivalent, Equivalent, (Statements, Statements), Statements, 2, ≡)

@new_function(ALogicFunction, AElementOf, ElementOf, (Ω, Sets), Statements, 2, ∈, false)
@new_function(ALogicFunction, ASubset, Subset, (Sets, Sets), Statements, 2, ⊂, false)

@new_function(ALogicFunction, AExists, Exists, (Ω, Sets, Statements), Statements, 3)
Exists(x::Term{ElementOf}, y::Term) = Exists(args(x)[1], args(x)[2], y)
Base.show(io::IO, self::Term{<:AExists}) = print(io, "Exists($(args(self)[1]) ∈ $(args(self)[2]), $(args(self)[3]))")

@new_function(ALogicFunction, AForAll, ForAll, (Ω, Sets, Statements), Statements, 3)
ForAll(x::Term{ElementOf}, y::Term) = ForAll(args(x)[1], args(x)[2], y)
Base.show(io::IO, self::Term{<:AForAll}) = print(io, "ForAll($(args(self)[1]) ∈ $(args(self)[2]), $(args(self)[3]))")
