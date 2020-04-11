//
//  PrefectureListView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public final class PrefectureListView: XibLoadView {
    public let cellIdentifier = "PrefectureListTableViewCell"
    @IBOutlet public weak var favoriteFilterButton: UIButton!
    @IBOutlet public weak var areaFilterButton: UIButton!
    @IBOutlet public weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
    }
}
