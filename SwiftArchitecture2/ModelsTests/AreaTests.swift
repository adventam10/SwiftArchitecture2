//
//  AreaTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class AreaTests: XCTestCase {

    // 北海道・東北・中部・関東・近畿・中国・四国・九州
    private let allAreaCount = 8

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_areaCount() {
        XCTAssertEqual(Area.allCases.count, allAreaCount)
    }

    func test_id_hokkaido() {
        XCTAssertEqual(Area.hokkaido.id, 0)
    }

    func test_id_tohoku() {
        XCTAssertEqual(Area.tohoku.id, 1)
    }

    func test_id_kanto() {
        XCTAssertEqual(Area.kanto.id, 2)
    }

    func test_id_chubu() {
        XCTAssertEqual(Area.chubu.id, 3)
    }

    func test_id_kinki() {
        XCTAssertEqual(Area.kinki.id, 4)
    }

    func test_id_chugoku() {
        XCTAssertEqual(Area.chugoku.id, 5)
    }

    func test_id_shikoku() {
        XCTAssertEqual(Area.shikoku.id, 6)
    }

    func test_id_kyushu() {
        XCTAssertEqual(Area.kyushu.id, 7)
    }

    func test_name_hokkaido() {
        XCTAssertEqual(Area.hokkaido.name, "北海道")
    }

    func test_name_tohoku() {
        XCTAssertEqual(Area.tohoku.name, "東北")
    }

    func test_name_kanto() {
        XCTAssertEqual(Area.kanto.name, "関東")
    }

    func test_name_chubu() {
        XCTAssertEqual(Area.chubu.name, "中部")
    }

    func test_name_kinki() {
        XCTAssertEqual(Area.kinki.name, "近畿")
    }

    func test_name_chugoku() {
        XCTAssertEqual(Area.chugoku.name, "中国")
    }

    func test_name_shikoku() {
        XCTAssertEqual(Area.shikoku.name, "四国")
    }

    func test_name_kyushu() {
        XCTAssertEqual(Area.kyushu.name, "九州")
    }
}

