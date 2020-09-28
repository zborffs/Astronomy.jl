using Unitful, UnitfulAstro, Luxor, PhysicalConstants.CODATA2018
G = NewtonianConstantOfGravitation




# Given
R_Jupiter = 5.20u"AU"
T_Ganymede = 170u"hr"
RArcMinutes_Ganymede = 5.9u"arcminute"

# Find
a = uconvert(u"m", (R_Jupiter - 1.0u"AU") * tan(RArcMinutes_Ganymede))

# Assuming the semi major axis are the same and equal to the radius of ganymede
# Assuming the mass of jupiter is much bigger than that of Ganymede
P = uconvert(u"s", T_Ganymede)
m_Jupiter = (4π^2) / G * a^3 / P^2
