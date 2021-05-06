@memoize function result(x, y=True, maxdepth=2, truth_table=truths)  # if x ⟹ y it will return true, false or missing
    # hardcoded things
    if y == True && class(x) <:ASubset
        sub, super = args(x)
        if sub == super
            return True
        elseif super == Ω
            return True
        end
        if class(sub) <: AConstantSymbol && class(sub) <: AConstantSymbol
            if sub == Statements && super == Sets
                return False
            elseif sub == Sets && super == Statements
                return False
            elseif sub == Ω && super == Statements
                return False
            elseif sub == Ω && super == Sets
                return False
            end
        end
    end

    depth = 0
    values = Term{<:ABasic}[x]
    old_values = values  # checked trees
    while !(y in values) && !(~(y) in values) && (depth < maxdepth)
        println("$depth $maxdepth $x $y")
        depth += 1
        println("$depth $maxdepth")
        new_values = []
        for value in values
            append!(new_values, rewrites(value, truth_table))
        end
        values = setdiff(new_values, old_values)
        append!(old_values, values)
        # values = values[map(count_ops, values) .<= maxops]
        println("$depth $maxdepth")
        println(length(values))
    end

    if y in values
        return True
    elseif ~(y) in values
        return False
    else
        return Unknowable
    end
end
export result
