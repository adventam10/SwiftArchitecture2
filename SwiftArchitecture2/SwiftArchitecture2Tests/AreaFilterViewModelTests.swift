//
//  AreaFilterViewModelTests.swift
//  SwiftArchitecture2Tests
//
//  Created by am10 on 2020/04/13.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import SwiftArchitecture2
@testable import Models

final class AreaFilterViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_makeAreaFilterTableViewCellData_when_isCheck_true() {
        let model = AreaFilterModelSpy()
        model.selectedAreaIds = [model.areaList[0].id]
        let viewModel = AreaFilterViewModel(lifetime: .empty, model: model)
        let index = 0
        let data = viewModel.makeAreaFilterTableViewCellData(forRow: index)
        XCTAssertTrue(data.isCheck)
        XCTAssertEqual(data.name, model.areaList[index].name)
    }

    func test_makeAreaFilterTableViewCellData_when_isCheck_false() {
        let model = AreaFilterModelSpy()
        model.selectedAreaIds = []
        let viewModel = AreaFilterViewModel(lifetime: .empty, model: model)
        let index = 0
        let data = viewModel.makeAreaFilterTableViewCellData(forRow: index)
        XCTAssertFalse(data.isCheck)
        XCTAssertEqual(data.name, model.areaList[index].name)
    }

    func test_makeAreaFilterTableViewCellData_when_out_of_range() {
        let model = AreaFilterModelSpy()
        model.selectedAreaIds = []
        let viewModel = AreaFilterViewModel(lifetime: .empty, model: model)
        let data = viewModel.makeAreaFilterTableViewCellData(forRow: model.areaList.count)
        XCTAssertFalse(data.isCheck)
        XCTAssertTrue(data.name.isEmpty)
    }

   func test_didSelectRow() {
        let model = AreaFilterModelSpy()
        let viewModel = AreaFilterViewModel(lifetime: .empty, model: model)
        XCTContext.runActivity(named: "テーブル選択時の処理") { _ in
            viewModel.didSelectRowAction.completed.observeValues { _ in
                XCTContext.runActivity(named: "選択地域一覧の更新処理が呼ばれること") { _ in
                    XCTAssertEqual(model.callUpdateAreaIdsWithAreaIdCount, 1)
                }
            }
            viewModel.didSelectRowAction.apply(IndexPath(row: 0, section: 0)).start()
        }
    }

    func test_didSelectRow_when_out_of_range() {
        let model = AreaFilterModelSpy()
        let viewModel = AreaFilterViewModel(lifetime: .empty, model: model)
        XCTContext.runActivity(named: "テーブル範囲外選択時の処理") { _ in
            viewModel.didSelectRowAction.completed.observeValues { _ in
                XCTContext.runActivity(named: "選択地域一覧の更新処理が呼ばれないこと") { _ in
                    XCTAssertEqual(model.callUpdateAreaIdsWithAreaIdCount, 0)
                }
            }
            viewModel.didSelectRowAction.apply(IndexPath(row: viewModel.numberOfTableDataList, section: 0)).start()
        }
    }
}

private final class AreaFilterModelSpy: AreaFilterModelInput {
    var selectedAreaIds: Set<Int> = []
    var areaList: [Area] = Area.allCases

    var callUpdateAreaIdsWithAreaIdCount: Int = 0
    var callUpdateAreaIdsWithAllCheckCount: Int = 0
    
    func updateAreaIds(areaId: Int, completion: @escaping ((Set<Int>) -> Void)) {
        callUpdateAreaIdsWithAreaIdCount += 1
        completion(selectedAreaIds)
    }

    func updateAreaIds(isAllCheck: Bool, completion: @escaping ((Set<Int>) -> Void)) {
        callUpdateAreaIdsWithAllCheckCount += 1
        completion(selectedAreaIds)
    }
}
