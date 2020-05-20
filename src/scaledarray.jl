struct ScaledArray{T<:AbstractFloat, N} <: AbstractArray{T, N}
    A::AbstractArray{T,N}
    s::T
end

Base.size(SA::ScaledArray{T,N}) where {T,N} = size(SA.A)
Base.getindex(SA::ScaledArray,i...) = getindex(SA.A,i...)
Base.setindex!(SA::ScaledArray,x::Real,i...) = setindex!(SA.A,x,i...)

ScaledArray(A::AbstractArray) = ScaledArray(A,one(eltype(A)))
ScaledArray(A::AbstractArray{T},s::Real) where T = ScaledArray(A,T(s))

unscale(SA::ScaledArray{T,N}) where {T,N} = ScaledArray(SA.A*SA.s,one(T))
rescale(SA::ScaledArray{T,N},s::Real) where {T,N} = ScaledArray(SA.A*(SA.s/T(s)),T(s))

Base.:(*)(X::ScaledArray{T,N},Y::ScaledArray{T,N}) where {T,N} = ScaledArray(X.A*Y.A,X.s*Y.s)
