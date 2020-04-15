//
//  PrefectureListTableViewCell.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

final class PrefectureListTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!

    func updateViews(with data: PrefectureListTableViewCellData) {
        nameLabel.text = data.name
        favoriteButton.isSelected = data.isFavorite
    }
}

extension Reactive where Base == PrefectureListTableViewCell {
    var favoriteButtonEvent: Signal<UIButton, Never> {
        return base.favoriteButton.reactive.controlEvents(.touchUpInside)
    }
}
