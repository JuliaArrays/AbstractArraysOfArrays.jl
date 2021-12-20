# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).

import Test
import AbstractArraysOfArrays
import Documenter

Test.@testset "Package AbstractArraysOfArrays" begin
    include("test_api.jl")

    # doctests
    Documenter.DocMeta.setdocmeta!(
        AbstractArraysOfArrays,
        :DocTestSetup,
        :(using AbstractArraysOfArrays);
        recursive=true,
    )
    Documenter.doctest(AbstractArraysOfArrays)
end # testset
