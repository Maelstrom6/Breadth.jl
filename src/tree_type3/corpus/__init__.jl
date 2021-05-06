A = Variable("WildA", Sets)
B = Variable("WildB", Sets)
f = FuncVariable("Wildf", Statements, Statements)

P = Variable("WildP", Statements)
Q = Variable("WildQ", Statements)
R = Variable("WildR", Statements)

x = Variable("Wildx", Ω)
y = Variable("Wildy", Ω)
z = Variable("Wildz", Ω)

abstract type ATruth end

struct Axiom <: ATruth  # its id is the position in the truth table
    name::String
    statement::Term
end
struct Definition <: ATruth
    name::String
    statement::Term
end

struct Proof
    lines::Array{Tuple{Term,Int64,Array{Int64}}}
end
lines(x::Proof) = x.lines
steps(x::Proof) = [line[1] for line in x.lines]
function english(x::Proof)
    result = ""
    for line in lines(x)
        result *= "$(line[1]) because $(name(truths[line[2]]))\n"
    end
    return result
end
Base.hash(x::Proof, h::UInt) = hash(steps(x)[end], h)
Base.:(==)(x::Proof, y::Proof) = steps(x)[end] == steps(y)[end]
extensions(x::Proof, truth_table=truths) = [Proof(push!(copy(lines(x)), re)) for re in rewrites_wp(steps(x)[end], Int64[], truth_table)]

struct Theorem <: ATruth
    name::String
    statement::Term
    proof::Proof
end
name(x::ATruth) = x.name

truths = ATruth[
    Axiom("Given", P ⩶ P),
]

include("Properties.jl")

include("Logic.jl")
include("SetTheory.jl")
