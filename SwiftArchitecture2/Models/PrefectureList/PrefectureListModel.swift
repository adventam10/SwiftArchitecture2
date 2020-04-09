//
//  PrefectureListModel.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class PrefectureListModel {

    public let prefectureList: [CityData]
    public let dataStore: FavoritePrefectureDataStore
    public private(set) var favoriteIds: [String]

    public init(dataStore: FavoritePrefectureDataStore) {
        self.prefectureList = Self.loadCityDataList()
        self.dataStore = dataStore
        self.favoriteIds = dataStore.fetchAll()
    }

    private static func loadCityDataList() -> [CityData] {
        let bundle = Bundle(for: PrefectureListModel.self)
        guard let url = bundle.url(forResource: "CityData", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let result = try? JSONDecoder().decode([CityData].self, from: data) else {
                return []
        }
        return result
    }

    public func prefectureFiltered(isFilterFavorite: Bool,
                                   favoriteIds: [String],
                                   selectedAreaIds: Set<Int>) -> [CityData] {
        return prefectureList.filter {
            if isFilterFavorite {
                return selectedAreaIds.contains($0.area) && favoriteIds.contains($0.cityId)
            } else {
                return selectedAreaIds.contains($0.area)
            }
        }
    }

    public func updateFavoriteIds(id: String) -> Result<[String], FavoritePrefectureDataStoreError> {
        let result: Result<[String], FavoritePrefectureDataStoreError>
        if favoriteIds.contains(id) {
            result = dataStore.remove([id])
        } else {
            result = dataStore.add([id])
        }
        if case let .success(ids) = result {
            favoriteIds = ids
        }
        return result
    }
}
