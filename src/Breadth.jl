module Breadth
import Base.~, Base.∈, Base.∪, Base.∩, Base.-#, Base.:(≡)
using Memoize

#include("tree_type3/__init__.jl")
include("tree_type/TreeType.jl")

# macro ex(func)
#     return quote
#         $(esc(func))(x::Vararg) = sum(x)
#         export $(esc(func))
#     end
# end

# @ex ∨

end
