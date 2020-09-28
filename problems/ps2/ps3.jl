using Unitful, UnitfulAstro,
import PhysicalConstants.CODATA2018: c_0


# Given
λ_1 = 655.9u"nm"
λ_rest = 656.3u"nm"

# Find radial velocity
Δλ = 0.4u"nm"
v_radial = c_0 * (Δλ) / λ_rest
