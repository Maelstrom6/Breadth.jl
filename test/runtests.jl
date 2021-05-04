using Breadth
using Test
using SafeTestsets

@testset "Breadth.jl" begin
    @time @safetestset "Basics" begin include("Types.jl") end
end
