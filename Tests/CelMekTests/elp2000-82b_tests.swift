//
// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2020 Mattias Holm
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

import XCTest
@testable import CelMek;

final class elp2000_82b_tests : XCTestCase {
  func testELP2000() {
    
    let res = elp2000_82b(2448724.5);
    
    XCTAssertEqual(res.x, 133.162659.deg, accuracy: 0.00000002)
    XCTAssertEqual(res.y, -3.229127.deg, accuracy: 0.000000005)
    XCTAssertEqual(res.z, 368409.7e3, accuracy: 100.0)
  }
}




