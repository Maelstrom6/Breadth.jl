"""
Returns whether it is applicable and the matched wilds
A truth can match with an expr in many ways
"""
# Returns whether it is applicable and the matched wilds
# a truth can match with an expr in many ways
function _isapplicable(expr::Term, truth::Term, wilds::Array{Term})::Tuple{Bool,Dict{Term,Set{Term}}}
    result = true
    matched = Dict(wild => Set{Term}() for wild in wilds)  # where the wild needs to take on this value and this value...

    if (class(truth) <: AVariable) && (quick_range(expr) <: quick_range(truth))
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

function replace(expr::Term, old::Term, new::Term)::Term
    if expr == old
        return new
    else
        new_args = Tuple(replace(arg, old, new) for arg in args(expr))
        return Term(data(expr), class(expr), new_args)
    end
end

function replace(expr::Term, replacements::Dict{Term,Term})::Term
    result = expr
    for (key, value) in replacements
        result = replace(result, key, value)
    end
    return result
end

function get_wilds(expr::Term)::Array{Term}
    result = Term[]

    nodes = preorder_traversal(expr)
    for node in nodes
        if class(node) <: AVariable
            push!(result, node)
        end
    end

    return unique(result)
end

function isapplicable(expr::Term, truth::Term)
    wilds = get_wilds(truth)
    result, matched = _isapplicable(expr, truth, wilds)

    new_matched = Dict{Term,Term}()
    if result
        for wild in wilds
            new_matched[wild] = pop!(matched[wild])
        end
    end

    return result, new_matched
end
export isapplicable


function rewrites(expr::Term, truth_table=truths)::Array{Term}
    result = Term[]

    for truth in truth_table
        if truth <: Term{<:AImplies}
            subject = args(truth)[1]
            predicate = args(truth)[2]
            app, matches = isapplicable(expr, subject)
            if app
                subs_right = replace(predicate, matches)
                push!(result, subs_right)
            end
        elseif truth <: Term{<:AEquivalent}
            subject = args(truth)[1]
            predicate = args(truth)[2]
            app, matches = isapplicable(expr, subject)
            if app
                subs_right = replace(predicate, matches)
                push!(result, subs_right)
            end
            subject = args(truth)[2]
            predicate = args(truth)[1]
            app, matches = isapplicable(expr, subject)
            if app
                subs_right = replace(predicate, matches)
                push!(result, subs_right)
            end
        end
    end

    # Repeat recursivley on the arguments
    for (i, child) in enumerate(expr.args)

        child_rewrites = rewrites(child, truth_table)
        for j in 1:length(child_rewrites)
            # args = copy(expr.args)
            args = collect(expr.args)
            args[i] = child_rewrites[j]
            child_rewrites[j] = Term(expr.data, expr.class, Tuple(args))
        end
        append!(result, child_rewrites)
    end

    return unique(result)
end
