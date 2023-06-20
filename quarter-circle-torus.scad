// Generates a quarter circle with an origin in the middle of the enclosing
// square
//
// side: the bounding square of the quarter circle
// quadrant = 0: top left quarter circle
// quadrant = 1: bottom left quarter circle
// quadrant = 2: bottom right quarter circle
// quadrant = 3: top right quarter circle
module quarter_circle(side = 10, quadrant = 0) {
  quadrant = quadrant % 4;

  // 0: translate([side / 2, side / 2])
  // 1: translate([-side / 2, side / 2])
  // 2: translate([-side / 2, -side / 2])
  // 3: translate([side / 2, -side / 2])

  translate([
    quadrant == 0 || quadrant == 3 ? side / 2 : -side / 2,
    quadrant < 2 ? side / 2 : -side / 2
  ])

  rotate([0, 0, quadrant * 90])
  difference() {
    circle(side);
    square(side);
    translate([-side, 0]) square(side);
    translate([0, -side]) square(side);
  }
}

// Generates an inverted quarter circle with an origin in the middle of the
// enclosing square
//
// side: the bounding square of the inverted quarter circle
// quadrant = 0: top left inverted quarter circle
// quadrant = 1: bottom left inverted quarter circle
// quadrant = 2: bottom right inverted quarter circle
// quadrant = 3: top right inverted quarter circle
module inverted_quarter_circle(side = 10, quadrant = 0) {
  difference() {
    translate([-side / 2, -side / 2])
    square(side);

    quarter_circle(side, quadrant);
  }
}

// Generates a quarter torus
//
// angle: the extrusion angle
// radius: the radius of the torus hole
// side: the bounding square side of the looped quarter circle making the torus
// quadrant: the orientation and type of the slope of the hole (0-3, just try it)
module quarter_torus(angle = 360, radius = 10, side = 10, quadrant = 0) {
  rotate_extrude(angle = angle)
  translate([radius, 0, 0])
  quarter_circle(side, quadrant);
}

// Generates an inverted quarter torus
//
// angle: the extrusion angle
// radius: the radius of the torus hole
// side: the bounding square side of the looped inverted quarter circle making the torus
// quadrant: the orientation and type of the slope of the hole (0-3, just try it)
module inverted_quarter_torus(angle = 360, radius = 10, side = 10, quadrant = 0) {
  rotate_extrude(angle = angle)
  translate([radius, 0, 0])
  inverted_quarter_circle(side, quadrant);
}
