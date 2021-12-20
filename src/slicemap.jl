# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).

"""
    getslicemap(slices)

Return the slicemap of `slices` in respect to `parent(slices)`.
"""
function getslicemap end
export getslicemap

@inline getslicemap(A::EachRow) = (1, :)
@inline getslicemap(A::EachCol) = (:, 1)
@inline getslicemap(A::EachSlice) = (A.f.inds_before..., 1, A.f.inds_after...)

@static if isdefined(Base, :Slices)
    @inline getslicemap(A::Slices) = A.slicemap
end
