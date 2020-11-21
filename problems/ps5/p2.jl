using Unitful, UnitfulAstro, Plots, ColorSchemes
plotly()

SpectralType = ["O5", "O8", "B0", "B5", "A0", "F0", "G0", "K0", "K5", "M0", "M5", "M8"]
Teff = [44500u"K", 35800u"K", 30000u"K", 15400u"K", 9520u"K", 7200u"K", 6030u"K", 5250u"K", 4350u"K", 3850u"K", 3240u"K", 2640u"K"]
Luminosity = [790000u"Lsun", 170000u"Lsun", 52000u"Lsun", 830u"Lsun", 54u"Lsun", 6.5u"Lsun", 1.5u"Lsun", 0.42u"Lsun", 0.15u"Lsun", 0.077u"Lsun", 0.011u"Lsun", 0.0012u"Lsun"]
R = [15u"Rsun", 11u"Rsun", 8.4u"Rsun", 4.1u"Rsun", 2.7u"Rsun", 1.6u"Rsun", 1.1u"Rsun", 0.79u"Rsun", 0.68u"Rsun", 0.63u"Rsun", 0.33u"Rsun", 0.17u"Rsun"]
Mass = [60u"Msun", 23u"Msun", 17.5u"Msun", 5.9u"Msun", 2.9u"Msun", 1.6u"Msun", 1.05u"Msun", 0.79u"Msun", 0.67u"Msun", 0.51u"Msun", 0.21u"Msun", 0.06u"Msun"]
Lifetime = [3.6e5u"yr", missing, 1.0e7u"yr", 7.2e7u"yr", 3.9e8u"yr", 2.1e9u"yr", 8.3e9u"yr", 3.7e10u"yr", 5.3e10u"yr", 7.9e10u"yr", 2.9e11u"yr", 1.1e12u"yr"]

@assert length(SpectralType) == length(Teff)
@assert length(Luminosity) == length(Teff)
@assert length(Luminosity) == length(R)
@assert length(Mass) == length(R)
@assert length(Mass) == length(Lifetime)

# Find
# (a.) Plot on a log-log scale, the Main Sequence lifetime versus Mass for the
#      star types shown on the table below. Do this two ways: approximating
#      the lifetime using the observed mass and luminosity (from the table
#      below and as discussed in Lecutre) and using the results of theoretical
#      models (also shown in the table below).
c = 3e8
LifetimeApprox1 = 10e10 * ustrip(Mass) ./ ustrip(Luminosity)
LifetimeHeuristic = 10e10u"yr" * (1 ./ ustrip.(Mass)).^(2.5)

scatter(LifetimeApprox1, ustrip.(Mass), label="Luminosity-Mass Approx.",
	xaxis=:log, yaxis=:log, ylabel="Solar Masses [Msun]",
	xlabel="Lifetime [Years]",
	title="Relationship between Solar Mass and Lifetime",
	legend=:outerbottomright)
scatter!(ustrip.(Lifetime), ustrip.(Mass), label="Theoretical Model (table)")
plot!(ustrip.(LifetimeHeuristic), ustrip.(Mass), label="Mass-dependent Approx.")
