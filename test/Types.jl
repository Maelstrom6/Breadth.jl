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
