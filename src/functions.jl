# This file is a part of AbstractArraysOfArrays.jl, licensed under the MIT License (MIT).


"""
    flatview(A::AbstractArray)
    flatview(A::AbstractArray{<:AbstractArray{<:...}})

View array `A` in a suitable flattened form. The shape of the flattened form
will depend on the type of `A`. If the `A` is not a nested array, the return
value is `A` itself. When no type-specific method is available, `flatview`
will fall back to `Base.Iterators.flatten`.
"""
function flatview end
export flatview

@inline flatview(A::AbstractArray) = A

# TODO: Implement flatview on generic nested arrays via new `FlatView`, using
# deepgetindex to implement getindex, etc.
@inline flatview(A::AbstractArray{<:AbstractArray}) = Base.Iterators.flatten(A)


"""
    innersize(A:AbstractArray{<:AbstractArray}, [dim])

Returns the size of the element arrays of `A`. Fails if the element arrays
are not of equal size.
"""
function innersize end
export innersize

function innersize(A::AbstractArray{<:AbstractArray{T,M},N}) where {T,M,N}
    s = if !isempty(A)
        let sz_A = size(first(A))
            ntuple(i -> Int(sz_A[i]), Val(M))
        end
    else
        ntuple(_ -> zero(Int), Val(M))
    end

    let s = s
        if any(X -> size(X) != s, A)
            throw(DimensionMismatch("Shape of element arrays of A is not equal, can't determine common shape"))
        end
    end

    s
end

@inline innersize(A::AbstractArray{<:AbstractArray}, dim::Integer) =
    innersize(A)[dim]


"""
    flatten_and_reconstruct(A::CollectionOfArrays)

Return a flattened version of A and a function to reconstruct
a nested array similar to A for a similar flattened array.

Example:

```julia
A = eachcol(rand(5,7))
flat_A, re = flatten_and_reconstruct(A)
re(f.(flat_A)) == eachcol(f.flat(A))
```
"""
function flatten_and_reconstruct end
export flatten_and_reconstruct
