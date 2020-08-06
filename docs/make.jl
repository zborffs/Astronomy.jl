using Documenter, Astronomy

makedocs(;
    modules=[Astronomy],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/zborffs/Astronomy.jl/blob/{commit}{path}#L{line}",
    sitename="Astronomy.jl",
    authors="Zach Bortoff",
    assets=String[],
)

deploydocs(;
    repo="github.com/zborffs/Astronomy.jl",
)
