using Unitful, UnitfulAstro, Plots, PrettyTables, Statistics, Astronomy, Plots.PlotMeasures
import PhysicalConstants.CODATA2014: G
plotly()

# Given
name = ["A", "B", "C", "D", "E"]
d = [14, 62, 1.4e2, 1.9e2, 2.7e2]u"Mpc"
v = [-2.4e2, 9.1e2, 2.8e3, 4.3e3, 5.8e3]u"km/s"
# v = [2.4e2, 9.1e2, 2.8e3, 4.3e3, 5.8e3]u"km/s"

scatter(ustrip.(d), ustrip.(v),
	xlabel="Distance [Mpc]", ylabel="Velocity [km/s]",
	legend=:outerbottomright,
	label="Table Data",
	left_margin=10mm)

m, b, R² = leastSquaresRegression(ustrip.(d), ustrip.(v))

# Sampling Range
dSampled = collect(ustrip(d[begin]):4:ustrip(d[end]))
vSampled = dSampled * m .+ b

estimatedLabel = string("y ≈ ", round(m, digits=3), "x + ", round(b, digits=3), "; R² = ", round(R², digits=5))
plot!(dSampled, vSampled, label=estimatedLabel)

# b. Estimate the age of the universe
H0 = (m)u"km/s/Mpc"
emptyAge = uconvert(u"Gyr", 1 / H0)

# c. answer in pdf

# d.
flatAge = uconvert(u"Gyr", 2 / (3 * H0))
