TRUE = Node("TRUE", ASingletonStatement)
FALSE = Node("FALSE", ASingletonStatement)
UNKNOWN = Node("UNKNOWN", ASingletonStatement)



macro singleton_set(parent::Symbol, abstract_type::Symbol, name::Symbol)
    return quote
        abstract type $(esc(abstract_type)) <: $(esc(parent)) end
        $(esc(name)) = Node($(String(name)), $(esc(abstract_type)))
    end
end


@singleton_set ASingletonSet AΩ Ω
@singleton_set AΩ AStatements Statements
@singleton_set AΩ ASets Sets
# @singleton_set AΩ AFunctions Functions
abstract type AFunctions{T} <: AΩ where T end
Functions(set) = Node("Functions", AFunctions{typeof(set)})  # the set of functions whose ouput is an element of set
@singleton_set AΩ ANumbers Numbers


@singleton_set AΩ A∅ ∅
@singleton_set AΩ Aℝ ℝ

quick_range(::Type{<:ABasic}) = AΩ
quick_range(::Type{<:ALogicOperator}) = AStatements
quick_range(::Type{<:ASetOperator}) = ASets
quick_range(::Type{<:AExpressionOperator}) = ANumbers
quick_range(x::Type{<:AUnknown}) = x.parameters[1]
quick_range(::Type{<:ASingletonSet}) = ASets
quick_range(::Type{<:ASingletonStatement}) = AStatements

quick_range(x::Node) = quick_range(class(x))
