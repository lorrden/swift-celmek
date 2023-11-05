//
//  AtmosphereTest.swift
//  
//
//  Created by Mattias Holm on 2023-11-05.
//

import XCTest
import Aerodynamics
final class AtmosphereTest: XCTestCase {

    func testExample() throws {
      let atm = EarthAtmosphere()
      XCTAssertEqual(1.789, atm.dynamicViscosity(at: 0))
    }
}
