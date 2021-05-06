"""
Returns whether it is applicable and the matched wilds
A truth can match with an expr in many ways
"""
# Returns whether it is applicable and the matched wilds
# a truth can match with an expr in many ways
function _isapplicable(expr::Term, truth::Term, wilds::Array{Term})::Tuple{Bool,Dict{Term,Set{Term}}}
    _result = true
    matched = Dict(wild => Set{Term}() for wild in wilds)  # where the wild needs to take on this value and this value...

    # println(expr)
    # println(truth)
    # println(codomain(expr))
    # println(codomain(truth))
    # println(codomain(expr) ⊂ codomain(truth))
    # println(result(codomain(expr) ⊂ codomain(truth)))
    # println()
    #is_subset = (result(codomain(expr) ⊂ codomain(truth)) == True)
    if (class(truth) <: AVariable) #&& is_subset
        _result = true
        push!(matched[truth], expr)
    elseif expr.class != truth.class
        _result = false
    elseif expr.data != truth.data
        _result = false
    elseif length(expr.args) != length(truth.args)
        _result = false
    else
        for i in 1:length(expr.args)
            inner_result, inner_matched = _isapplicable(expr.args[i], truth.args[i], wilds)
            for wild in wilds
                matched[wild] = union(matched[wild], inner_matched[wild])
            end
            if !inner_result
                _result = false
            end
        end
    end

    for wild in wilds
        if length(matched[wild]) > 1
            _result = false
        end
    end

    return _result, matched
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

    for name_truth in truth_table
        truth = name_truth.statement
        if class(truth) <: AImplies
            subject = args(truth)[1]
            predicate = args(truth)[2]
            app, matches = isapplicable(expr, subject)
            if app
                subs_right = replace(predicate, matches)
                push!(result, subs_right)
            end
        elseif class(truth) <: AEquivalent
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
    Threads.@threads for (i, child) in collect(enumerate(expr.args))

        child_rewrites = rewrites(child, truth_table)
        for j in 1:length(child_rewrites)
            # args = copy(expr.args)
            args::Array{Term{<:ABasic}} = collect(expr.args)
            args[i] = child_rewrites[j]
            child_rewrites[j] = Term(expr.data, expr.class, Tuple(args))
        end
        append!(result, child_rewrites)
    end

    return unique(result)
end
export rewrites
