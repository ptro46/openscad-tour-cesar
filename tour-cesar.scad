
/* [Hidden] */
$fn=200;

echelle = 1 ;

tour_base_d = echelle * 13.78 ;
tour_espace_deux_faces = echelle * 12.73 ;
tour_base_h = echelle * 20.55 ;

tour_haut_d = tour_base_d ;
tour_haut_h = (echelle * 30) - tour_base_h ;

tour_fenetre_y = echelle * 1 ;
tour_fenetre_x = tour_espace_deux_faces ;
tour_fenetre_z = echelle * 2 ;
tour_fenetre_p = echelle * 1 ;

module fenetre_tour(alpha) {
    translate([0,0,tour_base_h-tour_fenetre_z/2]) {
        rotate([0,0,alpha]) {
            translate([0,tour_fenetre_y,0]) {
                difference() {
                    cube([tour_fenetre_x*2,tour_fenetre_y,tour_fenetre_z],center=true);
                    cube([tour_fenetre_x-tour_fenetre_p,2*tour_fenetre_y,2*tour_fenetre_z],center=true);
                }
            }

            translate([0,-tour_fenetre_y,0]) {
                difference() {
                    cube([tour_fenetre_x*2,tour_fenetre_y,tour_fenetre_z],center=true);
                    cube([tour_fenetre_x-tour_fenetre_p,2*tour_fenetre_y,2*tour_fenetre_z],center=true);
                }
            }
        }
    }
}

module tour_centrale() {
    rotate([0,0,360/16]) {
        difference() {
            union() {
                cylinder(h=tour_base_h,r=tour_base_d/2,$fn=8);
                translate([0,0,tour_base_h]) {
                    cylinder(h=tour_haut_h, r1=tour_haut_d/2, r2=0, $fn=8);
                }
            }
            fenetre_tour(-360/16);
            fenetre_tour(3*-360/16);
            fenetre_tour(5*-360/16);
            fenetre_tour(7*-360/16);
        }
    }
}

coursive_x = echelle * 4;
coursive_x2 = echelle * 2.5;
coursive_y = echelle * 11 ;
coursive_y_retait = echelle * 1.5;
coursive_z1 = echelle * 14 ;
coursive_z2 = echelle * 12.45 ;
coursive_z3 = echelle * 11.5 ;

coursive_boolean_y = echelle * 7.8 ;
coursive_boolean_z = echelle * 2 ;
coursive_boolean_z_shift = echelle * (1/8) ;

x1 = 0 ;
y1 = - coursive_y / 2 ;
z1 = 0 ;

x2 = coursive_x2 ;
y2 = - coursive_y / 2 ;
z2 = 0 ;

x3 = coursive_x2 ;
y3 = - coursive_y / 2 ;
z3 = coursive_z2 ;

x4 = 0 ;
y4 = - coursive_y / 2 ;
z4 = coursive_z1 ;

x5 = 0 ;
y5 = + coursive_y / 2 ;
z5 = 0 ;

x6 = coursive_x2 ;
y6 = + coursive_y / 2 ;
z6 = 0 ;

x7 = coursive_x2 ;
y7 = + coursive_y / 2 ;
z7 = coursive_z2 ;

x8 = 0 ;
y8 = + coursive_y / 2 ;
z8 = coursive_z1 ;

x9 = coursive_x ;
y9 = - (coursive_y / 2 - coursive_y_retait) ;
z9 = 0 ;

x10 = coursive_x ;
y10 = - (coursive_y / 2 - coursive_y_retait) ;
z10 = coursive_z3 ;

x11 = coursive_x ;
y11 = (coursive_y / 2 - coursive_y_retait) ;
z11 = coursive_z3 ;

x12 = coursive_x ;
y12 = (coursive_y / 2 - coursive_y_retait) ;
z12 = 0 ;

cube_size = 1 ;

coursive_points_translations = [ 
        [0,0,0,0], // 0
        [-1,0,0,0], // 1
        [-1,0,-1,0], // 2
        [0,0,-1,1], // 3 Rotation
        [0,-1,0,0], // 4
        [-1,-1,0,0], // 5
        [-1,-1,-1,0], // 6
        [0,-1,-1,1], // 7 Rotation
        [-1,0,0,0], // 8
        [-1,0,-1,0], // 9
        [-1,-1,-1,0], // 10
        [-1,-1,0,0] // 11
];
coursive_points = [ 
        [x1,y1,z1], // 0
        [x2,y2,z2], // 1
        [x3,y3,z3], // 2
        [x4,y4,z4], // 3
        [x5,y5,z5], // 4
        [x6,y6,z6], // 5
        [x7,y7,z7], // 6
        [x8,y8,z8], // 7
        [x9,y9,z9], // 8
        [x10,y10,z10], // 9
        [x11,y11,z11], // 10
        [x12,y12,z12] ] ; // 11

coursive_faces = [
    [0,1,2,3],    // 0
    [0,3,7,4],    // 1
    [0,1,5,4],    // 2
    [4,5,6,7],    // 3
    [2,3,7,6],    // 4
    [2,6,10,9],   // 5
    [6,10,11,5],  // 6
    [2,9,8,1],    // 7
    [1,5,11,8],   // 8
    [8,11,10,9]]; // 9

/*
module coursive() {
        polyhedron(coursive_points, coursive_faces);
        translate([0,0,coursive_z3-coursive_boolean_z/2-coursive_boolean_z_shift-2]) {
            //cube([coursive_x*3,coursive_boolean_y,coursive_boolean_z],center=true);
        }
}
*/
// keep
module plot_point(p, point_translations, color) {
    translate([p[0],p[1],p[2]]) {
        color(color) {
            translate([point_translations[0],point_translations[1],point_translations[2]]) {
                if ( point_translations[3] == 1 ) {
                    difference() {
                        cube(cube_size);
                        translate([0,-cube_size/2,cube_size]) {
                            rotate([0,+45,0]) {
                                cube([2*cube_size,2*cube_size,cube_size]);
                            }
                        }
                    }
                } else {
                    cube(cube_size);
                }
            }
        }
    }    
}

// keep
module plot_points(p1,p2,p3,p4) {
    plot_point(coursive_points[p1], coursive_points_translations[p1], "red");
    plot_point(coursive_points[p2], coursive_points_translations[p2], "blue");
    plot_point(coursive_points[p3], coursive_points_translations[p3], "green");
    plot_point(coursive_points[p4], coursive_points_translations[p4], "purple");
    
}

// keep
module plot_coursive_face(face_index) {
    faces = coursive_faces[face_index];
    plot_points( faces[0], faces[1], faces[2], faces[3] ) ;
}

coursive_alcove_h1 = echelle * 3.09 ;
coursive_alcove_d1 = echelle * 1.24 ;

coursive_alcove_h2 = echelle * 0.2 ;
coursive_alcove_d2 = echelle * 1.48 ;

coursive_alcove_h3 = echelle * 0.3 ;
coursive_alcove_d3 = echelle * 1.78 ;

coursive_alcove_h4 = echelle * 1.57 ;
coursive_alcove_d4 = echelle * 1.24 ;
coursive_alcove_p4 = echelle * 1 ;

coursive_alcove_h5 = echelle * 1.57 ;
coursive_alcove_d5 = echelle * 0.41 ;
coursive_alcove_p5 = echelle * 1 ;

coursive_charpente_l1 = echelle * coursive_boolean_y * 1.02;
coursive_charpente_size = echelle * 0.2;
coursive_charpente_l2 = echelle * coursive_boolean_z * 1.02;

coursive_charpente_l3 = echelle * 1.13 * 1.02 ;

// keep
module draw_coursive() {
    union() {
        difference() {
            hull() {
                for(indexOfFace = [0 : len(coursive_faces)-1] ) {
                    plot_coursive_face( indexOfFace ) ;
                }
            }
            translate([0,0,coursive_z3-coursive_boolean_z/2-coursive_boolean_z_shift]) {
                cube([coursive_x*3,coursive_boolean_y,coursive_boolean_z],center=true);
            }
            translate([coursive_x,0,0]) {
                translate([0,0,coursive_alcove_h1 + coursive_alcove_h2 + coursive_alcove_h3]) {
                    translate([-coursive_alcove_p4/2, -coursive_alcove_d4/2, 0]) {
                        cube([coursive_alcove_p4, coursive_alcove_d4, coursive_alcove_h4]);
                    }
                }
                translate([-coursive_alcove_p4/2,0,coursive_alcove_h1 + coursive_alcove_h2 + coursive_alcove_h3 + coursive_alcove_h4]) {
                    rotate([0,90,0]) {
                        cylinder(h=2*coursive_alcove_p4,r=coursive_alcove_d4/2);
                    }
                }
                translate([0,0,coursive_alcove_h1 + coursive_alcove_h2 + coursive_alcove_h3]) {
                    translate([-coursive_alcove_p4/2-coursive_alcove_p5/2, -coursive_alcove_d5/2, 0]) {
                        cube([coursive_alcove_p5, coursive_alcove_d5, coursive_alcove_h5]);
                    }
                }
                translate([-coursive_alcove_p4/2-coursive_alcove_p5/2,0,coursive_alcove_h1 + coursive_alcove_h2 + coursive_alcove_h3 + coursive_alcove_h4]) {
                    rotate([0,90,0]) {
                        cylinder(h=2*coursive_alcove_p5,r=coursive_alcove_d5/2);
                    }
                }
            }
        }    
        translate([coursive_x,0,0]) {
            rotate([0,0,90]) {
                cylinder(h=coursive_alcove_h1, r=coursive_alcove_d1/2, $fn=6);
            }
            translate([0,0,coursive_alcove_h1]) {
                rotate([0,0,90]) {
                    cylinder(h=coursive_alcove_h2, r=coursive_alcove_d2/2, $fn=6);
                }
            }
            translate([0,0,coursive_alcove_h1 + coursive_alcove_h2]) {
                rotate([0,0,90]) {
                    cylinder(h=coursive_alcove_h3, r=coursive_alcove_d3/2, $fn=6);
                }
            }
        }
    }
    
    union() {
        translate([0,0,coursive_z3-coursive_boolean_z/2-coursive_boolean_z_shift]) {
            translate([coursive_x-coursive_charpente_size,0,0]) {
                translate([0,-coursive_charpente_l1/2,-coursive_boolean_z/2+coursive_boolean_z/4]) {
                    cube([coursive_charpente_size,coursive_charpente_l1,coursive_charpente_size]);
                }
                translate([0, coursive_charpente_l1/6, -coursive_charpente_l2/2]) {
                    cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l2]);
                }
                translate([0, -coursive_charpente_l1/6, -coursive_charpente_l2/2]) {
                    cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l2]);
                }
                z_shift = sqrt(coursive_charpente_l3*coursive_charpente_l3/2);
                translate([0, -coursive_charpente_l1/6, coursive_charpente_l2/2-z_shift]) {
                    rotate([45,0,0]) {
                        difference() {
                            cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l3]);
                            translate([-coursive_charpente_size/2,+coursive_charpente_size,coursive_charpente_l3-coursive_charpente_size/2]) {
                                rotate([45,0,0])
                                cube([2*coursive_charpente_size,coursive_charpente_size,coursive_charpente_size]);
                            }
                        }
                    }
                }

                translate([0, +coursive_charpente_l1/6, coursive_charpente_l2/2-z_shift]) {
                    rotate([45,0,0]) {
                        difference() {
                            cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l3]);
                            translate([-coursive_charpente_size/2,+coursive_charpente_size,coursive_charpente_l3-coursive_charpente_size/2]) {
                                rotate([45,0,0])
                                cube([2*coursive_charpente_size,coursive_charpente_size,coursive_charpente_size]);
                            }
                        }
                    }
                }

                translate([0, 3*coursive_charpente_l1/6-z_shift2/2, coursive_charpente_l2/2-z_shift]) {
                    difference() {
                        rotate([45,0,0]) {
                            difference() {
                                cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l3]);
                                translate([-coursive_charpente_size/2,+coursive_charpente_size,coursive_charpente_l3-coursive_charpente_size/2]) {
                                    rotate([45,0,0])
                                    cube([2*coursive_charpente_size,coursive_charpente_size,coursive_charpente_size]);
                                }
                            }
                        }
                        translate([-coursive_charpente_size/2,coursive_charpente_size/4,0]) {
                            cube([2*coursive_charpente_size,coursive_charpente_size,2*coursive_charpente_size]);
                        }
                    }
                }

                z_shift2 = sqrt(coursive_charpente_size*coursive_charpente_size/2);
                translate([0, -coursive_charpente_l1/6, coursive_charpente_l2/2-z_shift]) {
                    translate([0,coursive_charpente_size-z_shift2,z_shift2])
                    rotate([-45,0,0]) {
                        difference() {
                            cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l3]);
                            translate([-coursive_charpente_size/2,-coursive_charpente_size,coursive_charpente_l3-coursive_charpente_size/2]) {
                                translate([0,coursive_charpente_size,0]) {
                                    rotate([45,0,0])
                                    cube([2*coursive_charpente_size,coursive_charpente_size,coursive_charpente_size]);
                                }
                            }
                        }
                    }
                }

                translate([0, +coursive_charpente_l1/6, coursive_charpente_l2/2-z_shift]) {
                    translate([0,coursive_charpente_size-z_shift2,z_shift2])
                    rotate([-45,0,0]) {
                        difference() {
                            cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l3]);
                            translate([-coursive_charpente_size/2,-coursive_charpente_size,coursive_charpente_l3-coursive_charpente_size/2]) {
                                translate([0,coursive_charpente_size,0]) {
                                    rotate([45,0,0])
                                    cube([2*coursive_charpente_size,coursive_charpente_size,coursive_charpente_size]);
                                }
                            }
                        }
                    }
                }

                translate([0, -3*coursive_charpente_l1/6-z_shift2, coursive_charpente_l2/2-z_shift]) {
                    difference() {
                        translate([0,coursive_charpente_size-z_shift2,z_shift2]) {
                            rotate([-45,0,0]) {
                                difference() {
                                    cube([coursive_charpente_size,coursive_charpente_size,coursive_charpente_l3]);
                                    translate([-coursive_charpente_size/2,-coursive_charpente_size,coursive_charpente_l3-coursive_charpente_size/2]) {
                                        translate([0,coursive_charpente_size,0]) {
                                            rotate([45,0,0])
                                            cube([2*coursive_charpente_size,coursive_charpente_size,coursive_charpente_size]);
                                        }
                                    }
                                }
                            }
                        }
                        translate([0,0,-coursive_charpente_size/2]) {
                            cube([2*coursive_charpente_size,coursive_charpente_size,2*coursive_charpente_size]);
                        }
                    }
                }
            }
        }
    }
}

tour_jonction_x = echelle * 3.61 ;
tour_jonction_y = echelle * 4.63 ;
tour_jonction_z = coursive_z1 ;

tour_jonction_rayon = 0.6 ;

module tour_jonction_internal() {
    hull() {
        translate([tour_jonction_x/2-tour_jonction_rayon,0,-tour_jonction_z/2+tour_jonction_rayon]) {
            rotate([90,0,0]) {
                cylinder(h=tour_jonction_y+0.2,r=tour_jonction_rayon,center=true);
            }
        }
        translate([-(tour_jonction_x/2-tour_jonction_rayon),0,-tour_jonction_z/2+tour_jonction_rayon]) {
            rotate([90,0,0]) {
                cylinder(h=tour_jonction_y+0.2,r=tour_jonction_rayon,center=true);
            }
        }
        translate([tour_jonction_x/2-tour_jonction_rayon,0,+tour_jonction_z/2-tour_jonction_rayon]) {
            rotate([90,0,0]) {
                cylinder(h=tour_jonction_y+0.2,r=tour_jonction_rayon,center=true);
            }
        }
        translate([-(tour_jonction_x/2-tour_jonction_rayon),0,+tour_jonction_z/2-tour_jonction_rayon]) {
            rotate([90,0,0]) {
                cylinder(h=tour_jonction_y+0.2,r=tour_jonction_rayon,center=true);
            }
        }
    }
}

module tour_jonction(alpha,x,y) {
    coursive_shift = tour_espace_deux_faces/2-coursive_x2/4;
    translate([x*coursive_shift,y*coursive_shift,tour_jonction_z/2]) {
        rotate([0,0,alpha]) {
            tour_jonction_internal();
        }
    }
}


module sans_tour_centrale() {
    union() {
        coursive_shift = tour_espace_deux_faces/2-coursive_x2/4;
        translate([coursive_shift,0,0]) { 
            draw_coursive();
        }

        translate([-coursive_shift,0,0]) { 
            rotate([0,0,180]) {
                draw_coursive();
            }
        }

        translate([0,-coursive_shift,0]) { 
            rotate([0,0,-90]) {
                draw_coursive();
            }
        }

        translate([0,+coursive_shift,0]) { 
            rotate([0,0,90]) {
                draw_coursive();
            }
        }
        tour_jonction(45,1,-1);
        tour_jonction(45,-1,1);
        tour_jonction(-45,1,1);
        tour_jonction(-45,-1,-1);
    }
}

minitour_d = echelle * 4.12 ;
minitour_h1 = echelle * 14 ; 
minitour_h_total = echelle * 18.54;
minitour_h2 = minitour_h_total - minitour_h1 ;
minitour_fenetre_x = echelle * 1 ;
minitour_fenetre_y = echelle * 1 ;
minitour_fenetre_z = echelle * 2 ;

module mini_tour(x,y) {
    coursive_shift = tour_espace_deux_faces/2-coursive_x2/4+tour_jonction_x/2;
    translate([x*coursive_shift,y*coursive_shift,0]) {
        difference() {
            union() {
                cylinder(h=minitour_h1,r=minitour_d/2,center=false);
                translate([0,0,minitour_h1]) {
                    cylinder(h=minitour_h2,r1=minitour_d/2,r2=0,center=false);
                }
            }
            translate([x*cos(45)*minitour_d/2,y*sin(45)*minitour_d/2,minitour_h1-2*minitour_fenetre_z]) {
                rotate([0,0,45]) {
                    cube([minitour_fenetre_x, minitour_fenetre_y, minitour_fenetre_z],center=true);
                }
            }
        }
    }
}

module main() {
    union() {
        tour_centrale();
        coursive_shift = tour_espace_deux_faces/2-coursive_x2/4;
        translate([coursive_shift,0,0]) { 
            draw_coursive();
        }

        translate([-coursive_shift,0,0]) { 
            rotate([0,0,180]) {
                draw_coursive();
            }
        }

        translate([0,-coursive_shift,0]) { 
            rotate([0,0,-90]) {
                draw_coursive();
            }
        }

        translate([0,+coursive_shift,0]) { 
            rotate([0,0,90]) {
                draw_coursive();
            }
        }
        tour_jonction(45,1,-1);
        mini_tour(1,-1);

        tour_jonction(45,-1,1);
        mini_tour(-1,1);

        tour_jonction(-45,1,1);
        mini_tour(1,1);

        tour_jonction(-45,-1,-1);
        mini_tour(-1,-1);
    }
}
/*
mini_tour(1,1);
mini_tour(-1,1);
mini_tour(1,-1);
mini_tour(-1,-1);
*/
scale([4,4,4]) {
    main();
}
//draw_coursive();
//main();
