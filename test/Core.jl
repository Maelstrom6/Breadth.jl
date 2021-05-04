using Breadth
using Test

@testset "Baseline" begin
    @test 1 == 1
    x = Variable("x", Sets)
    println(x)
    println(x ∨ x)
    println(~x)
    println(ConditionSet(x, x))
end
