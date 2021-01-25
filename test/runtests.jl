using Breadth
using Test
using SafeTestsets

@testset "Breadth.jl" begin
    @time @safetestset "Core" begin include("Core.jl") end
end
