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

#if os(Linux)
import Glibc
#else
import Darwin
#endif

fileprivate let month_length : [Int] = [31, 28, 31, 30, 31, 30,
                                        31, 31, 30, 31, 30, 31];
fileprivate let month_length_leap : [Int]  = [31, 29, 31, 30, 31, 30,
                                              31, 31, 30, 31, 30, 31];

fileprivate let month_offset : [Int]  = [  0,  31,  59,  90, 120, 151,
                                           181, 212, 243, 273, 304, 334];
fileprivate let month_offset_leap : [Int]  = [  0,  31,  60,  91, 121, 152,
                                                182, 213, 244, 274, 305, 335];

// Ordered in work week order, but numbered to simplify calculations
public enum Weekday : Int {
  case Monday = 1
  case Tuesday = 2
  case Wednesday = 3
  case Thursday = 4
  case Friday = 5
  case Saturday = 6
  case Sunday = 0

}
public enum Month : Int {
  case January = 1;
  case February = 2;
  case March = 3;
  case April = 4;
  case May = 5;
  case June = 6;
  case July = 7;
  case August = 8;
  case September = 9;
  case October = 10;
  case November = 11;
  case December = 12;
}
extension Month: CustomStringConvertible {
  public var description: String {
    switch self {
    case .January:
      return "January"
    case .February:
      return "February"
    case .March:
      return "March"
    case .April:
      return "April"
    case .May:
      return "May"
    case .June:
      return "June"
    case .July:
      return "July"
    case .August:
      return "August"
    case .September:
      return "September"
    case .October:
      return "October"
    case .November:
      return "November"
    case .December:
      return "December"
    }
  }
}

public enum JewishMonth : Int {
  case Tishri = 1;
  case Heshvan = 2;
  case Kislev = 3;
  case Tevet = 4;
  case Shevat = 5;
  case Adar = 6;
  case Veadar = 7;
  case Nisan = 8;
  case Iyar = 9;
  case Sivan = 10;
  case Tammuz = 11;
  case Av = 12;
  case Elul = 13;
}

public enum MoslemMonth : Int {
  case Muharram = 1;
  case Safar = 2;
  case RabiAlAwwal = 3;
  case RabiAthThani = 4;
  case JumadaLUla = 5;
  case JumadaTTania = 6;
  case Rajab = 7;
  case ShaBan = 8;
  case Ramadan = 9;
  case Shawwal = 10;
  case DhuLQaDa = 11;
  case DhuLHijja = 12;
}

public struct Date {
  var year: Int32;
  var month: Month;
  var day: UInt8;
  
  /*
   init?(packedDate str: String)
   {
   // I, J, K designate 1800, 1900 and 2000, we assume this is consistent
   // in the future
   var year = (str[str.startIndex].unicodeScalars.first!.value - Character("I").unicodeScalars.first!.value) * 100 + 1800;
   year += 10 * (str[str.index(str.startIndex, offsetBy:1)].unicodeScalars.first!.value - Character("0").unicodeScalars.first!.value);
   year += str[str.index(str.startIndex, offsetBy:2)].unicodeScalars.first!.value - Character("0").unicodeScalars.first!.value;
   var month = -1;
   if str[str.index(str.startIndex, offestBy:3)].isASCII && str[str.index(str.startIndex, offsetBy:3)].isNumber {
   month = str[str.index(str.startIndex, offsetBy:3)].unicodeScalars.first!.value - Character("0").unicodeScalars.first!.value;
   } else {
   month = str[str.index(str.startIndex, offsetBy:3)] - "A" + 10;
   }
   var day = -1;
   if str[str.index(str.startIndex, offestBy:4)].isASCII && str[str.index(str.startIndex, offestBy:4)].isNumber {
   day = str[str.index(str.startIndex, offestBy:4)] - Character("0").unicodeScalars.first!.value;
   } else {
   day = str[str.index(str.startIndex, offestBy:4)] - Character("A").unicodeScalars.first!.value + 10;
   }
   
   self.year = year;
   self.month = month;
   self.day = day;
   }
   */
  func
  isValid() -> Bool
  {
    if isLeapYear(year) {
      if (day <= month_length_leap[Int(month.rawValue)-1]) {
        return true;
      }
    } else {
      if (day <= month_length[Int(month.rawValue)-1]) {
        return true;
      }
    }
    return false;
  }
}

public struct Time {
  var hh: UInt8;
  var mm: UInt8;
  var sec: Double;
  func
  isValid() -> Bool
  {
    // Using 61 for seconds bounds to account for possible leap seconds
    if (hh < 24 && mm < 60 && 0.0 <= sec && sec < 61.0) {
      return true;
    }
    
    return false;
  }
  
}

public struct DateTime {
  var date: Date;
  var time: Time;
  func
  isValid() -> Bool
  {
    return date.isValid() && time.isValid();
  }

  init?(isoDate str: String)
  {
    //    var year:Int32 = 0, month:Int32 = 1, day:UInt8 = 1, hour:UInt8 = 0, minute:UInt8 = 0;
    //    var tz : Character = "\0"; var dummy: Character;
    //    var tz_h_offset:UInt8 = 0, tz_m_offset:UInt8 = 0;
    //    var secs: Double = 0.0;
    var dateTimeComps: [String];
    if str.firstIndex(of: "T") !=  nil {
      dateTimeComps = str.components(separatedBy: "T")
    } else {
      dateTimeComps = str.components(separatedBy: " ")
    }
    if dateTimeComps.count > 2 {
      return nil;
    }
    
    // Parse date
    let dateComps = dateTimeComps[0].components(separatedBy: "-");
    if dateComps.count != 3 {
      return nil
    }

    guard let yyyy = Int32(dateComps[0]) else {
      return nil
    }
    guard let mm = Int(dateComps[1]) else {
      return nil
    }
    guard let dd = UInt8(dateComps[2]) else {
      return nil
    }
    guard let mmAsMonth = Month(rawValue: mm) else {
      return nil
    }
    
    if (dd < 1) {
      return nil;
    }
    
    if (isLeapYear(yyyy)) {
      if (dd > month_length_leap[Int(mmAsMonth.rawValue)-1]) {
        return nil;
      }
    } else {
      if (dd > month_length[Int(mmAsMonth.rawValue)-1]) {
        return nil;
      }
    }
    
    date = Date(year: yyyy, month: mmAsMonth, day: dd)
    
    if dateTimeComps.count == 2 {
      // Parse time
      let timeComps = dateTimeComps[1].components(separatedBy: ":")
      
      guard let hh = UInt8(timeComps[0]) else {
        return nil
      }
      guard let mm = UInt8(timeComps[1]) else {
        return nil;
      }
      guard let secs = Double(timeComps[2]) else {
        return nil;
      }
      
      if hh >= 24 {
        return nil
      }
      if mm >= 60 {
        return nil
      }
      
      if secs >= 61 { // Leapseconds
        return nil
      }
      
      time = Time(hh: hh, mm: mm, sec: secs)
    } else {
      time = Time(hh: 0, mm: 0, sec: 0)
    }
    
#if false
    
    if (i == 4) {
      var hhmm_bytes = 0, sec_bytes = 0;
      
      var j = sscanf(str + iso_date_bytes, "%d:%d%n", &hour, &minute, &hhmm_bytes);
      j = sscanf(str + iso_date_bytes + hhmm_bytes, ":%lf%n", &secs, &sec_bytes);
      
      j = sscanf(str + iso_date_bytes + hhmm_bytes + sec_bytes, "%c%d:%d",
                 &tz, &tz_h_offset, &tz_m_offset);
      
    }
    
    
    if (tz == "+") {
      time.hh -= tz_h_offset;
      time.mm -= tz_m_offset;
    }
    
    if (tz == "-") {
      time.hh += tz_h_offset;
      time.mm -= tz_m_offset;
    }
    
    if (time.sec >= 60.0) {
      time.mm += UInt8(time.sec / 60.0);
      time.sec = fmod(time.sec, 60.0);
    }
    
    if (time.mm >= 60) {
      time.hh += time.mm / 60;
      time.mm = time.mm % 60;
    }
    
    if (time.hh >= 24) {
      date.day += time.hh / 24;
      time.hh = time.hh % 24;
    }
#endif
  }
}

func
isLeapYear(_ y: Int32) -> Bool
{
  if (y % 400) == 0 {return true;}
  if (y % 100) == 0 {return false;}
  if (y % 4) == 0 {return true;}
  return false;
}


func
cm_julianCenturiesFromEpoch(jd:  Double, epoch: Double) -> Double
{
  return (jd-epoch)/36525.0;
}




func
cm_tcbToTdb(tcb: Double) -> Double
{
  return tcb - CM_LB * (tcb - CM_TCB_0) + CM_TDB0 / 86400.0;
}

func
cm_tdbToTcb(tdb: Double) -> Double
{
  return (tdb - CM_TDB0 / 86400.0 - CM_LB * CM_TCB_0) / (1.0-CM_LB);
}

func
cm_ttToTdb(tt: Double)->Double
{
  let g = 357.53.deg + 0.9856003.deg * ( tt - 2451545.0 );
  
  return tt + (0.001658 * sin( g ) + 0.000014 * sin( 2*g ))/SEC_PER_JD;
}

func
cm_tdbToTt(tdb: Double) -> Double
{
  return 0
}

func
cm_gpsToTai(gps: Double)->Double
{
  return gps + 19.0/SEC_PER_JD;
}

func
cm_taiToGps(tai: Double)->Double
{
  return tai - 19.0/SEC_PER_JD;
}

func
cm_taiToTt(tai: Double)->Double
{
  return tai + 32.184/SEC_PER_JD;
}
func
cm_ttToTai(tt: Double)->Double
{
  return tt - 32.184/SEC_PER_JD;
}

func
cm_tcgToTt(tcg: Double)->Double
{
  let EJD = 2443144.5003725;
  return EJD + (tcg - EJD) * (1.0 - CM_LG);
}

func
cm_ttToTcg(tt: Double)->Double
{
  let EJD = 2443144.5003725;
  return (tt - EJD)/(1.0 - CM_LG) + EJD;
}

func
cm_tdtToTdb( tdt: Double)->Double
{
  let T = (tdt - 2451545.0) / 36525;
  let g = (M_2_PI * (357.528 + 35999.050 * T)) / 360.0;
  let TDB = tdt + 0.001658 * sin(g + 0.0167 * sin(g));
  return TDB;
}

func
cm_tdbToTdt( tdb: Double)->Double
{
  let T = (tdb - 2451545.0) / 36525;
  let g = (M_2_PI * (357.528 + 35999.050 * T)) / 360.0;
  let TDT = tdb - 0.001658 * sin(g + 0.0167 * sin(g));
  return TDT;
}

