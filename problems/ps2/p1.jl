using Unitful, UnitfulAstro, Luxor, DataFrames, Plots, PrettyTables, Statistics

# Given
earthOrbitalRadius = 1.0u"AU"
jupiterOrbitalRadius = 5.20u"AU"
jupiterRadius = 69.9e3u"km"

# Find a) angular diameter @ Opposition
D = earthOrbitalRadius + jupiterOrbitalRadius
d = 2 * uconvert(u"AU", jupiterRadius)
δ = 2 * atan(d / (2 * D))u"rad"
δ_arcsec = uconvert(u"arcsecond", δ)

# Find b) angular diameter @ Conjunction
D = jupiterOrbitalRadius - earthOrbitalRadius
δ = 2 * atan(d / (2 * D))u"rad"
δ_arcsec = uconvert(u"arcsecond", δ)

# Draw Diagram
@png begin
	drawingScale = 65;
	testColor = "red";
	regularColor = "black";
	earthColor = "red"
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	sethue(regularColor);
	circle(O, ustrip(earthOrbitalRadius), :stroke);
	circle(O, ustrip(jupiterOrbitalRadius), :stroke);

	# Pick an arbitrary point for Earth - say \pi/2
	earthRadius = ustrip(uconvert(u"AU", 1u"Rearth_p"))
	sethue(earthColor)
	circle(Point(-ustrip(earthOrbitalRadius), 0.0), earthRadius * 1000.0, :stroke)

	# Jupiter in Opposition to earth is 0 radians
	circle(Point(ustrip(jupiterOrbitalRadius), 0.0), ustrip(d) * 1000.0 / 2, :stroke)

	# Lines
	sethue("black")
	setdash("dashed")
	line(Point(-ustrip(earthOrbitalRadius), 0.0), Point(ustrip(jupiterOrbitalRadius), ustrip(d) * 1000.0 / 2), :stroke)
	line(Point(-ustrip(earthOrbitalRadius), 0.0), Point(ustrip(jupiterOrbitalRadius), -ustrip(d) * 1000.0 / 2), :stroke)
	setdash("dotted")
	arc2r(Point(-ustrip(earthOrbitalRadius), 0.0), Point(ustrip(jupiterOrbitalRadius) / 2, -ustrip(d) * 1000.0 / 2 / 2), Point(ustrip(jupiterOrbitalRadius) / 2, ustrip(d) * 1000.0 / 2 / 2), :stroke)

	# Radius Labels
	dR = 1.33 * ustrip(earthOrbitalRadius)
	line(Point(-ustrip(earthOrbitalRadius), -dR), Point(ustrip(jupiterOrbitalRadius), -dR), :stroke)
	line(Point(ustrip(jupiterOrbitalRadius) - 1000.0 * ustrip(d) / 2, 0.0), Point(ustrip(jupiterOrbitalRadius) + 1000.0 * ustrip(d) / 2, 0.0), :stroke)
	sethue("black")
	scale(2/drawingScale, -2/drawingScale)
	label("D", :N, Point(drawingScale / 2 * (-ustrip(earthOrbitalRadius) + ustrip(jupiterOrbitalRadius)) / 2, drawingScale / 2 * dR))
	label("d", :N, Point(drawingScale / 2 * ustrip(jupiterOrbitalRadius) + dR / 0.5, drawingScale / 2 * dR / 2.5))
	label("δ", :E, Point(drawingScale / 2 * ustrip(jupiterOrbitalRadius) / 2, 0.0))
end 750 750 "problems/ps2/OppositionDiagram.png"


# Draw Diagram
@png begin
	drawingScale = 65;
	testColor = "red";
	regularColor = "black";
	earthColor = "red"
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	sethue(regularColor);
	circle(O, ustrip(earthOrbitalRadius), :stroke);
	circle(O, ustrip(jupiterOrbitalRadius), :stroke);

	# Pick an arbitrary point for Earth - say \pi/2
	earthRadius = ustrip(uconvert(u"AU", 1u"Rearth_p"))
	sethue(earthColor)
	circle(Point(-ustrip(earthOrbitalRadius), 0.0), earthRadius * 1000.0, :stroke)

	# Jupiter in Opposition to earth is 0 radians
	circle(Point(-ustrip(jupiterOrbitalRadius), 0.0), ustrip(d) * 1000.0 / 2, :stroke)

	# Lines
	sethue("black")
	setdash("dashed")
	line(Point(-ustrip(earthOrbitalRadius), 0.0), Point(-ustrip(jupiterOrbitalRadius), ustrip(d) * 1000.0 / 2), :stroke)
	line(Point(-ustrip(earthOrbitalRadius), 0.0), Point(-ustrip(jupiterOrbitalRadius), -ustrip(d) * 1000.0 / 2), :stroke)
	setdash("dotted")
	arc2r(Point(-ustrip(earthOrbitalRadius), 0.0), Point(-ustrip(jupiterOrbitalRadius) / 2, ustrip(d) * 1000.0 / 2 / 2), Point(-ustrip(jupiterOrbitalRadius) / 2, -ustrip(d) * 1000.0 / 2 / 2), :stroke)

	# Radius Labels
	dR = 1.33 * ustrip(earthOrbitalRadius)
	line(Point(-ustrip(earthOrbitalRadius), -dR), Point(-ustrip(jupiterOrbitalRadius), -dR), :stroke)
	line(Point(-ustrip(jupiterOrbitalRadius) - 1000.0 * ustrip(d) / 2, 0.0), Point(-ustrip(jupiterOrbitalRadius) + 1000.0 * ustrip(d) / 2, 0.0), :stroke)
	sethue("black")
	scale(2/drawingScale, -2/drawingScale)
	label("D", :N, Point(drawingScale / 2 * (-ustrip(earthOrbitalRadius) + -ustrip(jupiterOrbitalRadius)) / 2, drawingScale / 2 * dR))
	label("d", :N, Point(drawingScale / 2 * -ustrip(jupiterOrbitalRadius) + dR / 0.5, drawingScale / 2 * dR / 2.5))
	label("δ", :E, Point(drawingScale / 2 * -ustrip(jupiterOrbitalRadius) / 2, 0.0))
end 750 750 "problems/ps2/ConjunctionDiagram.png"
