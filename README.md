# ScaledArrays

[![Build Status](https://travis-ci.com/milankl/ScaledArrays.jl.svg?branch=master)](https://travis-ci.com/milankl/ScaledArrays.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/milankl/ScaledArrays.jl?svg=true)](https://ci.appveyor.com/project/milankl/ScaledArrays-jl)

Store both an Array `A` and a scale `s` together in a ScaledArray `SA = s*A`, such that for example `SA1*SA2 = (s1*s2)*A1*A2`. The arrays are supposed to have elements O(1), whereas the scale `s` is supposed to carry the magnitude.

Use `unscale` to unscale `SA` (i.e. `s=1`) and `rescale` to change `s`.

### Example

```julia
julia> using ScaledArrays

julia> SA = ScaledArray(rand(3,3),100)
3×3 ScaledArray{Float64,2}:
 0.354352  0.360733  0.0441772
 0.39473   0.499311  0.560835
 0.392939  0.245807  0.0387673

julia> unscale(SA)
3×3 ScaledArray{Float64,2}:
 35.4352  36.0733   4.41772
 39.473   49.9311  56.0835
 39.2939  24.5807   3.87673

julia> rescale(SA,2)
3×3 ScaledArray{Float64,2}:
 17.7176  18.0367   2.20886
 19.7365  24.9655  28.0417
 19.647   12.2903   1.93837

julia> SA² = SA*SA
3×3 ScaledArray{Float64,2}:
 0.285316  0.318804  0.219679
 0.55734   0.529561  0.319211
 0.251499  0.27401   0.156719

julia> SA².s
10000.0
```
