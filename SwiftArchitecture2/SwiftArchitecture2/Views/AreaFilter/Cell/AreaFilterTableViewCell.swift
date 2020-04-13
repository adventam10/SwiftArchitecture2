//
//  AreaFilterTableViewCell.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class AreaFilterTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var checkButton: UIButton!

    func updateViews(with data: AreaFilterTableViewCellData) {
        nameLabel.text = data.name
        checkButton.isSelected = data.isCheck
    }
}
