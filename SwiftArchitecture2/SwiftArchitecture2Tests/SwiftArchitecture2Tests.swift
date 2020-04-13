//
//  SwiftArchitecture2Tests.swift
//  SwiftArchitecture2Tests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import SwiftArchitecture2

class SwiftArchitecture2Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    struct Seat {
        let number: Int
        let alphabet: String
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let s1 = Seat(number: 11, alphabet: "C")
        let s2 = Seat(number: 10, alphabet: "E")
        let s3 = Seat(number: 10, alphabet: "A")
        let s4 = Seat(number: 11, alphabet: "B")
        let s5 = Seat(number: 11, alphabet: "A")
        let seats = [s1, s2, s3, s4, s5]
    
        let results = seats.sorted {
            if $0.number != $1.number {
                return $0.number < $1.number
            }
            return $0.alphabet < $1.alphabet
        }

        print("!!!!!!!!!!")
        print(results)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
