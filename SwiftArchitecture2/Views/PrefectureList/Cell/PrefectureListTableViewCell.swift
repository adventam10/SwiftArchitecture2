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

    weak public var delegate: PrefectureListTableViewCellDelegate?
    @IBOutlet weak public var nameLabel: UILabel!
    @IBOutlet weak public var favoriteButton: UIButton!

    @IBAction private func changeFavorite(_ sender: Any) {
        delegate?.prefectureListTableViewCell(self, didChangeFavorite: sender)
    }
}
