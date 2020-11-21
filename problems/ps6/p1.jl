using Unitful, UnitfulAstro, Plots, PrettyTables, Statistics, Astronomy
import PhysicalConstants.CODATA2014: G
plotly()

# Given
R = [5, 10, 15, 20, 25]u"kpc"

# Computed from Table
v = [245, 270, 260, 270, 265]u"km/s"

# Rearrange for M and put in terms of "kg"
Mr = uconvert.(u"kg", R .* (v.^2) ./ G)

# Put into pretty table
data = hcat(ustrip.(R), ustrip.(v), round.(ustrip.(Mr); sigdigits=4))
header = ["Distance" "Velocity" "Mass"; "kpc" "km/s" "kg"]
pretty_table(data, header) # Create a "pretty table" for the REPL
pretty_table(data, header, backend=:latex) # Create a "pretty table" to be exported in LaTeX

# Plot
scatter(ustrip.(R), ustrip.(Mr), xaxis=:log, yaxis=:log,
	ylabel="Mass [kg]", xlabel="Distance [kpc]",
	legend=:outerbottomright,
	label="Rotation Curve Estimates")

# Take log10 of both R and Mr vectors
logR = log10.(ustrip.(R))
logM = log10.(ustrip.(Mr))

m, b, R² = leastSquaresRegression(logR, logM)

# Sampling Range
logRSample = collect(logR[begin]:0.01:logR[end])
logMSample = logRSample * m .+ b

estimatedLabel = string("y ≈ ", round(m, digits=3), "x + ", round(b, digits=3), "; R² = ", round(R², digits=5))
plot!(10 .^ logRSample, 10 .^ logMSample, label=estimatedLabel)

# Determine rho_naught and alpha from b and m
α = 3 - m
ρ0 = 10^b / (4 * π)
