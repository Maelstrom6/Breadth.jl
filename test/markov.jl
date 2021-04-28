"""
This is a quick program to find an effient keyboard layout based off of my typing history
"""
# main values
s = read(raw"C:\Users\User\Documents\thing.txt", String)
s = lowercase(s)
s = replace(s, r"[^a-z]+" => " ")  # should only contain a-z and spaces

cartesian_power(ss, n) = vec(collect(Iterators.product(ntuple(i->ss, n)...)))

state_elements = append!([' '], map(Char, Int('a'):Int('z')))
element_index = Dict(element => index-1 for (index, element) in enumerate(state_elements))
index_element = Dict(index-1 => element for (index, element) in enumerate(state_elements))
u = unique(s)  # an array of unique characters
n = length(u)  # number of unique characters
u = state_elements  # should be the same thing just in a different order


# central value
num_chars = 5  # the length of a single value in the state space

# calcualted values
# the state space are all the combinations you can make with `num_chars` number of letters
# state_space = cartesian_power(u, num_chars)
# Base.summarysize(state_space)

function state_space(index::Int64)::NTuple{num_chars, Char}
    index -= 1  # julia is 1-based
    chars = ""
    for i in 1:num_chars
        element = rem(index, n)
        index -= element
        index ÷= n
        chars *= Char(index_element[element])
    end
    return Tuple(collect(chars))
end


N = n^num_chars  # size of T
using SparseArrays

T = spzeros(Int64, N, N)  # T can get very big
Base.summarysize(T)

# char_index is basically the inverse of state_space
# that means that x == state_space[char_index(x)]
# and vice versa
function char_index(chars::NTuple{num_chars, Char})::Int64
    index = 1  # Julia is 1-based
    for (i, element) in enumerate(chars)
        index += element_index[element] * n^(i-1)
    end
    return index
end

# check that it is true
for i in 1:100
    char_index(state_space(i)) != i ? println(i) : nothing
end

# now we make the markov chain
prev_substring = Tuple(collect(s[1:num_chars]))
for i in (num_chars+1):(length(s)-num_chars+1)
    substring = Tuple(collect(s[i:(i+num_chars-1)]))
    T[char_index(prev_substring), char_index(substring)] += 1
    prev_substring = substring
end

# now DiscreteMarkovChains
P = T
P = P[P.rowval, P.rowval]
using LinearAlgebra
P = P .* repeat(1 ./ sum(P, dims=2)', size(P)[1])'

using DiscreteMarkovChains
X = DiscreteMarkovChain(P)



# get the state that most often follows from the given state
# eg. " ar" is most often followed by "are" which is then followed by "re "
function get_mode(char::Tuple)
    i = char_index(char)
    row = T[i, :]
    proportion, mode_char = findmax(row)

    if proportion == 0
        return "State $char was never reached"
    end

    mode_char = state_space(mode_char)
    proportion = proportion/sum(row)
    proportion = round(Int, proportion*100)
    return "$char leads to $mode_char $proportion% of the time"
end
get_mode(s::String) = get_mode(Tuple(collect(s)))

function mode(char::Tuple)
    i = char_index(char)
    row = T[i, :]
    proportion, mode_char = findmax(row)

    if proportion == 0
        return NaN
    end

    mode_char = state_space(mode_char)
    return mode_char
end
mode(s::String) = mode(Tuple(collect(s)))

# like predictive text
function chain(s::String, n::Int64)
    result = s
    for i in 1:n
        result *= mode(result[(end-num_chars+1):end])[end]
    end
    return result
end

# now to define the cost function
