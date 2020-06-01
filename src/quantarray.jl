struct LinQuant16Array{N} <: AbstractArray{UInt16, N}
    A::AbstractArray{UInt16,N}
    min::Float64
    max::Float64
end

struct LinQuant24Array{N} <: AbstractArray{UInt32, N}
    A::AbstractArray{UInt32,N}
    min::Float64
    max::Float64
end

struct LogQuant16Array{N} <: AbstractArray{UInt16, N}
    A::AbstractArray{UInt16,N}
    min::Float64
    max::Float64
end

struct LogQuant24Array{N} <: AbstractArray{UInt32, N}
    A::AbstractArray{UInt32,N}
    min::Float64
    max::Float64
end

LinQuantArray = Union{LinQuant16Array,LinQuant24Array}
LogQuantArray = Union{LogQuant16Array,LogQuant24Array}
QuantArray = Union{LinQuantArray,LogQuantArray}

Base.size(QA::QuantArray) = size(QA.A)
Base.getindex(QA::QuantArray,i...) = getindex(QA.A,i...)
# Base.setindex!(QA::ScaledArray,x::Real,i...) = setindex!(SA.A,x,i...)

function LinQuant16Array(A::AbstractArray{T,N}) where {T,N}
    Amin = Float64(minimum(A))
    Amax = Float64(maximum(A))

    Δ = (Amax-Amin)/(2^16-1)
    lin16 = Array(Amin:Δ:Amax)
    lin16bounds = vcat(Amin,(lin16[1:end-1]+lin16[2:end])/2,Amax)

    Q = Array{UInt16,N}(undef,size(A)...)

    for i in eachindex(Q)
        Q[i] = findFirstSmaller(Float64(A[i]),lin16bounds)-1
    end

    return LinQuant16Array(Q,Amin,Amax)
end

function LinQuant24Array(A::AbstractArray{T,N}) where {T,N}
    Amin = Float64(minimum(A))
    Amax = Float64(maximum(A))

    Δ = (Amax-Amin)/(2^24-1)
    lin24 = Array(Amin:Δ:Amax)
    lin24bounds = vcat(Amin,(lin24[1:end-1]+lin24[2:end])/2,Amax)

    Q = Array{UInt32,N}(undef,size(A)...)

    for i in eachindex(Q)
        Q[i] = findFirstSmaller(Float64(A[i]),lin24bounds)-1
    end

    return LinQuant24Array(Q,Amin,Amax)
end
