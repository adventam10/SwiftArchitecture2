//
//  AreaFilterViewModel.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import Models
import ReactiveCocoa
import ReactiveSwift

protocol AreaFilterModelInput {
    var selectedAreaIds: Set<Int> { get }
    var areaList: [Area] { get }
    func updateAreaIds(areaId: Int, completion: @escaping ((Set<Int>) -> Void))
    func updateAreaIds(isAllCheck: Bool, completion: @escaping ((Set<Int>) -> Void))
}

extension AreaFilterModel: AreaFilterModelInput {
}

final class AreaFilterViewModel {
    private var model: AreaFilterModelInput

    private var mutableSelectedAreaIds = MutableProperty(Set<Int>())
    private(set) lazy var selectedAreaIds = Property(mutableSelectedAreaIds)
    private var mutableIsAllCheck = MutableProperty(true)
    private(set) lazy var isAllCheck = Property(mutableIsAllCheck)
    private let lifetime: Lifetime
    private let allCheckButtonSubject = Signal<UIButton, Never>.pipe()
    var allCheckButtonAction: BindingTarget<UIButton> {
        return BindingTarget(lifetime: lifetime) { [weak self] button in
            guard let weakSelf = self else {
                return
            }
            weakSelf.model.updateAreaIds(isAllCheck: !weakSelf.isAllCheck.value) { selectedAreaIds in
                weakSelf.mutableSelectedAreaIds.value = selectedAreaIds
            }
            weakSelf.allCheckButtonSubject.input.send(value: button)
        }
    }
    lazy var didSelectRowAction = Action<IndexPath, Void, Never> { [weak self] indexPath in
        guard let weakSelf = self,
            let area = weakSelf.area(forRow: indexPath.row) else {
                return .empty
        }
        return weakSelf.updateAreaIds(areaId: area.id)
    }

    private var tableDataList: [Area] = []

    var numberOfTableDataList: Int {
        return tableDataList.count
    }

    init(lifetime: Lifetime, model: AreaFilterModelInput) {
        self.model = model
        self.lifetime = lifetime
        self.tableDataList = model.areaList
        self.mutableSelectedAreaIds.value = model.selectedAreaIds
        self.mutableIsAllCheck <~ selectedAreaIds.map { [weak self] value in
            self?.tableDataList.allSatisfy { value.contains($0.id) } ?? false
        }
    }

    func area(forRow row: Int) -> Area? {
        guard row < tableDataList.count else {
            return nil
        }
        return tableDataList[row]
    }

    private func updateAreaIds(areaId: Int) -> SignalProducer<Void, Never> {
        return SignalProducer<Void, Never> { [weak self] (innerObserver, _) in
            self?.model.updateAreaIds(areaId: areaId) { selectedAreaIds in
                self?.mutableSelectedAreaIds.value = selectedAreaIds
                innerObserver.send(value: ())
                innerObserver.sendCompleted()
            }
        }
    }

    // MARK: - Make View Data
    func makeAreaFilterTableViewCellData(forRow row: Int) -> AreaFilterTableViewCellData {
        guard let area = area(forRow: row) else {
            return .init(name: "", isCheck: false)
        }
        return .init(name: area.name, isCheck: model.selectedAreaIds.contains(area.id))
    }
}
