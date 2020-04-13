//
//  AreaFilterPresenter.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import Models

final class AreaFilterPresenter {
    private var model: AreaFilterModel
    private weak var view: AreaFilterViewController!

    var isAllCheck: Bool {
        return tableDataList.allSatisfy { model.selectedAreaIds.contains($0.id) }
    }

    private var tableDataList: [Area] = []
    var numberOfTableDataList: Int {
        return tableDataList.count
    }

    init(view: AreaFilterViewController, model: AreaFilterModel) {
        self.view = view
        self.model = model
        tableDataList = model.areaList
    }

    func area(forRow row: Int) -> Area? {
        guard row < tableDataList.count else {
            return nil
        }
        return tableDataList[row]
    }

    // MARK: - Action
    func viewDidLoad() {
        view.updateViews(with: makeAreaFilterViewData())
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard let area = area(forRow: indexPath.row) else {
            return
        }
        model.updateAreaIds(areaId: area.id) { [weak self] selectedAreaIds in
            guard let weakSelf = self else {
                return
            }
            weakSelf.view.updateViews(with: weakSelf.makeAreaFilterViewData())
            weakSelf.view.delegate?.areaFilterViewController(weakSelf.view, didChangeSelectedAreaIds: selectedAreaIds)
        }
    }

    func didTapAllCheckButton() {
        model.updateAreaIds(isAllCheck: !isAllCheck) { [weak self] selectedAreaIds in
            guard let weakSelf = self else {
                return
            }
            weakSelf.view.updateViews(with: weakSelf.makeAreaFilterViewData())
            weakSelf.view.delegate?.areaFilterViewController(weakSelf.view, didChangeSelectedAreaIds: selectedAreaIds)
        }
    }

    // MARK: - Make View Data
    func makeAreaFilterViewData() -> AreaFilterViewData {
        return .init(isAllCheck: isAllCheck)
    }

    func makeAreaFilterTableViewCellData(forRow row: Int) -> AreaFilterTableViewCellData {
        guard let area = area(forRow: row) else {
            return .init(name: "", isCheck: false)
        }
        return .init(name: area.name, isCheck: model.selectedAreaIds.contains(area.id))
    }
}
