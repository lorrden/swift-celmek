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

public enum vsop87_body_id {
  case vsop87_sun
  case vsop87_mercury
  case vsop87_venus
  case vsop87_earth
  case vsop87_mars
  case vsop87_jupiter
  case vsop87_saturn
  case vsop87_uranus
  case vsop87_neptune
}

public class vsop87_body {
  let body_id: vsop87_body_id
  let terms_x: [[(Double,Double,Double)]];
  let terms_y: [[(Double,Double,Double)]];
  let terms_z: [[(Double,Double,Double)]];
  init(body: vsop87_body_id, tx :[[(Double,Double,Double)]], ty:[[(Double,Double,Double)]], tz:[[(Double,Double,Double)]]) {
    body_id = body
    terms_x = tx;
    terms_y = ty;
    terms_z = tz;
  }
  public func position(jd : Double) -> (SIMD3<Double>, SIMD3<Double>, Double, vsop87_body_id)
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

    let pos = SIMD3<Double>(px, py, pz);
    let vel = SIMD3<Double>(velx/365250.0, vely/365250.0,  velz/365250.0);
    return (pos, vel, jd, body_id);
  }
}
