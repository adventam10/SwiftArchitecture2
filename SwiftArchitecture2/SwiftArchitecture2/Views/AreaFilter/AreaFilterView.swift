//
//  AreaFilterView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class AreaFilterView: XibLoadView {
    let cellIdentifier = "AreaFilterTableViewCell"
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
    }
    @IBOutlet weak var allCheckButton: UIButton!

    func updateViews(with data: AreaFilterViewData) {
        allCheckButton.isSelected = data.isAllCheck
    }
}
