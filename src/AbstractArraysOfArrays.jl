# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).
"""
    AbstractArraysOfArrays

Lightweight package that defines an interface to invert functions.
"""
module AbstractArraysOfArrays

using Test

include("functions.jl")
include("inverse.jl")
include("test.jl")

end # module
