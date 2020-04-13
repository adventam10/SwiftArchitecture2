//
//  AreaFilterView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class AreaFilterView: XibLoadView {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.areaFilterTableViewCell)
        }
    }
    @IBOutlet weak var allCheckButton: UIButton!

    func updateViews(with data: AreaFilterViewData) {
        allCheckButton.isSelected = data.isAllCheck
    }
}
