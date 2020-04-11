//
//  PrefectureListTableViewCell.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public protocol PrefectureListTableViewCellDelegate: AnyObject {
    func prefectureListTableViewCell(_ cell: PrefectureListTableViewCell, didChangeFavorite sender: Any)
}

public final class PrefectureListTableViewCell: UITableViewCell {
    public weak var delegate: PrefectureListTableViewCellDelegate?
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var favoriteButton: UIButton!

    @IBAction private func changeFavorite(_ sender: Any) {
        delegate?.prefectureListTableViewCell(self, didChangeFavorite: sender)
    }
}
