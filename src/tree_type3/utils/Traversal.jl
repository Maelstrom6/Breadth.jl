preorder_traversal(x::Term) = vcat([x], [preorder_traversal(arg) for arg in args(x)]...)

count_ops(x::Term) = reduce(+, [count_ops(arg) for arg in args(x)], init=length(args(x)))
export count_ops
