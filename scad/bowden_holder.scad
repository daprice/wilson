//Configuration

filament_tol = 1; //extra diameter in filament path

include <MCAD/nuts_and_bolts.scad>

mount();

module mount(groovemount=true) {
	//mounting dimensions
	hole_dist = 50;
	base_thick=4.75;
	base_w = 20;
	base_l = 60;

	//hotend dimensions – standard groovemount (http://reprap.org/wiki/Groove_Mount)
	hotend_d = 16.2;
	hotend_above_mount = 4.75; //thickness of the part of the hotend that sticks above the mounting plate
	hotend_groove_d = 12;
	hotend_groove_thick = 4.75;

	hotend_tol = 0.1;
	
	difference() {
		//base rectangle
		cube([base_w, base_l, base_thick]);

		//bolt holes
		translate([base_w / 2, base_l / 2, 0]) {
			translate([0, -hole_dist / 2, 0]) {
				boltHole(size = 4, length = base_thick);
				translate([0,0,base_thick - METRIC_NUT_THICKNESS[4]]) nutHole(size = 4);
			}
			translate([0, hole_dist / 2, 0]) {
				boltHole(size = 4, length = base_thick);
				translate([0,0,base_thick - METRIC_NUT_THICKNESS[4]]) nutHole(size = 4);
			}
		}
	
		//space for upper part of hotend if using normal groovemount
		if(groovemount == true) {
			translate([base_w / 2, base_l / 2, -0.01]) {
				cylinder(d = hotend_d + hotend_tol*2, h = hotend_above_mount + hotend_tol);
			}
		}
	}

	translate([base_w / 2, base_l / 2, base_thick]) {
		children();
	}
}
