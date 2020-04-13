//
//  AreaFilterModel.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class AreaFilterModel {
    public let areaList = Area.allCases
    public private(set) var selectedAreaIds: Set<Int>

    public init(selectedAreaIds: Set<Int>) {
        self.selectedAreaIds = selectedAreaIds
    }

    public func updateAreaIds(areaId: Int,
                              completion: @escaping ((Set<Int>) -> Void) = { _ in }) {
        if selectedAreaIds.contains(areaId) {
            selectedAreaIds.remove(areaId)
        } else {
            selectedAreaIds.insert(areaId)
        }
        completion(selectedAreaIds)
    }

    public func updateAreaIds(isAllCheck: Bool,
                              completion: @escaping ((Set<Int>) -> Void) = { _ in }) {
        if isAllCheck {
            selectedAreaIds = Set(areaList.map { $0.id })
        } else {
            selectedAreaIds.removeAll()
        }
        completion(selectedAreaIds)
    }
}
