# Defining the limit
ϵ = symbol("x")  # nothing is initially defined on them (ie. (+) does not work yet)
addtruth(ϵ > 0)
δ = symbol("x")
addtruth(δ > 0)  # should consider delta a real number now
x = symbol("x")
addtruth(x in Reals)
limit = symbol("limit")
addtruth(limit in Functions)
f = symbol("f")
addtruth(f in Functions)
z = symbol("z")
addtruth(x in Reals)
addtruth(forall_wild(f, a, L, z, forall(ϵ, exists(δ, forall(x, 0 < abs(x - a) < δ ⟹ abs(f(x) - L) < ϵ))) ⟺ limit(f(z), z, a) == L))
# The program should know that delta is a function of f, a, L and epsilon in order to show the LHS is true
# When understanding this, L and a can be expressions while z must be an Atom
# The LHS of the bi implication must be able to be used multiple times without reusing variable names. So bound variables must be regenerated every time they are called
# The first forall allows f a and L to be free variables and lets the program know that `f` can be replaced by any other function down the line
# The only free variable is `limit` (and `forall` and `abs` etc)
# f, a, L, z are removed
# epsilon, delta and x are bound


# Defining continuous over the Reals 
@syms x, a, f, iscontinuous
addtruth(x in Reals)
addtruth(f in Functions)
addtruth(iscontinuous in Functions)
addtruth(domain(iscontinuous) == (Functions, Reals))  # probably not that important
addtruth(range(iscontinuous) == Booleans)  # need to be able to work with other definitions and theorems
addtruth(forall_wild(x, f, forall(a, limit(f(x), x, a) == f(x)) ⟺ iscontinuous(f, x)))
# x and f are removed 
# iscontinuous is free 
# a is bound

# Checking if a function is continuous 
@syms x
addtruth(x in Reals)
iscontinuous(2x, x) |> get_truth_value
