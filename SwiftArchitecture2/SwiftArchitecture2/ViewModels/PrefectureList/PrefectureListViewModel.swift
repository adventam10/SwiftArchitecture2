//
//  PrefectureListViewModel.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import Models
import ReactiveSwift

protocol PrefectureListModelInput {
    var prefectureList: [CityData] { get }
    func updateFavoriteIds(cityId: String) -> Result<[String], FavoritePrefectureDataStoreError>
    var favoriteIds: [String] { get }
    func prefectureFiltered(isFilterFavorite: Bool,
                            favoriteIds: [String],
                            selectedAreaIds: Set<Int>) -> [CityData]
}

extension PrefectureListModel: PrefectureListModelInput {
}

final class PrefectureListViewModel {
    private var model: PrefectureListModelInput
    private var mutableIsCheckFavoriteFilter = MutableProperty(false)
    private(set) lazy var isCheckFavoriteFilter = Property(mutableIsCheckFavoriteFilter)
    
    private var mutableTableDataList = MutableProperty([CityData]())
    private(set) lazy var tableDataList = Property(mutableTableDataList)

    private let lifetime: Lifetime
    private let favoriteFilterButtonSubject = Signal<UIButton, Never>.pipe()
    var favoriteFilterButtonButtonAction: BindingTarget<UIButton> {
        return  BindingTarget(lifetime: lifetime) { [weak self] button in
            self?.mutableIsCheckFavoriteFilter.value.toggle()
            self?.filteredTableDataList()
            self?.favoriteFilterButtonSubject.input.send(value: button)
        }
    }

    lazy var favoriteButtonAction = Action<IndexPath, Void, Never> { [weak self] indexPath in
        guard let weakSelf = self,
            let prefecture = weakSelf.prefecture(forRow: indexPath.row) else {
                return .empty
        }
        let result = weakSelf.model.updateFavoriteIds(cityId: prefecture.cityId)
        switch result {
        case .success:
            weakSelf.filteredTableDataList()
        case .failure:
            // アラートを出すほどではない？？
            print("お気に入りの保存に失敗しました")
        }
        return .empty
    }

    lazy var didSelectRowAction = Action<IndexPath, WeatherModelInput, APIError> { [weak self] indexPath in
        guard let weakSelf = self,
            let prefecture = weakSelf.prefecture(forRow: indexPath.row) else {
                return .init(error: .network)
        }
//        view.showProgress()
        let weatherModel = WeatherModel(cityId: prefecture.cityId, apiClient: weakSelf.makeAPIClient())
        return weakSelf.weather(weatherModel: weatherModel)
    }

    private(set) var selectedAreaIds: Set<Int>

    var numberOfTableDataList: Int {
        return tableDataList.value.count
    }

    init(lifetime: Lifetime, model: PrefectureListModelInput = PrefectureListModel(dataStore: FavoritePrefectureDataStoreImpl())) {
        self.model = model
        self.lifetime = lifetime
        self.mutableTableDataList.value = model.prefectureList
        self.selectedAreaIds = Set(Area.allCases.map { $0.id })
    }

    private func weather(weatherModel: WeatherModelInput) -> SignalProducer<WeatherModelInput, APIError> {
        return SignalProducer<WeatherModelInput, APIError> { [weatherModel] (innerObserver, _) in
            weatherModel.requestWeather { result in
                switch result {
                case .success:
                    innerObserver.send(value: weatherModel)
                case .failure(let error):
                    innerObserver.send(error: error)
                }
                innerObserver.sendCompleted()
            }
        }
    }

    func prefecture(forRow row: Int) -> CityData? {
        guard row < tableDataList.value.count else {
            return nil
        }
        return tableDataList.value[row]
    }

    // MARK: - Action
    func didChangeSelectedAreaIds(_ selectedAreaIds: Set<Int>) {
        self.selectedAreaIds = selectedAreaIds
        filteredTableDataList()
    }

    // MARK: - Make View Data
    func makePrefectureListTableViewCellData(forRow row: Int) -> PrefectureListTableViewCellData {
        guard let prefecture = prefecture(forRow: row) else {
            return .init(name: "", isFavorite: false)
        }
        return .init(name: prefecture.name,
                     isFavorite: model.favoriteIds.contains(prefecture.cityId))
    }

    // MARK: -
    func makeAreaFilterViewModel() -> AreaFilterViewModel {
        return .init(model: AreaFilterModel(selectedAreaIds: selectedAreaIds))
    }

    // この処理はもっとどこか共通の場所でやるべきかもしれない
    private func makeAPIClient() -> APIClient {
        #if DUMMY
        return DummyAPIClient.shared
        #else
        return DefaultAPIClient.shared
        #endif
    }

    private func filteredTableDataList() {
        mutableTableDataList.value = model.prefectureFiltered(isFilterFavorite: isCheckFavoriteFilter.value,
                                                              favoriteIds: model.favoriteIds,
                                                              selectedAreaIds: selectedAreaIds)
    }
}
