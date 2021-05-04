Base.show(io::IO, self::Term) = print(io, "$(Meta.parse("($(args(self)[1])) $(data(self)) ($(args(self)[2]))"))")
