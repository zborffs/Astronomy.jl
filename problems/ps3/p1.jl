# Import packages
using Unitful, UnitfulAstro, Luxor, DataFrames, Plots, PrettyTables, Statistics
using PeriodicTable

# Use GR backend for graphing
plotly()

# Find
# Draw a log-log plot of:
#    T < 75K * m * M / R
# as a function of M/R for helium, methane, carbon dioxide
# Y-axis = temp
# x-axis = M/R

# Given
m_helium = 2 # amu
m_methane = 16 # amu
m_co2 = 44 # amu

M_R = collect(0.01:0.01:30)
T_helium = 75 * m_helium * M_R
T_methane = 75 * m_methane * M_R
T_co2 = 75 * m_co2 * M_R

M_R_log = log10.(M_R)
T_helium_log = log10.(T_helium)
T_methane_log = log10.(T_methane)
T_co2_log = log10.(T_co2)

heliumLabelString = "Helium (m = " * string(m_helium) * ")"
plot(M_R, T_helium, yaxis=:log, xaxis=:log,
		xlabel="M / R (Earth Mass / Earth Radius)",
		ylabel="Temperature (K)",
		title="Effect of Earth Mass-Radius Ratio on Temperature Limit <br> for Various Gases",
		legend=:outerbottomright, label=heliumLabelString)

methaneLabelString = "Methane (m = " * string(m_methane) * ")"
plot!(M_R, T_methane, label=methaneLabelString)

co2LabelString = "Carbon Dioxide (m = " * string(m_co2) * ")"
plot!(M_R, T_co2, label=co2LabelString)

# Part B
# Add "dots" for each planet corresponding to their atmospheric temperature (avg)
planetRelativeMasses = [0.055, 0.815, 1.00, 0.11, 318, 95.2, 14.5, 17.2]
planetRelativeRadii = [0.38, 0.95, 1.0, 0.53, 10.9, 9.13, 3.98, 3.86]
planetRatios = planetRelativeMasses ./ planetRelativeRadii

planetTemperatures_Celsius = [(430-180)/2, 471, 16, -28, -108, -138, -195, -201]
planetTemperatures_Kelvin = 273.15 .+ planetTemperatures_Celsius

names = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

for i in 1:length(names)
	plot!(convert(Vector{Float64}, [planetRatios[i]]), convert(Vector{Float64}, [planetTemperatures_Kelvin[i]]), markershape=:circle, linealpha=0, label=names[i])
end
plot!(convert(Vector{Float64}, [planetRatios[1]]), convert(Vector{Float64}, [planetTemperatures_Kelvin[1]]), markershape=:circle, markeralpha=0, linealpha=0, label=:none)
# plot!(planetRatios, planetTemperatures_Kelvin, markershape=:circle, linealpha=0, markercolor=:black, label=:none)
