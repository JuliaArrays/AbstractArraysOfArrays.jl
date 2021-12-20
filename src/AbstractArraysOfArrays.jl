# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).
"""
    AbstractArraysOfArrays

Lightweight package that defines an interface to invert functions.
"""
module AbstractArraysOfArrays

import Compat


@static if isdefined(Compat, :EachRow)
    # JuliaLang/Compat.jl/pull/663
    using Compat: EachRow
    using Compat: EachCol
else
    const EachRow{A,I} = Base.Generator{I,(typeof(eachrow(ones(Int32,2,2)).f).name.wrapper){A}}
    const EachCol{A,I} = Base.Generator{I,(typeof(eachcol(ones(Int32,2,2)).f).name.wrapper){A}}
    Base.parent(x::EachRow) = x.f.A
    Base.parent(x::EachCol) = x.f.A
end    

@static if isdefined(Compat, :EachSlice)
    # Not part of JuliaLang/Compat.jl/pull/663 yet, but hopefully will be:
    using Compat: EachSlice
else
    const EachSlice{A,I} = Base.Generator{I,<:(typeof(eachslice(ones(Int32,2,2), dims = 1).f).name.wrapper){A}}
    Base.parent(x::EachSlice) = x.f.A
end

@static if isdefined(Compat, :AbstractSlices)
    # Not part of JuliaLang/Compat.jl/pull/663 yet, but hopefully will be:
    using Compat: AbstractSlices
elseif isdefined(Base, :AbstractSlices)
    using Base: AbstractSlices
else
    abstract type AbstractSlices{T,N} <: AbstractArray{T,N} end
end

const SlicedArrayLike = Union{EachRow,EachCol,EachSlice,AbstractSlices}

include("slicemap.jl")

end # module
