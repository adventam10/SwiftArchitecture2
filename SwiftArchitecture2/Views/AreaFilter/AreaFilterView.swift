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
    @IBOutlet weak public var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
    }
    @IBOutlet weak public var allCheckButton: UIButton!
}
