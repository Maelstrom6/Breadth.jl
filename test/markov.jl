"""
This is a quick program to find an effient keyboard layout based off of my typing history
"""
# main values
s = read(raw"C:\Users\User\Documents\thing.txt", String)
s = lowercase(s)
s = replace(s, r"[^a-z]+" => " ")  # should only contain a-z and spaces
u = unique(s)  # an array of unique characters
n = length(u)  # number of unique characters
cartesian_power(ss, n) = vec(collect(Iterators.product(ntuple(i->ss, n)...)))

# central value
num_chars = 3  # the length of a single value in the state space

# calcualted values
# the state space are all the combinations you can make with `num_chars` number of letters
state_space = cartesian_power(u, num_chars)
Base.summarysize(state_space)

N = n^num_chars  # size of T

T = zeros(UInt8, N, N)  # T can get very big
Base.summarysize(T)

char_index = Dict(v => i for (i, v) in enumerate(state_space))
index_char = Dict(i => v for (i, v) in enumerate(state_space))

prev_substring = Tuple(collect(s[1:num_chars]))
for i in (num_chars+1):(length(s)-num_chars+1)
    substring = Tuple(collect(s[i:(i+num_chars-1)]))
    T[char_index[prev_substring], char_index[substring]] += 1
    prev_substring = substring
end

function get_mode(char::Tuple)
    i = char_index[char]
    row = T[i, :]
    proportion, mode_char = findmax(row)
    mode_char = index_char[mode_char]
    proportion = proportion/sum(row)
    proportion = round(Int, proportion*100)
    println("$char leads to $mode_char $proportion% of the time")
end

# now to define the cost function
