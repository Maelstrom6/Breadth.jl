using Breadth
using Test

@testset "Baseline" begin
    # check for no errors basically for all functions
    x = Variable("x", Statements)
    y = Variable(:y, Statements)
    @test x == Variable(:x, Statements)
    println(x)
    println(x ∨ y)
    println(x ∧ y)
    println(~x)
    println(domain(x))
    println(codomain(x))
    println(domain(x ∨ x))
    println(codomain(x ∨ x))
    println(domain(~x))
    println(codomain(~x))
end

@testset "Theorems" begin
    x = Variable("x", Statements)
    y = Variable("y", Statements)
    println(isapplicable((x ∧ y) ∨ x, x ∧ y))
    println(rewrites(x ∨ x))
end

@testset "Proving" begin
    x = Variable("x", Statements)
    y = Variable("y", Statements)
    A = Variable("A", Sets)
    B = Variable("B", Sets)
    println(result(x ∈ (A ∩ B), ((x ∈ A) ∧ (x ∈ B))))
    println(result((x ∨ True) ∧ False))
    println(result(~(x ∨ y), ~x ∧ ~y))  # De Morgan
    println(result(~x ∧ ~y, ~(x ∨ y)))

    println(result(x ∈ (A ∩ B), ((x ∈ A) ∧ (x ∈ B))))
    println(result(x ∈ (A ∩ B), x ∈ (A ∪ B)))
end

@testset "Old proving" begin
    using Breadth: x, A, B, C, result, result_wp, ⊂, TRUE, FALSE, ⟹, ∧, ∨, P, Q, rewrites, rewrites_wp
    println(result_wp(x ∈ (A ∩ B), x ∈ (A ∪ B), 3))
    """
    x ∈ A ∩ B because Given
    (x ∈ A) ∧ (x ∈ B) because Definition of Element Of
    (x ∈ A) ∨ (x ∈ B) because Or is the weaker And
    x ∈ A ∪ B because Definition of Element Of
    """
    # println(result_wp(((A ∩ B) ⊂ (A ∪ B)) ∧ (x ∈ (A ∩ B) ⟹ x ∈ (A ∪ B)), TRUE, 4))
    A ∧ (~A ∨ B)
    (A ∧ ~A) ∨ (A ∨ B)
    result_wp(P ∧ (P ⟹ Q), Q, 5)
    result_wp(P ∧ (P ⟹ Q), P ∧ (~P ∨ Q), 5)
    result_wp(P ∧ (~P ∨ Q), FALSE ∨ (P ∧ Q), 5)
    result_wp(FALSE ∨ (P ∧ Q), P ∧ Q, 5)
    result_wp((P ∧ Q) ⟹ Q, TRUE, 5)
    result_wp((P ∧ Q) ⟹ Q, (~P ∨ ~Q) ∨ Q, 5)
    result_wp((~P ∨ ~Q) ∨ Q, ~P ∨ (Q ∨ ~Q),2 )
    result_wp(~P ∨ (Q ∨ ~Q), TRUE,2 )

    # println(result_wp((A ∩ B) ⊂ (A ∪ B), TRUE, 4))  # need to add the above proof
end
