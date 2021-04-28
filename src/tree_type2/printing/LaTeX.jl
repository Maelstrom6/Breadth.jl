export to_latex
function to_latex(self::Node)::String
    return to_latex(self, :(=), :left)
end

function to_latex(self::Node{<:Any}, prev_operator::Symbol, pos::Symbol)::String
    curr_operator = Symbol(data(self))
    result = "$(to_latex(args(self)[1], curr_operator, :left)) $(data(self)) $(to_latex(args(self)[2], curr_operator, :right))"

    if curr_operator == prev_operator
        acc = Base.operator_associativity(curr_operator)
        if acc == :left != pos
            return "(" * result * ")"
        elseif acc == :right != pos
            return "(" * result * ")"
        else  # :none
            return result
        end
    end

    curr_precedence = Base.operator_precedence(curr_operator)
    prev_precedence = Base.operator_precedence(prev_operator)


    if curr_precedence > prev_precedence  # if the current operation would be performed last
        return result
    elseif curr_precedence == prev_precedence
        return result
    elseif curr_precedence < prev_precedence
        return "(" * result * ")"
    end
end

function to_latex(self::Node{<:AAtom}, prev_operator::Symbol, pos::Symbol)::String
    return data(self)
end

function to_latex(self::Node{<:ACall}, prev_operator::Symbol, pos::Symbol)::String
    return "$(to_latex(args(self)[1]))($(to_latex(args(self)[2])))"
end


Base.operator_precedence
Base.operator_associativity
