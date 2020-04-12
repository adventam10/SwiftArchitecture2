//
//  AreaFilterView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public final class AreaFilterView: XibLoadView {
    public let cellIdentifier = "AreaFilterTableViewCell"
    @IBOutlet public weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
    }
    @IBOutlet public weak var allCheckButton: UIButton!
}
