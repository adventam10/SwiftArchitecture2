//
//  AreaFilterPresenterTests.swift
//  SwiftArchitecture2Tests
//
//  Created by am10 on 2020/04/13.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import SwiftArchitecture2
@testable import Models

//final class AreaFilterPresenterTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func test_makeAreaFilterViewData_when_selectedAreaIds_contains_all_areas() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        model.selectedAreaIds = Set(model.areaList.map { $0.id })
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        let data = presenter.makeAreaFilterViewData()
//        XCTAssertTrue(data.isAllCheck)
//    }
//
//    func test_makeAreaFilterViewData_when_selectedAreaIds_empty() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        model.selectedAreaIds = []
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        let data = presenter.makeAreaFilterViewData()
//        XCTAssertFalse(data.isAllCheck)
//    }
//
//    func test_makeAreaFilterViewData_when_selectedAreaIds_not_empty() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        model.selectedAreaIds = [model.areaList[0].id]
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        let data = presenter.makeAreaFilterViewData()
//        XCTAssertFalse(data.isAllCheck)
//    }
//
//    func test_makeAreaFilterTableViewCellData_when_isCheck_true() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        model.selectedAreaIds = [model.areaList[0].id]
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        let index = 0
//        let data = presenter.makeAreaFilterTableViewCellData(forRow: index)
//        XCTAssertTrue(data.isCheck)
//        XCTAssertEqual(data.name, model.areaList[index].name)
//    }
//
//    func test_makeAreaFilterTableViewCellData_when_isCheck_false() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        model.selectedAreaIds = []
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        let index = 0
//        let data = presenter.makeAreaFilterTableViewCellData(forRow: index)
//        XCTAssertFalse(data.isCheck)
//        XCTAssertEqual(data.name, model.areaList[index].name)
//    }
//
//    func test_makeAreaFilterTableViewCellData_when_out_of_range() {
//       let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        model.selectedAreaIds = []
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        let data = presenter.makeAreaFilterTableViewCellData(forRow: model.areaList.count)
//        XCTAssertFalse(data.isCheck)
//        XCTAssertTrue(data.name.isEmpty)
//    }
//
//    func test_viewDidLoad() {
//       let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "画面表示時の処理") { _ in
//            presenter.viewDidLoad()
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 1)
//            }
//        }
//    }
//
//    func test_didSelectRow() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "テーブル選択時の処理") { _ in
//            presenter.didSelectRow(at: IndexPath(row: 0, section: 0))
//            XCTContext.runActivity(named: "選択地域一覧の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(model.callUpdateAreaIdsWithAreaIdCount, 1)
//            }
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 1)
//            }
//        }
//    }
//
//    func test_didSelectRow_when_out_of_range() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "テーブル範囲外選択時の処理") { _ in
//            presenter.didSelectRow(at: IndexPath(row: presenter.numberOfTableDataList, section: 0))
//            XCTContext.runActivity(named: "選択地域一覧の更新処理が呼ばれないこと") { _ in
//                XCTAssertEqual(model.callUpdateAreaIdsWithAreaIdCount, 0)
//            }
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれないこと") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 0)
//            }
//        }
//    }
//    
//    func test_didTapAllCheckButton() {
//        let view = AreaFilterViewSpy()
//        let model = AreaFilterModelSpy()
//        let presenter = AreaFilterPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "すべて選択押下時の処理") { _ in
//            presenter.didTapAllCheckButton()
//            XCTContext.runActivity(named: "選択地域一覧の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(model.callUpdateAreaIdsWithAllCheckCount, 1)
//            }
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 1)
//            }
//        }
//    }
//}
//
//private final class AreaFilterViewSpy: AreaFilterPresenterOutput {
//    var callUpdateViewsCount: Int = 0
//    var callDidChangeSelectedAreaIdsCount: Int = 0
//
//    func didChangeSelectedAreaIds(_ selectedAreaIds: Set<Int>) {
//        callDidChangeSelectedAreaIdsCount += 1
//    }
//
//    func updateViews(with data: AreaFilterViewData) {
//        callUpdateViewsCount += 1
//    }
//}
//
//private final class AreaFilterModelSpy: AreaFilterModelInput {
//    var selectedAreaIds: Set<Int> = []
//    var areaList: [Area] = Area.allCases
//
//    var callUpdateAreaIdsWithAreaIdCount: Int = 0
//    var callUpdateAreaIdsWithAllCheckCount: Int = 0
//    
//    func updateAreaIds(areaId: Int, completion: @escaping ((Set<Int>) -> Void)) {
//        callUpdateAreaIdsWithAreaIdCount += 1
//        completion(selectedAreaIds)
//    }
//
//    func updateAreaIds(isAllCheck: Bool, completion: @escaping ((Set<Int>) -> Void)) {
//        callUpdateAreaIdsWithAllCheckCount += 1
//        completion(selectedAreaIds)
//    }
//}
