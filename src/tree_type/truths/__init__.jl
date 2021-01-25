A = wild_symbol("WildA", Sets)
B = wild_symbol("WildB", Sets)
f = wild_symbol("Wildf", Functions(Statements))

P = wild_symbol("WildP", Statements)
Q = wild_symbol("WildQ", Statements)
R = wild_symbol("WildR", Statements)

x = wild_symbol("Wildx", AΩ)
y = wild_symbol("Wildy", AΩ)
z = wild_symbol("Wildz", AΩ)

_x = symbol("_x", AΩ)
_y = symbol("_y", AΩ)

truths = ATruth[
    Axiom("Given", P, P),
]

include("Properties.jl")

include("Logic.jl")
append!(truths, logic)

include("SetTheory.jl")
append!(truths, set_theory)
