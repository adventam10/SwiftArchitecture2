//
//  FavoritePrefectureDataStore.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public protocol FavoritePrefectureDataStore {
    typealias Object = String
    func fetchAll() -> [Object]
    func add(_ objects: [Object]) -> Result<[Object], FavoritePrefectureDataStoreError>
    func remove(_ objects: [Object]) -> Result<[Object], FavoritePrefectureDataStoreError>
}

public enum FavoritePrefectureDataStoreError: Error {
    case unknown
}

public struct FavoritePrefectureDataStoreImpl: FavoritePrefectureDataStore {
    enum Key: String {
        case favoriteIds = "FAVORITE_PREFECTURE_CITY_IDS"
    }

    private let userDefaults = UserDefaults.standard

    public init() {
    }

    public func fetchAll() -> [Object] {
        return userDefaults.array(forKey: Key.favoriteIds.rawValue) as? [Object] ?? []
    }

    public func add(_ objects: [Object]) -> Result<[Object], FavoritePrefectureDataStoreError> {
        var list = fetchAll()
        list.append(contentsOf: objects)
        userDefaults.set(list, forKey: Key.favoriteIds.rawValue)
        if userDefaults.synchronize() {
            return .success(list)
        }
        return .failure(.unknown)
    }

    public func remove(_ objects: [Object]) -> Result<[Object], FavoritePrefectureDataStoreError> {
        var list = fetchAll()
        list.removeAll { objects.contains($0) }
        userDefaults.set(list, forKey: Key.favoriteIds.rawValue)
        if userDefaults.synchronize() {
            return .success(list)
        }
        return .failure(.unknown)
    }
}
