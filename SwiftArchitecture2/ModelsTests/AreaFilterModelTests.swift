//
//  AreaFilterModelTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class AreaFilterModelTests: XCTestCase {

    // 北海道・東北・中部・関東・近畿・中国・四国・九州
    private let allAreaCount = 8

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_areaList() {
        let model = AreaFilterModel(selectedAreaIds: [])
        XCTAssertEqual(model.areaList.count, allAreaCount)
    }
    
    func test_updateAreaIds_add_id() {
        let model = AreaFilterModel(selectedAreaIds: [1, 2])
        model.updateAreaIds(areaId: 3)
        let results = [1, 2, 3]
        XCTAssertTrue(model.selectedAreaIds.allSatisfy { results.contains($0) })
        XCTAssertEqual(model.selectedAreaIds.count, results.count)
    }

    func test_updateAreaIds_add_id_when_empty() {
        let model = AreaFilterModel(selectedAreaIds: [])
        model.updateAreaIds(areaId: 3)
        let results = [3]
        XCTAssertTrue(model.selectedAreaIds.allSatisfy { results.contains($0) })
        XCTAssertEqual(model.selectedAreaIds.count, results.count)
    }

    func test_updateAreaIds_remove_id() {
        let model = AreaFilterModel(selectedAreaIds: [1, 3])
        model.updateAreaIds(areaId: 3)
        let results = [1]
        XCTAssertTrue(model.selectedAreaIds.allSatisfy { results.contains($0) })
        XCTAssertEqual(model.selectedAreaIds.count, results.count)
    }

    func test_updateAreaIdsWithIsAllCheck_true() {
        let model = AreaFilterModel(selectedAreaIds: [1, 3])
        model.updateAreaIds(isAllCheck: true)
        XCTAssertEqual(model.selectedAreaIds.count, allAreaCount)
    }

    func test_updateAreaIdsWithIsAllCheck_true_when_empty() {
        let model = AreaFilterModel(selectedAreaIds: [])
        model.updateAreaIds(isAllCheck: true)
        XCTAssertEqual(model.selectedAreaIds.count, allAreaCount)
    }

    func test_updateAreaIdsWithIsAllCheck_false() {
        let model = AreaFilterModel(selectedAreaIds: [])
        model.updateAreaIds(isAllCheck: false)
        XCTAssertTrue(model.selectedAreaIds.isEmpty)
    }

    func test_updateAreaIdsWithIsAllCheck_false_when_empty() {
        let model = AreaFilterModel(selectedAreaIds: [])
        model.updateAreaIds(isAllCheck: false)
        XCTAssertTrue(model.selectedAreaIds.isEmpty)
    }
}
