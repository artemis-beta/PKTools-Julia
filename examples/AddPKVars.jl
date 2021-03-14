include("../src/PKTools.jl")

using .PKTools: PKVar

x = PKVar(100.0, 10.0)
y = PKVar(56.0, 0.34)

println("Vector 1: ", x)
println("Vector 2: ", y)
println("\nAddition: ", x + y)
println("\nSubtraction: ", x - y)
println("\nMultiplication: ", x * y)
println("\nDivision: ", x / y)
