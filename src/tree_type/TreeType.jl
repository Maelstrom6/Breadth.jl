"""
A sub-module for a specific idea for how the basics of Breadth works.
"""

include("Types.jl")
include("Singletons.jl")
include("Proving.jl")
include("truths/__init__.jl")
include("Provers.jl")

P = symbol("P", Statements)
Q = symbol("Q", Statements)
R = symbol("R", Statements)

x = symbol("x", Statements)
A = symbol("A", Sets)
B = symbol("B", Sets)
C = symbol("C", Sets)
