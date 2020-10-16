using Luxor, Unitful
import PhysicalConstants.CODATA2018: G

Re = 1;
Rm = 1.52;
# Find
# (a.) Draw the three orbits
@png begin
	drawingScale = 65;
	testColor = "red";
	regularColor = "black";
	earthColor = "green";
	marsColor = "red";
	spacecraftColor = "black";
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	sethue(earthColor);
	Luxor.circle(O, Re, :stroke);
	sethue(marsColor);
	Luxor.circle(O, Rm, :stroke);
	sethue(spacecraftColor);
	focalPoint2 = O + Point(Rm - Re, 0);
	Luxor.ellipse(O, focalPoint2, Point(-Re, 0), :stroke);
end 225 225 "problems/ps3/Q2_PartA_OrbitsDrawing.png"

# b
a = 0.5 * (Re + Rm)u"AU"
MSun = 1.989e30u"kg"
P = uconvert(u"s", 2 * π * sqrt(a^3 / (G * MSun)))
half = ustrip(P) / 2
halfInMonths = half / 2.628e6

ReUnit =
v = uconvert(u"m/s", sqrt(G * MSun * (2u"AU^-1" - 1/a)))
