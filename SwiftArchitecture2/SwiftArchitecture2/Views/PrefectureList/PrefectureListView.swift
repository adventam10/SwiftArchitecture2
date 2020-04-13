//
//  PrefectureListView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class PrefectureListView: XibLoadView {
    let cellIdentifier = "PrefectureListTableViewCell"
    @IBOutlet weak var favoriteFilterButton: UIButton!
    @IBOutlet weak var areaFilterButton: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: cellIdentifier)
        }
    }

    func updateViews(with data: PrefectureListViewData) {
        favoriteFilterButton.isSelected = data.isFavoriteFilter
    }
}
