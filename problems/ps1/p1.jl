using Unitful, UnitfulAstro, Luxor

# Given
latitude = 66.56u"°"
sunDeclination = 23.44u"°"

# Equation
altitude = 90.0u"°" - (latitude - sunDeclination)

# Diagram
# * might be confusing a bit, because +y is further down rather than further up
@png begin
	drawingScale = 1.0;
	R = 100; # earth's radius
	dR = 50; # differential radius for extending lines
	testColor = "red";
	regularColor = "black";
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	# Draw Earth
	circle(O, R, :stroke);

	# Draw North-South Pole Line
	northPolePoint = Point((R + dR) * cos(90u"°" - sunDeclination), (R + dR) * sin(90u"°" - sunDeclination))
	southPolePoint = Point((R + dR) * cos(-90u"°" - sunDeclination), (R + dR) * sin(-90u"°" - sunDeclination))
	line(northPolePoint, southPolePoint, :stroke)

	# Draw Equator
	equatorPointNeg = Point((R + dR) * cos(180u"°" - sunDeclination), (R + dR) * sin(180u"°" - sunDeclination))
	equatorPointPos = Point((R + dR) * cos(-sunDeclination), (R + dR) * sin(-sunDeclination))
	line(equatorPointPos, equatorPointNeg, :stroke)

	# Draw Arctic Circle chord
	arcticCirclePointNeg = Point(R * cos(180u"°" - sunDeclination - latitude), R * sin(180u"°" - sunDeclination - latitude))
	arcticCirclePointPos = Point(R * cos(-sunDeclination + latitude), R * sin(-sunDeclination + latitude))
	line(arcticCirclePointPos, arcticCirclePointNeg, :stroke)

	# Draw Dotted line from Center of Earth to Sun
	centerEarthPoint = O
	centerSunPoint = Point(R + 3 * dR, 0)
	setdash("dash")
	line(centerEarthPoint, centerSunPoint, :stroke)

	# Draw Center Earth-Latitude Line
	line(centerEarthPoint, arcticCirclePointPos, :stroke)

	# Sun declination Angle Arc
	arcRadius = 3 / 4 * R
	halfEquatorPointArcPos = Point(arcRadius * cos(-sunDeclination), arcRadius * sin(-sunDeclination))
	halfSunArcPoint = Point(arcRadius, 0)
	setdash("dot")
	arc2r(O, halfEquatorPointArcPos, halfSunArcPoint, :stroke)

	# Sun declination angle label
	fontsize(17)
	arcLabelRadius = arcRadius * 0.75
	arcLabelPoint = Point(arcLabelRadius * cos(-sunDeclination / 2), arcLabelRadius * sin(-sunDeclination / 2))
	label(string("α"), :E, arcLabelPoint)

	# Latitude angle arc
	arcRadius2 = 3 / 8 * R
	halfEquatorPointArc2Pos = Point(arcRadius2 * cos(-sunDeclination), arcRadius2 * sin(-sunDeclination))
	arcticCircleArcPosPoint = Point(arcRadius2 * cos(-sunDeclination + latitude), arcRadius2 * sin(-sunDeclination + latitude))
	move(halfEquatorPointArc2Pos)
	arc2r(O, halfEquatorPointArc2Pos, arcticCircleArcPosPoint, :stroke)

	# Latitude angle label
	arcLabel2Radius = arcRadius2 * 0.75
	arcLabel2Point = Point(arcLabel2Radius * cos(-sunDeclination + latitude / 2), arcLabel2Radius * sin(-sunDeclination + latitude / 2))
	move(arcLabel2Point)
	label(string("θ"), :W, arcLabel2Point)

	# Latitude-Horizon Line
	setdash("dash")
	horizonLinePoint = arcticCirclePointPos + Point((R + dR) * cos(-sunDeclination + latitude - 90u"°"), (R + dR) * sin(-sunDeclination + latitude - 90u"°"))
	line(arcticCirclePointPos, horizonLinePoint, :stroke)

	# Sun Beams
	sethue("gold")
	setdash("solid")
	sunStartPoint = arcticCirclePointPos + Point(R + dR, 0)
	arrow(arcticCirclePointPos + Point(R + dR, 0), arcticCirclePointPos, linewidth=1.0, arrowheadlength=10)
	arrow(O + Point(R + 3 * dR, 0), O + Point(R, 0), linewidth=1.0, arrowheadlength=10)

	# Altitude angle arc (lower)
	setdash("dot")
	sethue(regularColor)
	vertexPoint = Point(R / cos(latitude - sunDeclination), 0)
	arcRadius3 = 3 / 8 * R
	topPoint = vertexPoint + Point(-arcRadius3 * cos(altitude), arcRadius3 * sin(altitude))
	bottomPoint = vertexPoint + Point(-arcRadius3, 0)
	move(topPoint)
	arc2r(vertexPoint, topPoint, bottomPoint, :stroke)

	# Altitude angle arc (lower)
	move(bottomPoint)
	label(string("χ"), :SE, bottomPoint, offset=10,
    leader=false,
    leaderoffsets=[10.0, 100.0])

	# Altitude angle arc (lower)
	setdash("dot")
	vertexPoint2 = arcticCirclePointPos
	arcRadius3 = 3 / 8 * R
	topPoint = vertexPoint2 + Point(arcRadius3, 0)
	bottomPoint = vertexPoint2 + Point(arcRadius3 * cos(altitude), -arcRadius3 * sin(altitude))
	move(bottomPoint)
	arc2r(vertexPoint2, bottomPoint, topPoint, :stroke)

	# Altitude angle (upper)
	move(arcticCirclePointPos)
	label(string("χ"), :S, bottomPoint, offset=10,
    leader=false,
    leaderoffsets=[10.0, 100.0])
end 400 400 "problems/ps1/EarthDiagram2.png"
