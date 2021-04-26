function to_latex(self::Node)::String
    return to_latex(self, class(self))
end

function to_latex(self::Node, ::Type{<:Any})::String
    return "($(to_latex(args(self)[1]))) $(data(self)) ($(to_latex(args(self)[2])))"
end

function to_latex(self::Node, ::Type{<:AAtom})::String
    return data(self)
end

function to_latex(self::Node, ::Type{<:ACall})::String
    return "$(to_latex(args(self)[1]))($(to_latex(args(self)[2])))"
end
