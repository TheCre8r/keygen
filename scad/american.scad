use <keygen.scad>
include <american.gen.scad>

module american(bitting="",
               outline_name="AM3",
               warding_name="AM3") {

    name = "American";

    /*
        Bitting is specified from bow to tip, 1-8, with 1 being the shallowest cut and 8 being the deepest.
        Example: 25363
    */

    outlines_k = ["AM"];
    outlines_v = [[outline_am3_points, outline_am3_paths,
                   [-outline_am3_points[61][0], -outline_am3_points[40][1]],
                   engrave_am3_points,
                   engrave_am3_paths]];
    wardings_k = ["AM3"];
    wardings_v = [warding_am3];

    outline_param = key_lkup(outlines_k, outlines_v, outline_name);
    outline_points = outline_param[0];
    outline_paths = outline_param[1];
    offset = outline_param[2];
    engrave_points = outline_param[3];
    engrave_paths = outline_param[4];

    warding_points = key_lkup(wardings_k, wardings_v, warding_name);
    
    cut_locations = [for(i=[.156:.125:.563]) i*25.4];
    depth_table = [for(i=[0.2840, 0.2684, 0.2528, 0.2372, 0.2215, 0.2059, 0.1903, 0.1747]) i*25.4];

    heights = key_code_to_heights(bitting, depth_table);

    difference() {
        if($children == 0) {
            key_blank(outline_points,
                      warding_points,
                      outline_paths=outline_paths,
                      engrave_right_points=engrave_points,
                      engrave_right_paths=engrave_paths,
                      engrave_left_points=engrave_points,
                      engrave_left_paths=engrave_paths,
                      offset=offset,
                      plug_diameter=12.7);
        } else {
            children(0);
        }
        key_bitting(heights, cut_locations, 1.27, cutter_height=3);
    }
}

// Defaults
bitting="";
outline="AM3";
warding="AM3";
american(bitting, outline, warding);
