abstract type ATruth end

struct Axiom <: ATruth  # its id is the position in the truth table
    name::String
    left
    right
end
struct Definition <: ATruth
    name::String
    left
    right
end

struct Proof
    lines::Array{Tuple{Node,Int64,Array{Int64}}}
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
Base.:(==)(x::Proof, y::Proof) = ((steps(x)[end] in steps(y)) || (steps(y)[end] in steps(x)))
Base.hash(x::Proof) = hash(steps(x)[end])
extensions(x::Proof, truth_table=truths) = [Proof(push!(copy(lines(x)), re)) for re in rewrites_wp(steps(x)[end], Int64[], truth_table)]

struct Theorem <: ATruth
    name::String
    left
    right
    proof::Proof
end
name(x::ATruth) = x.name
