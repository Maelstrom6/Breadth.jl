A = Variable("WildA", Sets)
B = Variable("WildB", Sets)
f = Variable("Wildf", Functions(Statements))

P = Variable("WildP", Statements)
Q = Variable("WildQ", Statements)
R = Variable("WildR", Statements)

x = Variable("Wildx", AΩ)
y = Variable("Wildy", AΩ)
z = Variable("Wildz", AΩ)

truths = ATruth[
    Axiom("Given", P, P),
]

include("Properties.jl")

include("Logic.jl")
append!(truths, logic)

include("SetTheory.jl")
append!(truths, set_theory)
