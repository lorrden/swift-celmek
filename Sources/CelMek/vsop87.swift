//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2020-2022 Mattias Holm
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

public class vsop87_body {
  let terms_x: [[(Double,Double,Double)]];
  let terms_y: [[(Double,Double,Double)]];
  let terms_z: [[(Double,Double,Double)]];
  init(tx :[[(Double,Double,Double)]], ty:[[(Double,Double,Double)]], tz:[[(Double,Double,Double)]]) {
    terms_x = tx;
    terms_y = ty;
    terms_z = tz;
  }
  func pos_at_jd(jd : Double) -> ((Double,Double,Double), (Double,Double,Double), Double)
  {
    let t = (jd - 2451545.0) / 365250.0;
    
    var x = [Double](repeating: 0, count: 6);
    var y = [Double](repeating: 0, count: 6);
    var z = [Double](repeating: 0, count: 6);
    var vx = [Double](repeating: 0, count: 6);
    var vy = [Double](repeating: 0, count: 6);
    var vz = [Double](repeating: 0, count: 6);
    
    for i in terms_x.indices {
      for j in terms_x[i].indices {
        let (a,b,c) = terms_x[i][j];
        let term = a * cos(b + c * t);
        x[i] += term;
        let vterm = a * c * sin(b + c * t);
        vx[i] += vterm;
      }
    }
    
    for i in terms_y.indices {
      for j in terms_y[i].indices {
        let (a,b,c) = terms_y[i][j];
        let term = a * cos(b + c * t);
        y[i] += term;
        let vterm = a * c * sin(b + c * t);
        vy[i] += vterm;
      }
    }
    
    for i in terms_z.indices {
      for j in terms_z[i].indices {
        let (a,b,c) = terms_z[i][j];
        let term = a * cos(b + c * t);
        z[i] += term;
        let vterm = a * c * sin(b + c * t);
        vz[i] += vterm;
      }
    }
    
    var T = [Double](repeating: 0, count:6);
    T[0] = 1.0;
    for i in 1...5 {
      T[i] = T[i - 1] * t;
    }
    
    let px = x[0] + x[1] * T[1] + x[2] * T[2] + x[3] * T[3] + x[4] * T[4] +
    x[5] * T[5];
    let py = y[0] + y[1] * T[1] + y[2] * T[2] + y[3] * T[3] + y[4] * T[4] +
    y[5] * T[5];
    let pz = z[0] + z[1] * T[1] + z[2] * T[2] + z[3] * T[3] + z[4] * T[4] +
    z[5] * T[5];
    
    // ddt A cos (B + C t)                                    - A C   sin (B + C
    // t) So: A cos (B + C t) * t        :    (1 A cos (B + C t) - A C t sin (B +
    // C t))
    //     A cos (B + C t) * t * t    : t  (2 A cos (B + C t) - A C t sin (B + C
    //     t)) A cos (B + C t) * t * t * t: t2 (3 A cos (B + C t) - A C t sin (B +
    //     C t))
    
    let velx =
    -vx[0] + (1.0 * x[1] - T[1] * vx[1]) +
    (2.0 * T[1] * x[2] - T[2] * vx[2]) + (3.0 * T[2] * x[3] - T[3] * vx[3]) +
    (4.0 * T[3] * x[4] - T[4] * vx[4]) + (5.0 * T[4] * x[5] - T[5] * vx[5]);
    let vely =
    -vy[0] + (1.0 * x[1] - T[1] * vy[1]) +
    (2.0 * T[1] * x[2] - T[2] * vy[2]) + (3.0 * T[2] * x[3] - T[3] * vy[3]) +
    (4.0 * T[3] * x[4] - T[4] * vy[4]) + (5.0 * T[4] * x[5] - T[5] * vy[5]);
    let velz =
    -vz[0] + (1.0 * z[1] - T[1] * vz[1]) +
    (2.0 * T[1] * z[2] - T[2] * vz[2]) + (3.0 * T[2] * z[3] - T[3] * vz[3]) +
    (4.0 * T[3] * z[4] - T[4] * vz[4]) + (5.0 * T[4] * z[5] - T[5] * vz[5]);
    
    let pos = (px, py, pz);
    let vel = (velx/365250.0, vely/365250.0,  velz/365250.0);
    return (pos, vel, jd);
  }
  
}

// Include parameters, these are generated by the vsop termextract script
/*
 #include "vsop87-earth.inc"
 #include "vsop87-jupiter.inc"
 #include "vsop87-mars.inc"
 #include "vsop87-mercury.inc"
 #include "vsop87-neptune.inc"
 #include "vsop87-saturn.inc"
 #include "vsop87-sun.inc"
 #include "vsop87-uranus.inc"
 #include "vsop87-venus.inc"
 */
//static vsop87_body_t *bodies[] = {&sun,     &mercury, &venus,  &earth,  &mars,
//                                  &jupiter, &saturn,  &uranus, &neptune,
//                                  &sun, &earth}; // For SBC, and EMB

//vsop87_body_t *
//vsop87_get_body(cm_Body bodyid)
//{
//  assert(bodyid <= cmB_EMB);
//  return bodies[bodyid];
//}

// Derivative of A cos (B + C t) is -A C sin(B + Ct)
// So: A cos (B + C t) * t    : A cos (B + C t) - C t sin(B + C t)
//     A cos (B + C t) * t * t: A t (2 cos (B + C t) - C t sin (B + C t))
//     A cos (B + C t) * t * t * t: A t2 (3 cos (B+Ct) - Ct sin B+Ct)
/*
 cm_StateVectors
 vsop87_pos_at_jd(vsop87_body_t *body, cm_JulianDay jd)
 {
 cm_Real t = (jd - 2451545.0) / 365250.0;
 
 cm_Real x[6], y[6], z[6];
 cm_Real vx[6], vy[6], vz[6];
 memset(x, 0, sizeof(x));
 memset(y, 0, sizeof(y));
 memset(z, 0, sizeof(z));
 memset(vx, 0, sizeof(x));
 memset(vy, 0, sizeof(y));
 memset(vz, 0, sizeof(z));
 
 for (int i = 0; i < 6; i++) {
 for (int j = 0; j < body->size_x[i]; j++) {
 vsop87_term_t *coefs = &body->terms_x[i][j];
 cm_Real term = coefs->a * cos(coefs->b + coefs->c * t);
 x[i] += term;
 cm_Real vterm = coefs->a * coefs->c * sin(coefs->b + coefs->c * t);
 vx[i] += vterm;
 }
 }
 
 for (int i = 0; i < 6; i++) {
 for (int j = 0; j < body->size_y[i]; j++) {
 vsop87_term_t *coefs = &body->terms_y[i][j];
 cm_Real term = coefs->a * cos(coefs->b + coefs->c * t);
 y[i] += term;
 cm_Real vterm = coefs->a * coefs->c * sin(coefs->b + coefs->c * t);
 vy[i] += vterm;
 }
 }
 
 for (int i = 0; i < 6; i++) {
 for (int j = 0; j < body->size_z[i]; j++) {
 vsop87_term_t *coefs = &body->terms_z[i][j];
 cm_Real term = coefs->a * cos(coefs->b + coefs->c * t);
 z[i] += term;
 cm_Real vterm = coefs->a * coefs->c * sin(coefs->b + coefs->c * t);
 vz[i] += vterm;
 }
 }
 
 cm_StateVectors res;
 
 cm_Real T[6];
 T[0] = 1.0;
 for (int i = 1; i < 6; i++) {
 T[i] = T[i - 1] * t;
 }
 
 res.p.x = x[0] + x[1] * T[1] + x[2] * T[2] + x[3] * T[3] + x[4] * T[4] +
 x[5] * T[5];
 res.p.y = y[0] + y[1] * T[1] + y[2] * T[2] + y[3] * T[3] + y[4] * T[4] +
 y[5] * T[5];
 res.p.z = z[0] + z[1] * T[1] + z[2] * T[2] + z[3] * T[3] + z[4] * T[4] +
 z[5] * T[5];
 
 // ddt A cos (B + C t)                                    - A C   sin (B + C
 // t) So: A cos (B + C t) * t        :    (1 A cos (B + C t) - A C t sin (B +
 // C t))
 //     A cos (B + C t) * t * t    : t  (2 A cos (B + C t) - A C t sin (B + C
 //     t)) A cos (B + C t) * t * t * t: t2 (3 A cos (B + C t) - A C t sin (B +
 //     C t))
 
 res.v.x =
 -vx[0] + (1.0 * x[1] - T[1] * vx[1]) +
 (2.0 * T[1] * x[2] - T[2] * vx[2]) + (3.0 * T[2] * x[3] - T[3] * vx[3]) +
 (4.0 * T[3] * x[4] - T[4] * vx[4]) + (5.0 * T[4] * x[5] - T[5] * vx[5]);
 res.v.y =
 -vy[0] + (1.0 * x[1] - T[1] * vy[1]) +
 (2.0 * T[1] * x[2] - T[2] * vy[2]) + (3.0 * T[2] * x[3] - T[3] * vy[3]) +
 (4.0 * T[3] * x[4] - T[4] * vy[4]) + (5.0 * T[4] * x[5] - T[5] * vy[5]);
 res.v.z =
 -vz[0] + (1.0 * z[1] - T[1] * vz[1]) +
 (2.0 * T[1] * z[2] - T[2] * vz[2]) + (3.0 * T[2] * z[3] - T[3] * vz[3]) +
 (4.0 * T[3] * z[4] - T[4] * vz[4]) + (5.0 * T[4] * z[5] - T[5] * vz[5]);
 
 res.v.x /= 365250.0;
 res.v.y /= 365250.0;
 res.v.z /= 365250.0;
 
 res.epoch = jd;
 return res;
 }
 
 cm_StateVectors
 cm_vsop87(cm_Body body, cm_JulianDay jde)
 {
 vsop87_body_t *b = vsop87_get_body(body);
 return vsop87_pos_at_jd(b, jde);
 }
 
 bool
 cm_vsop87EphCompute(cm_Ephemeris *Eph, cm_JulianDay JD, cm_Body BodyID,
 cm_StateVectors *SV)
 {
 *SV = cm_vsop87(BodyID, JD);
 
 // Transform to FK5 / ICRF, the matrix given in vsop87.doc (it is not
 // actually, ICRF, but FK5 is close enough).
 static const cm_Mat3x3 R = {.vec = {{1.000000000000, 0.000000440360, -0.000000190919},
 {-0.000000479966, 0.917482137087, -0.397776982902},
 {0.000000000000, 0.397776982902, 0.917482137087}}};
 
 // Rotate to ICRF
 SV->p = cm_matVecMul(&R, SV->p); // As ICRF
 SV->v = cm_matVecMul(&R, SV->v); // As ICRF
 
 // Change units to m and m/s
 SV->p = cm_vecScalarMul(SV->p, CM_M_PER_AU);
 SV->v = cm_vecScalarMul(SV->v, CM_M_PER_AU/CM_SEC_PER_JD);
 return true;
 }
 
 cm_Ephemeris *
 cm_vsop87NewEphemeris(void)
 {
 static cm_Ephemeris Eph = {cm_vsop87EphCompute};
 return &Eph;
 }
 
 #if 0
 void
 vsop87_step_object(cm_orbit_t *obj, cm_world_t *state)
 {
 vsop87_body_t *body = obj->omod_data;
 
 cm_StateVectors pos = vsop87_pos_at_jd(body, state->jde);
 
 // Transform to FK5 / ICRF, the matrix given in vsop87.doc (it is not
 // actually, ICRF, but FK5 is close enough).
 cm_Mat3x3 R = {
 { 1.000000000000, 0.000000440360, -0.000000190919},
 {-0.000000479966, 0.917482137087, -0.397776982902},
 { 0.000000000000, 0.397776982902,  0.917482137087}};
 
 pos.p = md3_v_mul(R, pos.p);
 pos.v = md3_v_mul(R, pos.v);
 
 obj->p.x = pos.p.x * CM_AU_IN_M;
 obj->p.y = pos.p.y * CM_AU_IN_M;
 obj->p.z = pos.p.z * CM_AU_IN_M;
 
 obj->v.x = pos.v.x * CM_AU_IN_M / CM_SEC_PER_DAY;
 obj->v.y = pos.v.y * CM_AU_IN_M / CM_SEC_PER_DAY;
 obj->v.z = pos.v.z * CM_AU_IN_M / CM_SEC_PER_DAY;
 }
 #endif
 */