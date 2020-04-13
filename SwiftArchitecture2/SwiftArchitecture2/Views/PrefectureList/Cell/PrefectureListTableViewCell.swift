//
//  PrefectureListTableViewCell.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

protocol PrefectureListTableViewCellDelegate: AnyObject {
    func prefectureListTableViewCell(_ cell: PrefectureListTableViewCell, didChangeFavorite sender: Any)
}

final class PrefectureListTableViewCell: UITableViewCell {
    weak var delegate: PrefectureListTableViewCellDelegate?
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    @IBAction private func changeFavorite(_ sender: Any) {
        delegate?.prefectureListTableViewCell(self, didChangeFavorite: sender)
    }

    func updateViews(with data: PrefectureListTableViewCellData) {
        nameLabel.text = data.name
        favoriteButton.isSelected = data.isFavorite
    }
}
