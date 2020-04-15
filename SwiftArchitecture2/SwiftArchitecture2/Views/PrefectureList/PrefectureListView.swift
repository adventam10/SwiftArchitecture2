//
//  PrefectureListView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class PrefectureListView: XibLoadView {
    @IBOutlet weak var favoriteFilterButton: UIButton!
    @IBOutlet weak var areaFilterButton: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.prefectureListTableViewCell)
        }
    }
}
