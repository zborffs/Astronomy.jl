using Unitful, UnitfulAstro, Luxor, DataFrames, Plots, PrettyTables, Statistics

gr()

function calcRSquared(y::Vector{Float64}, yHat::Vector{Float64})::Float64
	@assert length(y) == length(yHat)
	ssr = sum((y - yHat) .^ 2)
	yBar = mean(y)
	sst = sum((y .- yBar) .^ 2)
	return 1. - ssr / sst
end

# Given
planetNames = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
siderealPeriod = [0.24, 0.6, 1.0, 1.88, 11.86, 29.46, 84.01, 164.82]
semiMajorAxisVector = [0.39, 0.72, 1.0, 1.52, 5.2, 9.54, 19.19, 30.06]

# a) Log-Log Plot
logPeriod = log10.(siderealPeriod)
logDist = log10.(semiMajorAxisVector)
plot(siderealPeriod, semiMajorAxisVector, xaxis=:log10, yaxis=:log10, xlabel="Sidereal Period [y]", ylabel="Semimajor Axis (AU)", title="Sidereal Period vs. Semimajor Axis log-log Plot", markershape=:circle, linealpha=0, legend=:bottomright, label="Actual")
# plot(logPeriod, logDist, xlabel="Sidereal Period [y]", ylabel="Semimajor Axis (AU)", title="Sidereal Period vs. Semimajor Axis log-log Plot", markershape=:circle, linealpha=0, legend=:bottomright, label="Actual")

data = hcat(planetNames, siderealPeriod, semiMajorAxisVector)
header = ["Name" "Sidereal Period" "Semimajor Axis"; "N/A" "y" "AU"]
pretty_table(data, header, backend = :latex)


μP = mean(logPeriod)
μD = mean(logDist)
m = cov(logPeriod, logDist; corrected = false) / cov(logPeriod; corrected = false)
b = μD - m * μP

logPeriodRange = convert(Vector{Float64}, logPeriod[begin]:0.1:logPeriod[end])
logDistRangeEst = logPeriodRange * m .+ b
logPeriodEst = logPeriod * m .+ b
rSquared = calcRSquared(logDist, logPeriodEst)

estimatedLabel = string("y ≈ ", round(m, digits=3), "x + ", round(b, digits=3), "; R² = ", round(rSquared, digits=5))
# plotRef = plot!(logPeriodRange, logDistRangeEst, label="Best-Fit")
plotRef = plot!(10 .^ logPeriodRange, 10 .^ logDistRangeEst, label=estimatedLabel)
Plots.png(plotRef, "problems/ps1/SiderealPeriod_SemiMajorAxis_LogLogPlot.png")
