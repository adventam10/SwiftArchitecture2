//
//  PrefectureListModelTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class PrefectureListModelTests: XCTestCase {

    // 北海道・東北・中部・関東・近畿・中国・四国・九州
    private let allAreaCount = 8
    
    // 47都道府県
    private let allPrefectureCount = 47

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_prefectureList_count() {
        let model = PrefectureListModel(dataStore: FakeDataStore())
        XCTAssertEqual(model.prefectureList.count, allPrefectureCount)
    }

    func test_updateFavoriteIds_add() {
        let dataStore = FakeDataStore()
        dataStore.list = ["1", "2"]
        let model = PrefectureListModel(dataStore: dataStore)
        let result = model.updateFavoriteIds(cityId: "3")
        let expectedValue = ["1", "2", "3"]
        switch result {
        case .success(let favoriteIds):
            XCTAssertEqual(favoriteIds.count, expectedValue.count)
            XCTAssertTrue(favoriteIds.allSatisfy { expectedValue.contains($0) })
        default:
            XCTFail("データの保存に失敗しました")
        }
    }

    func test_updateFavoriteIds_add_when_empty() {
        let dataStore = FakeDataStore()
        dataStore.list = []
        let model = PrefectureListModel(dataStore: dataStore)
        let result = model.updateFavoriteIds(cityId: "3")
        let expectedValue = ["3"]
        switch result {
        case .success(let favoriteIds):
            XCTAssertEqual(favoriteIds.count, expectedValue.count)
            XCTAssertTrue(favoriteIds.allSatisfy { expectedValue.contains($0) })
        default:
            XCTFail("データの保存に失敗しました")
        }
    }

    func test_updateFavoriteIds_remove() {
        let dataStore = FakeDataStore()
        dataStore.list = ["1", "2"]
        let model = PrefectureListModel(dataStore: dataStore)
        let result = model.updateFavoriteIds(cityId: "2")
        let expectedValue = ["1"]
        switch result {
        case .success(let favoriteIds):
            XCTAssertEqual(favoriteIds.count, expectedValue.count)
            XCTAssertTrue(favoriteIds.allSatisfy { expectedValue.contains($0) })
        default:
            XCTFail("データの保存に失敗しました")
        }
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_empty_selectedAreaIds_empty() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: [],
                                               selectedAreaIds: [])
        XCTAssertTrue(results.isEmpty)
    }

    func test_prefectureFiltered_where_isFilterFavorite_false_favoriteIds_empty_selectedAreaIds_empty() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: false,
                                               favoriteIds: [],
                                               selectedAreaIds: [])
        XCTAssertTrue(results.isEmpty)
    }
    
    func test_prefectureFiltered_where_isFilterFavorite_false_favoriteIds_all_selectedAreaIds_empty() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: false,
                                               favoriteIds: makeAllCityIds(),
                                               selectedAreaIds: [])
        XCTAssertTrue(results.isEmpty)
    }
    
    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_all_selectedAreaIds_empty() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: makeAllCityIds(),
                                               selectedAreaIds: [])
        XCTAssertTrue(results.isEmpty)
    }

    func test_prefectureFiltered_where_isFilterFavorite_false_favoriteIds_empty_selectedAreaIds_all() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: false,
                                               favoriteIds: [],
                                               selectedAreaIds: makeAllAreaIds())
        XCTAssertEqual(results.count, allPrefectureCount)
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_empty_selectedAreaIds_all() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: [],
                                               selectedAreaIds: makeAllAreaIds())
        XCTAssertTrue(results.isEmpty)
    }

    func test_prefectureFiltered_where_isFilterFavorite_false_favoriteIds_all_selectedAreaIds_all() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: false,
                                               favoriteIds: makeAllCityIds(),
                                               selectedAreaIds: makeAllAreaIds())
        XCTAssertEqual(results.count, allPrefectureCount)
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_all_selectedAreaIds_all() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: makeAllCityIds(),
                                               selectedAreaIds: makeAllAreaIds())
        XCTAssertEqual(results.count, allPrefectureCount)
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_hokkaido() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.hokkaido.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.hokkaido.rawValue})
    }

     // 北海道・東北・中部・関東・近畿・中国・四国・九州
    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_tohoku() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.tohoku.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.aomori.rawValue})
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_chubu() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.chubu.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.gifu.rawValue})
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_kanto() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.kanto.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.tokyo.rawValue})
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_kinki() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.kinki.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.osaka.rawValue})
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_chugoku() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.chugoku.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.tottori.rawValue})
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_shikoku() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.shikoku.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.kagawa.rawValue})
    }

    func test_prefectureFiltered_where_isFilterFavorite_true_favoriteIds_selectedAreaIds_kyushu() {
        let dataStore = FakeDataStore()
        let model = PrefectureListModel(dataStore: dataStore)
        let results = model.prefectureFiltered(isFilterFavorite: true,
                                               favoriteIds: City.allCases.map { $0.rawValue },
                                               selectedAreaIds: [Area.kyushu.id])
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(results.contains { $0.cityId == City.fukuoka.rawValue})
    }
}

extension PrefectureListModelTests {
    // 各地方1つずつ抽出
    enum City: String, CaseIterable {
        case hokkaido = "016010"
        case aomori = "020010"
        case tokyo = "130010"
        case gifu = "210010"
        case osaka = "270000"
        case tottori = "310010"
        case kagawa = "370000"
        case fukuoka = "400010"
    }

    func makeAllAreaIds() -> Set<Int> {
        return Set(Area.allCases.map { $0.id })
    }

    func makeAllCityIds() -> [String] {
        let prefectureList = loadCityDataList()
        return prefectureList.map { $0.cityId }
    }
    
    func loadCityDataList() -> [CityData] {
        let bundle = Bundle(for: PrefectureListModel.self)
        guard let url = bundle.url(forResource: "CityData", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let result = try? JSONDecoder().decode([CityData].self, from: data) else {
                return []
        }
        return result
    }
}

private class FakeDataStore: FavoritePrefectureDataStore {
    var list = [Object]()
    func fetchAll() -> [Object] {
        return list
    }
    
    func add(_ objects: [Object]) -> Result<[Object], FavoritePrefectureDataStoreError> {
        list.append(contentsOf: objects)
        return .success(list)
    }
    
    func remove(_ objects: [Object]) -> Result<[Object], FavoritePrefectureDataStoreError> {
        list.removeAll { objects.contains($0) }
        return .success(list)
    }
}

