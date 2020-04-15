//
//  PrefectureViewModelTests.swift
//  SwiftArchitecture2Tests
//
//  Created by am10 on 2020/04/13.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import SwiftArchitecture2
@testable import Models

final class PrefectureViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_makePrefectureListTableViewCellData_when_isFavorite_true() {
        let model = PrefectureModelSpy()
        let cityData = CityData(area: 0, cityId: "cityId", name: "name")
        model.prefectureList = [cityData]
        model.favoriteIds = [cityData.cityId]
        let viewModel = PrefectureListViewModel(lifetime: .empty, model: model)
        let data = viewModel.makePrefectureListTableViewCellData(forRow: 0)
        XCTAssertTrue(data.isFavorite)
        XCTAssertEqual(data.name, cityData.name)
    }

    func test_makePrefectureListTableViewCellData_when_isFavorite_false() {
        let model = PrefectureModelSpy()
        let cityData = CityData(area: 0, cityId: "cityId", name: "name")
        model.prefectureList = [cityData]
        model.favoriteIds = [""]
        let viewModel = PrefectureListViewModel(lifetime: .empty, model: model)
        let data = viewModel.makePrefectureListTableViewCellData(forRow: 0)
        XCTAssertFalse(data.isFavorite)
        XCTAssertEqual(data.name, cityData.name)
    }

    func test_makePrefectureListTableViewCellData_when_out_of_range() {
        let model = PrefectureModelSpy()
        let cityData = CityData(area: 0, cityId: "cityId", name: "name")
        model.prefectureList = [cityData]
        model.favoriteIds = [cityData.cityId]
        let viewModel = PrefectureListViewModel(lifetime: .empty, model: model)
        let data = viewModel.makePrefectureListTableViewCellData(forRow: 2)
        XCTAssertFalse(data.isFavorite)
        XCTAssertTrue(data.name.isEmpty)
    }

    func test_didTapFavoriteButton() {
        let model = PrefectureModelSpy()
        model.prefectureList = [.init(area: 0, cityId: "", name: "")]
        let viewModel = PrefectureListViewModel(lifetime: .empty, model: model)
        XCTContext.runActivity(named: "お気に入りボタン押下時の処理") { _ in
            viewModel.favoriteButtonAction.completed.observeValues { _ in
                XCTContext.runActivity(named: "お気に入りの更新処理が呼ばれること") { _ in
                    XCTAssertEqual(model.callUpdateFavoriteIdsCount, 1)
                }
            }
            viewModel.favoriteButtonAction.apply(IndexPath(row: 0, section: 0)).start()
        }
    }

    func test_didTapFavoriteButton_when_out_of_range() {
        let model = PrefectureModelSpy()
        let viewModel = PrefectureListViewModel(lifetime: .empty, model: model)
        XCTContext.runActivity(named: "お気に入りボタン押下時の処理") { _ in
            viewModel.favoriteButtonAction.completed.observeValues { _ in
                XCTContext.runActivity(named: "お気に入りの更新処理が呼ばれないこと") { _ in
                    XCTAssertEqual(model.callUpdateFavoriteIdsCount, 0)
                }
            }
            viewModel.favoriteButtonAction.apply(IndexPath(row: viewModel.numberOfTableDataList, section: 0)).start()
        }
    }
}

private final class PrefectureModelSpy: PrefectureListModelInput {
    var prefectureList: [CityData] = []
    var favoriteIds: [String] = []

    var callUpdateFavoriteIdsCount: Int = 0

    func updateFavoriteIds(cityId: String) -> Result<[String], FavoritePrefectureDataStoreError> {
        callUpdateFavoriteIdsCount += 1
        return .success([])
    }

    func prefectureFiltered(isFilterFavorite: Bool,
                            favoriteIds: [String],
                            selectedAreaIds: Set<Int>) -> [CityData] {
        return []
    }
}
