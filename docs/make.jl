using Breadth
using Documenter

makedocs(;
    modules=[Breadth],
    authors="Chris du Plessis",
    repo="https://github.com/Maelstrom6/Breadth.jl/blob/{commit}{path}#L{line}",
    sitename="Breadth.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Maelstrom6.github.io/Breadth.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Maelstrom6/Breadth.jl",
)
