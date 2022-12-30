//
//  File.swift
//  
//
//  Created by Mattias Holm on 2022-12-25.
//

import Foundation

extension EclipticCoordinate {
  init(equatorial: EquatorialCoordinate, obliquityOfEcliptic: Double) {
    let 𝛼 = equatorial.rightAscension
    let 𝛿 = equatorial.declination
    let 𝜀 = obliquityOfEcliptic
    
    let 𝜆 = atan2(sin(𝛼) * cos(𝜀) + tan(𝛿) * sin(𝜀), cos(𝛼))
    let sin𝛽 = sin(𝛿) * cos(𝜀) - cos(𝛿) * sin(𝜀) * sin(𝛼)
    
    let 𝛽 = asin(sin𝛽)
    
    latitude = 𝛽
    longitude = 𝜆
  }
}


extension EquatorialCoordinate {
  init(ecliptic: EclipticCoordinate, obliquityOfEcliptic: Double) {
    let 𝜆 = ecliptic.longitude
    let 𝛽 = ecliptic.latitude
    let 𝜀 = obliquityOfEcliptic

    let 𝛼 = atan2(sin(𝜆) * cos(𝜀) - tan(𝛽) * sin(𝜀), cos(𝜆))
    let sin𝛿 = sin(𝛽) * cos(𝜀) + cos(𝛽) * sin(𝜀) * sin(𝜆)

    let 𝛿 = asin(sin𝛿)

    rightAscension = 𝛼
    declination = 𝛿
  }
  
  
  init(horizontal: HorizontalCoordinate, localSiderealTime: Double, observerLatitude: Double) {
    let A = horizontal.azimuth
    let h = horizontal.altitude
    let 𝜑 = observerLatitude
    let 𝜃 = localSiderealTime

    let H = atan2(sin(A), (cos(A) * sin(𝜑) + tan(h) * cos(𝜑)))
    let sin𝛿 = sin(𝜑) * sin(h) - cos(𝜑) * cos(h) * cos(A)

    let 𝛿 = asin(sin𝛿)
    let 𝛼 = 𝜃 - H

    self.rightAscension = 𝛼
    self.declination = 𝛿
  }

  init(horizontal: HorizontalCoordinate, greenwichSiderealTime: Double, observerLatitude: Double, observerLongitude: Double) {
    let A = horizontal.azimuth
    let h = horizontal.altitude
    let 𝜑 = observerLatitude
    let 𝜃₀ = greenwichSiderealTime
    let L = observerLongitude
    let H = atan2(sin(A), (cos(A) * sin(𝜑) + tan(h) * cos(𝜑)))
    let sin𝛿 = sin(𝜑) * sin(h) - cos(𝜑) * cos(h) * cos(A)
    
    let 𝛿 = asin(sin𝛿)
    let 𝛼 = 𝜃₀ - L - H

    self.rightAscension = 𝛼
    self.declination = 𝛿
  }
}

extension HorizontalCoordinate {
  init(localHourAngle: Double, observerLatitude: Double, declination: Double) {
    let 𝛿 = declination
    let H = localHourAngle
    let 𝜑 = observerLatitude

    let A = atan2(sin(H), (cos(H) * sin(𝜑) - tan(𝛿) * cos(𝜑)))
    let sinh = sin(𝜑) * sin(𝛿) + cos(𝜑) * cos(𝛿) * cos(H)

    let h = asin(sinh)

    self.altitude = h
    self.azimuth = A
  }
}


extension GalacticCoordinate {
  init(equatorial: EquatorialCoordinate) {
    let 𝛼 = equatorial.rightAscension
    let 𝛼₁₉₅₀ = B1950_RIGHT_ASCENSION_NORTH_POLE
    let 𝛿 = equatorial.declination
    let 𝛿₁₉₅₀ = B1950_DECLINATION_NORTH_POLE

    let x = atan2(sin(𝛼₁₉₅₀ - 𝛼), cos(𝛼₁₉₅₀ - 𝛼) * sin(𝛿₁₉₅₀) - tan(𝛿) * cos(𝛿₁₉₅₀))
    let l = 303.0.deg - x
    let sinb = sin(𝛿) * sin(𝛿₁₉₅₀) + cos(𝛿) * cos(𝛿₁₉₅₀) * cos(𝛼₁₉₅₀ - 𝛼)
    let b = asin(sinb)

    self.longitude = normalize(radians: l)
    self.latitude = b
  }
}

extension EquatorialCoordinate {
  init(galactic: GalacticCoordinate) {
    let l = galactic.longitude
    let b = galactic.latitude
    let 𝛿₁₉₅₀ = B1950_DECLINATION_NORTH_POLE

    let y = atan2(sin(l - 123.0.deg), (cos(l - 123.0.deg) * sin(𝛿₁₉₅₀) - tan(b) * cos(𝛿₁₉₅₀)))
    let 𝛼 = y + 12.25.deg
    let sin𝛿 = sin(b) * sin(𝛿₁₉₅₀) + cos(b) * cos(𝛿₁₉₅₀) * cos(l - 123.0.deg)

    self.rightAscension = 𝛼
    self.declination = asin(sin𝛿)
  }
}
