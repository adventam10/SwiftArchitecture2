//
//  WeatherInfoView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public final class WeatherInfoView: XibLoadView {
    @IBOutlet public weak var minCelsiusLabel: UILabel!
    @IBOutlet public weak var maxCelsiusLabel: UILabel!
    @IBOutlet public weak var weatherLabel: UILabel!
    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var dateTitleLabel: UILabel!
}
