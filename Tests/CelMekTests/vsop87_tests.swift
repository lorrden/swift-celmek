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

final class vsop87_tests: XCTestCase {
  func testSun() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       (-0.0071415279, -0.0027881715,   0.0002061418),
       ( 0.0000053774, -0.0000074073,  -0.0000000943)),
      
      (2415020.0,
       ( 0.0031876597, 0.0063575996, -0.0001036885),
       (-0.0000073486, 0.0000037875,  0.0000001748)),
      
      (2378495.0,
       (0.0034889967, -0.0058080486, -0.0000676295),
       (0.0000085927,  0.0000010321, -0.0000002331)),
      
      (2341970.0,
       (-0.0051304706,  0.0048363849, 0.0001251673),
       (-0.0000072111, -0.0000037196, 0.0000002127)),
      
      (2305445.0,
       (0.0070102895,  -0.0032796815,  -0.0002040514),
       (0.0000044023,  0.0000065880, -0.0000001369)),
      
      (2268920.0,
       (-0.0071641326,  0.0015976455, 0.0001823330),
       (-0.0000015913, -0.0000080258, 0.0000000583)),
      
      (2232395.0,
       ( 0.0044315256, 0.0026981130, -0.0001145173),
       (-0.0000019965, 0.0000066073,  0.0000000464)),
      
      (2195870.0,
       (0.0000452875, -0.0029730970, -0.0000055246),
       (0.0000047829, -0.0000048953, -0.0000001248)),
      
      (2159345.0,
       (-0.0005833297, 0.0040370497, 0.0000295777),
       (-0.0000055965, 0.0000025113, 0.0000001498)),
      
      (2122820.0,
       (0.0025292639, -0.0048917910, -0.0000943913),
       (0.0000066739,  0.0000004404, -0.0000001588)),
    ];
    
    
    
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = sun.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  func testMercury() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      
      (2451545.0,
       ( -0.1372349394,   -0.4500758422,   -0.0243922379),
       (0.0213717757,  -0.0064553869,  -0.0024879611)),
      
      (2415020.0,
       ( -0.3865370327,   -0.1438666201, 0.0235162485),
       (0.0042941824,  -0.0250124495,  -0.0024360336)),
      
      (2378495.0,
       ( -0.1648675270,0.2677027662,0.0377427323),
       (-0.0296078342,  -0.0136318150,  0.0016233014)),
      
      (2341970.0,
       (0.3205415662, 0.0929229659,   -0.0228568241),
       (-0.0127860861,  0.0284600632,  0.0034969058)),
      
      (2305445.0,
       (0.2384150859,   -0.3652917797,   -0.0510628721),
       (0.0181083086,  0.0166078886,  -0.0003330024)),
      
      (2268920.0,
       ( -0.1567195724,   -0.4393733656,   -0.0216303335),
       (0.0210084073,  -0.0075674055,  -0.0025678545)),
      
      (2232395.0,
       ( -0.3894336633,   -0.1261418632, 0.0262199265),
       (0.0029380205,  -0.0254246227,  -0.0023316424)),
      
      (2195870.0,
       ( -0.1453788216, 0.2807838472, 0.0365203626),
       (-0.0306544976,  -0.0116628832,  0.0019274325)),
      
      (2159345.0,
       (0.3334927268, 0.0695495586,   -0.0260366455
       ), (-0.0108199216,  0.0289975920,  0.0033527765)),
      
      (2122820.0,
       (0.2171621774,   -0.3801214149,   -0.0504926506
       ), (0.0188386487,  0.0155090442,  -0.0005236921)),
      
      
    ];
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = mercury.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  
  func testVenus() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       ( -0.7254438061,   -0.0354427729, 0.0412204390
       ), (0.0008035035,  -0.0203026261,  -0.0003235494)),
      
      (2415020.0,
       (0.7003304925,   -0.1970055158,   -0.0431238022
       ), (0.0055497756,  0.0193312684,  -0.0000622747)),
      
      (2378495.0,
       ( -0.5948645227, 0.3900421675, 0.0397561852
       ), (-0.0112328022,  -0.0169692226,  0.0004278513)),
      
      (2341970.0,
       (0.4479888577,   -0.5644057138,   -0.0334391564
       ), (0.0156800564,  0.0125190882,  -0.0007482063)),
      
      (2305445.0,
       ( -0.2431871346, 0.6700058594, 0.0227674272
       ), (-0.0190258336,  -0.0071537234,  0.0010142109)),
      
      (2268920.0,
       (0.0356693143,   -0.7243868493,   -0.0112201831
       ), (0.0200490235,  0.0011049336,  -0.0011510963)),
      
      (2232395.0,
       (0.1979737053, 0.6967549127,   -0.0030447904
       ), (-0.0195563545,  0.0053401143,  0.0012013458)),
      
      (2195870.0,
       ( -0.3829606678,   -0.6180606558, 0.0150864767
       ), (0.0170284808,  -0.0107959133,  -0.0011178669)),
      
      (2159345.0,
       (0.5637717281, 0.4559764948,   -0.0276947946
       ), (-0.0127166331,  0.0157008642,  0.0009206678)),
      
      (2122820.0,
       ( -0.6634865823,   -0.2802510190, 0.0356930259
       ), (0.0075919721,  -0.0187909113,  -0.0006524817)),
      
    ];
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = venus.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }  
  
  func testEarth() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.
    // jd, expected pos, expected velocity
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       (   -0.1842769826, 0.9644534530, 0.0002022407),
       (-0.0172022466, -0.0031661954, 0.0000000125)),
      
      (2415020.0,
       (   -0.1851203046, 0.9714264843, 0.0001113443),
       (-0.0171823836, -0.0033539678, -0.0000016179)),
      
      (2378495.0,
       (   -0.1959028024, 0.9569893872, 0.0003631317),
       (-0.0171247952, -0.0035554496, -0.0000027195)),
      
      (2341970.0,
       (   -0.2155959337, 0.9651943805, 0.0007724578),
       (-0.0170947692, -0.0037533612, -0.0000026916)),
      
      (2305445.0,
       (   -0.2144880004, 0.9545686380, 0.0006527746),
       (-0.0170346633, -0.0039301863, -0.0000044570)),
      
      (2268920.0,
       (   -0.2396421487, 0.9567952242, 0.0012516205),
       (-0.0169973289, -0.0041304729, -0.0000064480)),
      
      (2232395.0,
       (   -0.2390819118, 0.9551354477, 0.0011725857),
       (-0.0169567744, -0.0043032790, -0.0000078706)),
      
      (2195870.0,
       (   -0.2544150449, 0.9466173268, 0.0014906848),
       (-0.0169057747, -0.0045082713, -0.0000086699)),
      
      (2159345.0,
       (   -0.2660380501, 0.9505604081, 0.0017333491),
       (-0.0168673212, -0.0046977207, -0.0000095004)),
      
      (2122820.0,
       (   -0.2737854147, 0.9385067424, 0.0018171487),
       (-0.0167963362, -0.0048924916, -0.0000121874))]
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = earth.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  
  func testMars() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       ( 1.3835744053,   -0.0162038666,   -0.0342616574
       ), (0.0006768704,  0.0151798404,  0.0003015603)),
      
      (2415020.0,
       (0.4316209101,  -1.3488778274,   -0.0390687101
       ), (0.0138728496,  0.0054168276,  -0.0002307836)),
      
      (2378495.0,
       (-1.1084329672,  -1.1021343623, 0.0048532223
       ), (0.0103790668,  -0.0087770621,  -0.0004428402)),
      
      (2341970.0,
       (-1.6438794159, 0.2555469169, 0.0466857559
       ), (-0.0015743885,  -0.0126578969,  -0.0002239439)),
      
      (2305445.0,
       ( -0.8237565238,   1.4065798251, 0.0502495532
       ), (-0.0114853918,  -0.0059301717,  0.0001686389)),
      
      (2268920.0,
       (0.6423617628,   1.3673278774, 0.0118745680
       ), (-0.0120621499,  0.0071641240,  0.0004582895)),
      
      (2232395.0,
       ( 1.3954709858,   -0.0516858116,   -0.0372157904
       ), (0.0011336721,  0.0151526377,  0.0002844444)),
      
      (2195870.0,
       (0.3890526770,  -1.3690161892,   -0.0383864198
       ), (0.0140508638,  0.0049894676,  -0.0002631224)),
      
      (2159345.0,
       (-1.1446750445,  -1.0555162817, 0.0082476659
       ), (0.0100962898,  -0.0091119135,  -0.0004533508)),
      
      (2122820.0,
       (-1.6253192611, 0.3011276886, 0.0493271851
       ), (-0.0019767501,  -0.0126070725,  -0.0002070169)),
      
      
    ];
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = mars.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  
  func testJupiter() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       ( 3.9940325025,   2.9357928287,   -0.1015776146
       ), (-0.0045629454,  0.0064357940,  0.0000754864)),
      
      (2415020.0,
       (-3.0159347740,  -4.4518987729, 0.0857605014
       ), (0.0061580622,  -0.0038756290,  -0.0001223731)),
      
      (2378495.0,
       ( -0.0145500117,   5.1259668253,   -0.0201124860
       ), (-0.0076313358,  0.0003262441,  0.0001701710)),
      
      (2341970.0,
       ( 1.2766013837,  -5.0231716007,   -0.0089999829
       ), (0.0072210534,  0.0022211613,  -0.0001712770)),
      
      (2305445.0,
       (-4.0477856739,   3.4767059971, 0.0777919561
       ), (-0.0049916764,  -0.0053724276,  0.0001334034)),
      
      (2268920.0,
       ( 4.5819830419,  -1.9854861383,   -0.0959268981
       ), (0.0029172089,  0.0072697889,  -0.0000937555)),
      
      (2232395.0,
       (-5.4195080604,   -0.5058506154, 0.1246615312
       ), (0.0006233205,  -0.0071613018,  0.0000129349)),
      
      (2195870.0,
       ( 4.2423739220,   2.5868702423,   -0.1060362712
       ), (-0.0040046493,  0.0067878381,  0.0000657112)),
      
      (2159345.0,
       (-3.3560639242,  -4.2126331635, 0.0919713504),
       (0.0058193495,  -0.0043606659,  -0.0001165694)),
      
      (2122820.0,
       (0.4233154540,   5.0970673238,   -0.0281031462),
       (-0.0075968103,  0.0009711785,  0.0001700105)),
      
    ];
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = jupiter.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  func testSaturn() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       ( 6.3992653459,   6.5672047374,   -0.3688706482
       ), (-0.0042869773,  0.0038829091,  0.0001028562)),
      
      (2415020.0,
       ( -0.3664097224, -10.0518822109, 0.1915817572
       ), (0.0052665110,  -0.0002253719,  -0.0002048560)),
      
      (2378495.0,
       (-5.6756021085,   7.1094397729, 0.0977845010
       ), (-0.0046678881,  -0.0034932538,  0.0002468728)),
      
      (2341970.0,
       ( 8.9883454293,  -3.7834861555,   -0.2865137739
       ), (0.0018469420,  0.0051218853,  -0.0001648962)),
      
      (2305445.0,
       (-8.6500173348,  -4.4842589406, 0.4214211465
       ), (0.0022440687,  -0.0049669410,  0.0000016797)),
      
      (2268920.0,
       ( 5.0306933583,   7.5326602151,   -0.3347057171
       ), (-0.0049645512,  0.0031065834,  0.0001381424)),
      
      (2232395.0,
       ( 1.2645936162, -10.0240954525, 0.1345907665
       ), (0.0052022669,  0.0006981429,  -0.0002162249)),
      
      (2195870.0,
       (-7.1627672767,   5.7452916044, 0.1724906607
       ), (-0.0038122127,  -0.0043423789,  0.0002287161)),
      
      (2159345.0,
       ( 9.3505836060,  -2.1105535820,   -0.3230945800
       ), (0.0009045925,  0.0054638893,  -0.0001368694)),
      
      (2122820.0,
       (-7.9370266647,  -5.8484785039, 0.4164657927
       ), (0.0029893590,  -0.0044768249,  -0.0000312897)),
      
    ];
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = saturn.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000005)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  func testUranus() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       (14.4247519568, -13.7371045087,   -0.2379360887
       ), (0.0026834778,  0.0026652832,  -0.0000248664)),
      
      (2415020.0,
       (-6.4778956413, -17.8463318322, 0.0176898373
       ), (0.0036668409,  -0.0015250649,  -0.0000533417)),
      
      (2378495.0,
       (-18.2673444260, 0.9819574799, 0.2419668642
       ), (-0.0002434599,  -0.0041096277,  -0.0000123328)),
      
      (2341970.0,
       (-4.2265696170,  18.3208630949, 0.1248844668
       ), (-0.0038652588,  -0.0010646972,  0.0000464097)),
      
      (2305445.0,
       (16.1091090968,  11.4867931080,   -0.1666659528
       ), (-0.0023150571,  0.0030248642,  0.0000418267)),
      
      (2268920.0,
       (17.7611606376,  -9.2405618853,   -0.2678659421
       ), (0.0017846209,  0.0033118299,  -0.0000106469)),
      
      (2232395.0,
       ( -0.7823849124, -19.2505578584,   -0.0637569368
       ), (0.0038994140,  -0.0003366037,  -0.0000524530)),
      
      (2195870.0,
       (-17.6538791197,  -5.1666300880, 0.2124614028
       ), (0.0010739540,  -0.0039522427,  -0.0000294977)),
      
      (2159345.0,
       (-9.8292937630,  15.7752257095, 0.1915112173
       ), (-0.0033692251,  -0.0022566874,  0.0000356010)),
      
      (2122820.0,
       (11.8571754273,  15.5546452202,   -0.0951132908),
       (-0.0031579496,  0.0022097279,  0.0000504382)),
      
    ];
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = uranus.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000005)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
  func testNeptune() {
    let testValues: [(Double,(Double,Double,Double), (Double,Double,Double))] = [
      (2451545.0,
       (16.8049701269, -24.9944513569, 0.1274251215),
       (0.0025846351,  0.0017695229,  -0.0000960030)),
      
      (2415020.0,
       ( 1.5196434117,  29.8318114919,   -0.6492437025),
       (-0.0031531984,  0.0001800719,  0.0000689285)),
      
      (2378495.0,
       (-20.3104052892, -22.4966336300, 0.9308475718),
       (0.0023105203,  -0.0020855605,  -0.0000102628)),
      
      (2341970.0,
       (29.4971507220,   4.6036063557,   -0.7739255080),
       (-0.0005045137,  0.0031194339,  -0.0000526054)),
      
      (2305445.0,
       (-26.5753161424,  14.1902813794, 0.3194802060),
       (-0.0014966429,  -0.0027505717,  0.0000910715)),
      
      (2268920.0,
       (11.1089045478, -28.0532332601, 0.3218555594),
       (0.0028983275,  0.0011726188,  -0.0000908352)),
      
      (2232395.0,
       ( 8.0258639138,  28.7261896414,   -0.7760204278),
       (-0.0030424860,  0.0008636876,  0.0000522034)),
      
      (2195870.0,
       (-24.6233894507, -17.6544160439, 0.9297188987),
       (0.0018093571,  -0.0025335175,  0.0000105589)),
      
      (2159345.0,
       (29.8297729719,  -2.0298541972,   -0.6440952021),
       (0.0001916960,  0.0031491386,  -0.0000692459)),
      
      (2122820.0,
       (-22.7959876638,  19.5945850298, 0.1205430330),
       (-0.0020656054,  -0.0023624426,  0.0000961274))
    ];
    
    for (ejd, (ex,ey,ez), (evx,evy,evz)) in testValues {
      let ((x,y,z), (vx,vy,vz), jd) = neptune.position(jd: ejd)
      XCTAssertEqual(x, ex, accuracy: 0.0000000001);
      XCTAssertEqual(y, ey, accuracy: 0.0000000001);
      XCTAssertEqual(z, ez, accuracy: 0.0000000001);
      XCTAssertEqual(vx,evx, accuracy: 0.0000001);
      XCTAssertEqual(vy,evy, accuracy: 0.0000001)
      XCTAssertEqual(vz,evz, accuracy: 0.0000001);
      XCTAssertEqual(jd,ejd)
      
    }
    
  }
}
