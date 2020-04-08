//
//  AreaFilterModel.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class AreaFilterModel {

    public let notificationCenter = NotificationCenter.default
    public let areaList = Area.allCases
    public private(set) var selectedAreaIds: Set<Int> {
        didSet {
            notificationCenter.post(name: .init(rawValue: "selectedAreaIds"),
            object: nil,
            userInfo: ["selectedAreaIds": selectedAreaIds])
        }
    }

    public init(selectedAreaIds: Set<Int>) {
        self.selectedAreaIds = selectedAreaIds
    }

    public func updateAreaIds(id: Int) {
        if selectedAreaIds.contains(id) {
            selectedAreaIds.remove(id)
        } else {
            selectedAreaIds.insert(id)
        }
    }

    public func updateAreaIds(isAllCheck: Bool) {
        if isAllCheck {
            selectedAreaIds = Set(areaList.map { $0.id })
        } else {
            selectedAreaIds.removeAll()
        }
    }
}
