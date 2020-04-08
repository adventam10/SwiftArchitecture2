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
    public init(dataStore: FavoritePrefectureDataStore) {
        self.prefectureList = Self.loadCityDataList()
        self.dataStore = dataStore
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
}
