using Breadth: x, A, B, C, result, result_wp, ⊂, TRUE, FALSE, ⟹, ∧, ∨, P, Q, rewrites, rewrites_wp
using Test

@testset "Baseline" begin
    # check for no errors basically for all functions
    println(result((~P ∨ ~Q) ∨ Q, ~P ∨ (Q ∨ ~Q), 1))
    println(result_wp((~P ∨ ~Q) ∨ Q, ~P ∨ (Q ∨ ~Q), 1))
end
Breadth.Node[(~P ∨ ~Q) ∨ Q,
~P ∨ (~Q ∨ Q),
Q ∨ (~P ∨ ~Q),
~(~(~P ∨ ~Q) ∧ ~Q),
~(~((~P ∨ ~Q) ∨ Q)),
(~Q ∨ ~P) ∨ Q,
~(~(~P) ∧ ~(~Q)) ∨ Q,
~(~(~P ∨ ~Q)) ∨ Q,
(P ⟹ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q,
(~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ ~(~Q)]

Breadth.Node[(~P ∨ ~Q) ∨ Q,
~P ∨ (~Q ∨ Q),
Q ∨ (~P ∨ ~Q),
~(~((~P ∨ ~Q) ∨ Q)), (~Q ∨ ~P) ∨ Q, ~(~(~P) ∧ ~(~Q)) ∨ Q, ~(~(~P ∨ ~Q)) ∨ Q, (P ⟹ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ ~(~Q)]

Breadth.Node[(~P ∨ ~Q) ∨ Q, ~P ∨ (~Q ∨ Q), Q ∨ (~P ∨ ~Q), ~(~(~P ∨ ~Q) ∧ ~Q), ~(~((~P ∨ ~Q) ∨ Q)), (~P ∨ ~Q) ∨ Q, (~Q ∨ ~P) ∨ Q, ~(~(~P) ∧ ~(~Q)) ∨ Q, ~(~(~P ∨ ~Q)) ∨ Q, (P ⟹ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ ~(~Q)]

Breadth.Node[(~P ∨ ~Q) ∨ Q, ~P ∨ (~Q ∨ Q), Q ∨ (~P ∨ ~Q), ~(~(~P ∨ ~Q) ∧ ~Q), ~(~((~P ∨ ~Q) ∨ Q)), (~P ∨ ~Q) ∨ Q, (~Q ∨ ~P) ∨ Q, ~(~(~P) ∧ ~(~Q)) ∨ Q, ~(~(~P ∨ ~Q)) ∨ Q, (P ⟹ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ ~(~Q)]
Breadth.Node[(~P ∨ ~Q) ∨ Q, ~P ∨ (~Q ∨ Q), Q ∨ (~P ∨ ~Q), ~(~(~P ∨ ~Q) ∧ ~Q), ~(~((~P ∨ ~Q) ∨ Q)), (~P ∨ ~Q) ∨ Q, (~Q ∨ ~P) ∨ Q, ~(~(~P) ∧ ~(~Q)) ∨ Q, ~(~(~P ∨ ~Q)) ∨ Q, (P ⟹ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ ~(~Q)]
Breadth.Node[(~P ∨ ~Q) ∨ Q, ~P ∨ (~Q ∨ Q), Q ∨ (~P ∨ ~Q), ~(~(~P ∨ ~Q) ∧ ~Q), ~(~((~P ∨ ~Q) ∨ Q)), (~P ∨ ~Q) ∨ Q, (~Q ∨ ~P) ∨ Q, ~(~(~P) ∧ ~(~Q)) ∨ Q, ~(~(~P ∨ ~Q)) ∨ Q, (P ⟹ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~(~(~P)) ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~(~(~Q))) ∨ Q, (~P ∨ ~Q) ∨ Q, (~P ∨ ~Q) ∨ ~(~Q)]
@testset "BUG" begin
    new_values = Any[Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~P ∨ (~Q ∨ Q), 20, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (Q ∨ (~P ∨ ~Q), 22, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~(~P ∨ ~Q) ∧ ~Q), 24, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~((~P ∨ ~Q) ∨ Q)), 35, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~Q ∨ ~P) ∨ Q, 22, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~(~P) ∧ ~(~Q)) ∨ Q, 24, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~(~P ∨ ~Q)) ∨ Q, 35, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((P ⟹ ~Q) ∨ Q, 37, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~(~(~P)) ∨ ~Q) ∨ Q, 35, [1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~(~(~P)) ∨ ~Q) ∨ Q, 35, [1, 1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 2])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~(~(~Q))) ∨ Q, 35, [1, 2])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 2, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~(~(~Q))) ∨ Q, 35, [1, 2, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [2])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ ~(~Q), 35, [2])])]
    new_values = Any[Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~P ∨ (~Q ∨ Q), 20, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (Q ∨ (~P ∨ ~Q), 22, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~(~P ∨ ~Q) ∧ ~Q), 24, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~((~P ∨ ~Q) ∨ Q)), 35, [])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~Q ∨ ~P) ∨ Q, 22, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~(~P) ∧ ~(~Q)) ∨ Q, 24, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), (~(~(~P ∨ ~Q)) ∨ Q, 35, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((P ⟹ ~Q) ∨ Q, 37, [1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~(~(~P)) ∨ ~Q) ∨ Q, 35, [1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~(~(~P)) ∨ ~Q) ∨ Q, 35, [1, 1, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 2])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~(~(~Q))) ∨ Q, 35, [1, 2])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [1, 2, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~(~(~Q))) ∨ Q, 35, [1, 2, 1])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ Q, 1, [2])]), Breadth.Proof(Tuple{Breadth.Node,Int64,Array{Int64,N} where N}[((~P ∨ ~Q) ∨ Q, 1, []), ((~P ∨ ~Q) ∨ ~(~Q), 35, [2])])]
    last_steps = [steps(x)[end] for x in new_values]
    println(length(unique(new_values)))
    println(length(unique(last_steps)))
    print(setdiff(new_values, last_steps))
end
