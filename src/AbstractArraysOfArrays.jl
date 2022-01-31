# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).

"""
    AbstractArraysOfArrays

Lightweight package that defines an abstract types and functions
for nested arrays.
"""
module AbstractArraysOfArrays

using Test

include("functions.jl")
include("similar_arrays.jl")
include("test_utils.jl")

end # module
