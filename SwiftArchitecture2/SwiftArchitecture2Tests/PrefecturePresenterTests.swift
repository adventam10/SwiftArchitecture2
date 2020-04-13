//
//  PrefecturePresenterTests.swift
//  SwiftArchitecture2Tests
//
//  Created by am10 on 2020/04/13.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import SwiftArchitecture2
@testable import Models

final class PrefecturePresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_makePrefectureListViewData() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        let data = presenter.makePrefectureListViewData()
        XCTAssertEqual(data.isFavoriteFilter, presenter.isCheckFavoriteFilter)
    }

    func test_makePrefectureListTableViewCellData_when_isFavorite_true() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let cityData = CityData(area: 0, cityId: "cityId", name: "name")
        model.prefectureList = [cityData]
        model.favoriteIds = [cityData.cityId]
        let presenter = PrefectureListPresenter(view: view, model: model)
        let data = presenter.makePrefectureListTableViewCellData(forRow: 0)
        XCTAssertTrue(data.isFavorite)
        XCTAssertEqual(data.name, cityData.name)
    }

    func test_makePrefectureListTableViewCellData_when_isFavorite_false() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let cityData = CityData(area: 0, cityId: "cityId", name: "name")
        model.prefectureList = [cityData]
        model.favoriteIds = [""]
        let presenter = PrefectureListPresenter(view: view, model: model)
        let data = presenter.makePrefectureListTableViewCellData(forRow: 0)
        XCTAssertFalse(data.isFavorite)
        XCTAssertEqual(data.name, cityData.name)
    }

    func test_makePrefectureListTableViewCellData_when_out_of_range() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let cityData = CityData(area: 0, cityId: "cityId", name: "name")
        model.prefectureList = [cityData]
        model.favoriteIds = [cityData.cityId]
        let presenter = PrefectureListPresenter(view: view, model: model)
        let data = presenter.makePrefectureListTableViewCellData(forRow: 2)
        XCTAssertFalse(data.isFavorite)
        XCTAssertTrue(data.name.isEmpty)
    }

    func test_viewDidLoad() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "画面表示時の処理") { _ in
            presenter.viewDidLoad()
            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
                XCTAssertEqual(view.callUpdateViewsCount, 1)
            }
        }
    }

    func test_didSelectRow() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        model.prefectureList = [.init(area: 0, cityId: "", name: "")]
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "テーブル選択時の処理") { _ in
            presenter.didSelectRow(at: IndexPath(row: 0, section: 0))
            XCTContext.runActivity(named: "プログレスの表示処理が呼ばれること") { _ in
                XCTAssertEqual(view.callShowProgressCount, 1)
            }
        }
    }

    func test_didSelectRow_when_out_of_range() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "テーブル範囲外選択時の処理") { _ in
            presenter.didSelectRow(at: IndexPath(row: presenter.numberOfTableDataList, section: 0))
            XCTContext.runActivity(named: "プログレスの表示処理が呼ばれないこと") { _ in
                XCTAssertEqual(view.callShowProgressCount, 0)
            }
        }
    }

    func test_didTapAreaFilterAreaButton() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "地域で絞込みボタン押下時の処理") { _ in
            presenter.didTapAreaFilterAreaButton(UIButton())
            XCTContext.runActivity(named: "地域で絞込み画面の表示処理が呼ばれること") { _ in
                XCTAssertEqual(view.callShowAreaFilterViewControllerCount, 1)
            }
        }
    }

    func test_didTapFavoriteFilterButton() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "お気に入りのみ表示ボタン押下時の処理") { _ in
            presenter.didTapFavoriteFilterButton()
            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
                XCTAssertEqual(view.callUpdateViewsCount, 1)
            }
        }
    }

    func test_didChangeSelectedAreaIds() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "地域で絞込み画面で地域選択時処理") { _ in
            presenter.didChangeSelectedAreaIds([])
            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
                XCTAssertEqual(view.callUpdateViewsCount, 1)
            }
        }
    }

    func test_didTapFavoriteButton() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        model.prefectureList = [.init(area: 0, cityId: "", name: "")]
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "お気に入りボタン押下時の処理") { _ in
            presenter.didTapFavoriteButton(at: IndexPath(row: 0, section: 0))
            XCTContext.runActivity(named: "お気に入りの更新処理が呼ばれること") { _ in
                XCTAssertEqual(model.callUpdateFavoriteIdsCount, 1)
            }
            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
                XCTAssertEqual(view.callUpdateViewsCount, 1)
            }
        }
    }

    func test_didTapFavoriteButton_when_out_of_range() {
        let view = PrefectureViewSpy()
        let model = PrefectureModelSpy()
        let presenter = PrefectureListPresenter(view: view, model: model)
        XCTContext.runActivity(named: "お気に入りボタン押下時の処理") { _ in
            presenter.didTapFavoriteButton(at: IndexPath(row: presenter.numberOfTableDataList, section: 0))
            XCTContext.runActivity(named: "お気に入りの更新処理が呼ばれないこと") { _ in
                XCTAssertEqual(model.callUpdateFavoriteIdsCount, 0)
            }
            XCTContext.runActivity(named: "画面の更新処理が呼ばれないこと") { _ in
                XCTAssertEqual(view.callUpdateViewsCount, 0)
            }
        }
    }
}

private final class PrefectureViewSpy: PrefectureListPresenterOutput {
    var callUpdateViewsCount: Int = 0
    var callShowProgressCount: Int = 0
    var callHideProgressCount: Int = 0
    var callShowAlertCount: Int = 0
    var callPerformSegueCount: Int = 0
    var callShowAreaFilterViewControllerCount: Int = 0
    
    func showProgress() {
        callShowProgressCount += 1
    }

    func hideProgress() {
        callHideProgressCount += 1
    }

    func showAlert(message: String) {
        callShowAlertCount += 1
    }

    func performSegue(withIdentifier: String, sender: Any?) {
        callPerformSegueCount += 1
    }

    func showAreaFilterViewController(button: UIButton) {
        callShowAreaFilterViewControllerCount += 1
    }

    func updateViews(with data: PrefectureListViewData) {
        callUpdateViewsCount += 1
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
