# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).

# ToDo: Use types from JuliaLang/julia#32310, once merged.

# To be replaced by Compat.EachRow and Compat.EachCol (JuliaLang/Compat.jl#663):
const EachRow{A,I} = Union{Base.Generator{I,(typeof(eachrow(ones(Int32,2,2)).f).name.wrapper){A}}, Base.Generator{I,(typeof(eachrow(ones(Int32,2,2)).f).name.wrapper){A}}}
const EachCol{A,I} = Base.Generator{I,(typeof(eachcol(ones(Int32,2,2)).f).name.wrapper){A}}


"""
    CompactArrayOfSimilarArrays{T,M,N} <: AbstractArray{<:AbstractArray{T,M},N}

An array that contains arrays that have the same size/axes. The array must
internally be stored in flattened form as some kind of array of dimension
`M + N` and offer access to the flattened form can be accessed via
`flatview(A)`.

Subtypes must implement (in addition to typical array operations):

    flatview(A::SomeArrayOfSimilarArrays)::AbstractArray{T,M+N}

and should specialize

    flatview(A::SomeArrayOfSimilarArrays)::AbstractArray{T,M+N}

The following type aliases are defined:

* `AbstractVectorOfSimilarArrays{T,M} = CompactArrayOfSimilarArrays{T,M,1}`
* `CompactArrayOfSimilarVectors{T,N} = CompactArrayOfSimilarArrays{T,1,N}`
* `CompactVectorOfSimilarVectors{T} = CompactArrayOfSimilarArrays{T,1,1}`
"""
abstract type CompactArrayOfSimilarArrays{T,M,N} <: AbstractArray{Array{T,M},N} end
export CompactArrayOfSimilarArrays

const AbstractVectorOfSimilarArrays{T,M} = CompactArrayOfSimilarArrays{T,M,1}
export AbstractVectorOfSimilarArrays

const CompactArrayOfSimilarVectors{T,N} = CompactArrayOfSimilarArrays{T,1,N}
export CompactArrayOfSimilarVectors

const CompactVectorOfSimilarVectors{T} = CompactArrayOfSimilarArrays{T,1,1}
export CompactVectorOfSimilarVectors



"""
    CollectionOfArrays = Union{CompactArrayOfSimilarArrays, EachRow, EachCol}

A collection of similar arrays that is internally stored in flattened
form as some kind of higher-dimensional array.
"""
const CollectionOfArrays = Union{AbstractArray{<:AbstractArray}, CompactCollectionOfSimilarArrays, CompactCollectionOfArrays}
export CompactCollectionOfSimilarArrays


"""
    CompactCollectionOfSimilarArrays = Union{CompactArrayOfSimilarArrays, EachRow, EachCol}

A collection of similar arrays that is internally stored in flattened
form as some kind of higher-dimensional array.
"""
const CompactCollectionOfSimilarArrays = Union{CompactArrayOfSimilarArrays, EachRow, EachCol}
export CompactCollectionOfSimilarArrays
