using ScaledArrays
using Test

@testset "ScaledArrays.jl" begin
    R = rand(2,2)
    SA = ScaledArray(R)
    @test SA.s == 1.0
    @test SA*SA == R*R

    SA2 = ScaledArray(R,1/100)
    SAunscaled = unscale(SA2)
    @test all(SAunscaled .<= 1/100)

    SAscaled = rescale(SAunscaled,1/100)
    @test SAscaled ≈ SA2
end
