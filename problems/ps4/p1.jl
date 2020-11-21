using Unitful, UnitfulAstro

RSun = 6.96e8u"m"
LSun = 3.90e26u"W"
σ = 5.67e-8u"W * m^-2 * K^-4"
Tp = 150u"K"

TSun = (LSun / (σ * 4 * π * RSun^2))^(1/4)

RPlanet = uconvert(u"Rjup", sqrt(0.0006 * RSun^2))

P = (11/365.25)u"yr"
a = ((P)^(2))^(1/3)
