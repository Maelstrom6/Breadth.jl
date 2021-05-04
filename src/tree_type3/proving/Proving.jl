function result(x, y=TRUE, maxdepth=2, truth_table=truths)  # if x ⟹ y it will return true, false or missing
    depth = 0
    values = Node[x]
    old_values = values  # checked trees
    while !(y in values) && !(~(y) in values) && (depth < maxdepth)
        depth += 1
        new_values = []
        for value in values
            append!(new_values, rewrites(value, truth_table))
        end
        values = setdiff(new_values, old_values)
        append!(old_values, values)
        # values = values[map(count_ops, values) .<= maxops]
        println(length(values))
    end

    if y in values
        return TRUE
    elseif ~(y) in values
        return FALSE
    else
        return UNKNOWN
    end
end
