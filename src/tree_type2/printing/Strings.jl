function Base.show(io::IO, self::Node)
    _show(io, self, class(self))
end
_show(io::IO, self::Node, ::Type{<:Any}) = print(io, "$(Meta.parse("($(args(self)[1])) $(data(self)) ($(args(self)[2]))"))")

_show(io::IO, self::Node, ::Type{<:AAtom}) = print(io, data(self))

_show(io::IO, self::Node, ::Type{<:ACall}) = print(io, "$(Meta.parse("$(args(self)[1])($(args(self)[2]))"))")

_show(io::IO, self::Node, ::Type{<:AConditionSet}) = print(io, "$(Meta.parse("ConditionSet($(args(self)[1]), $(args(self)[2]))"))")

_show(io::IO, self::Node, ::Type{<:ANot}) = print(io, "$(Meta.parse("$(data(self))($(args(self)[1]))"))")
