//
//  PrefectureListPresenter.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import Models

protocol PrefectureListModelInput {
    var prefectureList: [CityData] { get }
    func updateFavoriteIds(cityId: String) -> Result<[String], FavoritePrefectureDataStoreError>
    var favoriteIds: [String] { get }
    func prefectureFiltered(isFilterFavorite: Bool,
                            favoriteIds: [String],
                            selectedAreaIds: Set<Int>) -> [CityData]
}

protocol PrefectureListPresenterOutput: AnyObject {
    func showProgress()
    func hideProgress()
    func showAlert(message: String)
    func performSegue(withIdentifier: String, sender: Any?)
    func showAreaFilterViewController(button: UIButton)
    func updateViews(with data: PrefectureListViewData)
}

extension PrefectureListModel: PrefectureListModelInput {
}

final class PrefectureListPresenter {
    private weak var view: PrefectureListPresenterOutput!
    private var model: PrefectureListModelInput

    private var tableDataList: [CityData] = [] {
        didSet {
            view.updateViews(with: makePrefectureListViewData())
        }
    }
    private(set) var isCheckFavoriteFilter = false
    private(set) var selectedAreaIds: Set<Int> = []

    var numberOfTableDataList: Int {
        return tableDataList.count
    }

    init(view: PrefectureListPresenterOutput, model: PrefectureListModelInput = PrefectureListModel(dataStore: FavoritePrefectureDataStoreImpl())) {
        self.view = view
        self.model = model
        tableDataList = model.prefectureList
        selectedAreaIds = Set(Area.allCases.map { $0.id })
    }

    func prefecture(forRow row: Int) -> CityData? {
        guard row < tableDataList.count else {
            return nil
        }
        return tableDataList[row]
    }

    // MARK: - Action
    func viewDidLoad() {
        filteredTableDataList()
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let prefecture = prefecture(forRow: indexPath.row) else {
            return
        }
        view.showProgress()
        let weatherModel = WeatherModel(cityId: prefecture.cityId, apiClient: makeAPIClient())
        weatherModel.requestWeather { [weak self, weatherModel] result in
            self?.view.hideProgress()
            switch result {
            case .success:
                self?.view.performSegue(withIdentifier: "showWeather", sender: weatherModel)
            case .failure(let error):
                self?.view.showAlert(message: error.localizedDescription)
            }
        }
    }

    func didTapAreaFilterAreaButton(_ sender: Any) {
        view.showAreaFilterViewController(button: sender as! UIButton)
    }

    func didTapFavoriteFilterButton() {
        isCheckFavoriteFilter.toggle()
        filteredTableDataList()
    }

    func didTapFavoriteButton(at indexPath: IndexPath) {
        guard let prefecture = prefecture(forRow: indexPath.row) else {
            return
        }
        let result = model.updateFavoriteIds(cityId: prefecture.cityId)
        switch result {
        case .success:
            filteredTableDataList()
        case .failure:
            // アラートを出すほどではない？？
            print("お気に入りの保存に失敗しました")
            return
        }
    }

    func didChangeSelectedAreaIds(_ selectedAreaIds: Set<Int>) {
        self.selectedAreaIds = selectedAreaIds
        filteredTableDataList()
    }

    // MARK: - Make View Data
    func makePrefectureListViewData() -> PrefectureListViewData {
        return .init(isFavoriteFilter: isCheckFavoriteFilter)
    }

    func makePrefectureListTableViewCellData(forRow row: Int) -> PrefectureListTableViewCellData {
        guard let prefecture = prefecture(forRow: row) else {
            return .init(name: "", isFavorite: false)
        }
        return .init(name: prefecture.name,
                     isFavorite: model.favoriteIds.contains(prefecture.cityId))
    }

    // MARK: -
    // この処理はもっとどこか共通の場所でやるべきかもしれない
    private func makeAPIClient() -> APIClient {
        #if DUMMY
        return DummyAPIClient.shared
        #else
        return DefaultAPIClient.shared
        #endif
    }

    private func filteredTableDataList() {
        tableDataList = model.prefectureFiltered(isFilterFavorite: isCheckFavoriteFilter,
                                                 favoriteIds: model.favoriteIds,
                                                 selectedAreaIds: selectedAreaIds)
    }
}
