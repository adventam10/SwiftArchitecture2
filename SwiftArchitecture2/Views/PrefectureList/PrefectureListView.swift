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
    @IBOutlet weak public var favoriteFilterButton: UIButton!
    @IBOutlet weak public var areaFilterButton: UIButton!
    @IBOutlet weak public var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
    }
}
