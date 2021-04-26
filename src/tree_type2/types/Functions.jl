abstract type ACall <: AOperator end
function (f::Node)(x::Node)
    return Node("()", ACall, (f, x))
end
function (f::Node)(Vararg...)
    return Node("()", f, Vararg)
end
