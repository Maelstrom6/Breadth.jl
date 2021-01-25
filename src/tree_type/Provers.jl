function _applicable()

end


# Returns whether it is applicable and the matched wilds
# a truth can match with an expr in many ways
function _isapplicable(expr::Node, truth::Node, wilds::Array{Node})::Tuple{Bool,Dict{Node,Set{Node}}}
    result = true
    matched = Dict(wild => Set{Node}() for wild in wilds)  # wehre the wild needs to take on this value and this values

    # println(class(truth))
    # println(quick_range(truth))
    # println(expr)
    # println(quick_range(expr))
    # println()

    # if (class(truth) <: ACall) && (class(args(truth)[1]) <: Wild) && (quick_range(expr) <: quick_range(args(truth)[1]))
    #     inner_result, inner_matched = _isapplicable(expr, )
    #     push!(matched[args(truth)[1]], expr)
    # else
    if (class(truth) <: Wild) && (quick_range(expr) <: quick_range(truth))
        result = true
        push!(matched[truth], expr)
    elseif expr.class != truth.class
        result = false
    elseif expr.data != truth.data
        result = false
    elseif length(expr.args) != length(truth.args)
        result = false
    else
        for i in 1:length(expr.args)
            inner_result, inner_matched = _isapplicable(expr.args[i], truth.args[i], wilds)
            for wild in wilds
                matched[wild] = union(matched[wild], inner_matched[wild])
            end
            if !inner_result
                result = false
            end
        end
    end

    for wild in wilds
        if length(matched[wild]) > 1
            result = false
        end
    end

    return result, matched
end

preorder_traversal(x::Node) = vcat([x], [preorder_traversal(arg) for arg in args(x)]...)
function count_ops(x::Node)
    if class(x) <: AAtom
        return 0
    else
        return length(args(x)) + sum([count_ops(arg) for arg in args(x)])
    end
end

function replace(expr::Node, old::Node, new::Node)::Node
    if expr == old
        return new
    else
        new_args = Tuple(replace(arg, old, new) for arg in args(expr))
        return Node(data(expr), class(expr), new_args)
    end
end

function replace(expr::Node, replacements::Dict{Node,Node})::Node
    result = expr
    for (key, value) in replacements
        result = replace(result, key, value)
    end
    return result
end

function get_wilds(expr::Node)::Array{Node}
    result = Node[]

    nodes = preorder_traversal(expr)
    for node in nodes
        if (class(node) <: ACall) && (class(args(node)[1]) <: Wild)
            push!(result, node)
        elseif class(node) <: AWild
            push!(result, node)
        end
    end

    return unique(result)
end


function isapplicable(expr::Node, truth::Node)
    wilds = get_wilds(truth)
    result, matched = _isapplicable(expr, truth, wilds)

    new_matched = Dict{Node,Node}()
    if result
        for wild in wilds
            new_matched[wild] = pop!(matched[wild])
        end
    end

    return result, new_matched
end


function rewrites(expr::Node, truth_table=truths)::Array{Node}
    result = Node[]
    for truth in truth_table
        app, matches = isapplicable(expr, truth.left)
        if app
            subs_right = replace(truth.right, matches)
            push!(result, subs_right)
        end
    end

    # Repeat recursivley on the arguments
    for (i, child) in enumerate(expr.args)

        child_rewrites = rewrites(child, truth_table)
        for j in 1:length(child_rewrites)
            # args = copy(expr.args)
            args = collect(expr.args)
            args[i] = child_rewrites[j]
            child_rewrites[j] = Node(expr.data, expr.class, Tuple(args))
        end
        append!(result, child_rewrites)
    end

    return unique(result)
end

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

function rewrites_wp(expr::Node, node_id::Array{Int64}=Int64[], truth_table=truths)::Array{Tuple{Node,Int64,Array{Int64}}}
    result::Array{Tuple{Node,Int64,Array{Int64, M} where M},N} where N = []
    for (truth_id, truth) in enumerate(truth_table)
        app, matches = isapplicable(expr, truth.left)
        if app
            subs_right = replace(truth.right, matches)
            push!(result, (subs_right, truth_id, node_id))
        end
    end

    # Repeat recursivley on the arguments
    for (i, child) in enumerate(expr.args)

        child_rewrites = rewrites_wp(child, vcat(node_id, [i]), truth_table)
        for j in 1:length(child_rewrites)
            args = collect(expr.args)
            args[i] = child_rewrites[j][1]
            child_rewrites[j] = (Node(expr.data, expr.class, Tuple(args)), child_rewrites[j][2], child_rewrites[j][3])
        end
        append!(result, child_rewrites)
    end

    return unique(result)
end

function prove(x, y=TRUE, maxdepth=2, truth_table=truths)
    depth = 0
    values = Proof[Proof([(x, 1, [])])]
    old_values = values  # checked trees
    last_line = [steps(p)[end] for p in values]
    while !(y in last_line) && !(~(y) in last_line) && (depth < maxdepth)
        depth += 1
        new_values = []
        for value in values
            append!(new_values, extensions(value, truth_table))
        end
        # values = [Set(new_values)...]
        values = setdiff(new_values, old_values)
        append!(old_values, values)
        last_line = [steps(p)[end] for p in values]
        println(length(values))
        for value in last_line
            if length(get_wilds(value)) > 0
                println(value)
            end
        end
    end
    last_line = [steps(p)[end] for p in values]
    if y in last_line
        proof = values[[steps(p)[end]==y for p in values]][1]
        return proof
    elseif ~(y) in last_line
        proof = values[[steps(p)[end]==~(y) for p in values]][1]
        return proof
    else
        return UNKNOWN
    end
end

function result_wp(x, y=TRUE, maxdepth=2)
    return english(prove(x, y, maxdepth))
end
