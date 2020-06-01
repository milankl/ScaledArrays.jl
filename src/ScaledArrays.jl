module ScaledArrays

    export ScaledArray, unscale, rescale,
            LinQuant16Array, LinQuant24Array

    include("scaledarray.jl")
    include("binarytree.jl")
    include("quantarray.jl")
end
