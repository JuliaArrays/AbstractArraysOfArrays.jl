# Use
#
#     DOCUMENTER_DEBUG=true julia --color=yes make.jl local [nonstrict] [fixdoctests]
#
# for local builds.

using Documenter
using AbstractArraysOfArrays

# Doctest setup
DocMeta.setdocmeta!(
    AbstractArraysOfArrays,
    :DocTestSetup,
    :(using AbstractArraysOfArrays);
    recursive=true,
)

makedocs(
    sitename = "AbstractArraysOfArrays",
    modules = [AbstractArraysOfArrays],
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        canonical = "https://JuliaArrays.github.io/AbstractArraysOfArrays.jl/stable/"
    ),
    pages = [
        "Home" => "index.md",
        "API" => "api.md",
        "LICENSE" => "LICENSE.md",
    ],
    doctest = ("fixdoctests" in ARGS) ? :fix : true,
    linkcheck = !("nonstrict" in ARGS),
    strict = !("nonstrict" in ARGS),
)

deploydocs(
    repo = "github.com/JuliaArrays/AbstractArraysOfArrays.jl.git",
    forcepush = true,
    push_preview = true,
)
