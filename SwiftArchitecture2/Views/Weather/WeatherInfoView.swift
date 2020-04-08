//
//  WeatherInfoView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public final class WeatherInfoView: XibLoadView {

    @IBOutlet weak public var minCelsiusLabel: UILabel!
    @IBOutlet weak public var maxCelsiusLabel: UILabel!
    @IBOutlet weak public var weatherLabel: UILabel!
    @IBOutlet weak public var imageView: UIImageView!
    @IBOutlet weak public var dateLabel: UILabel!
    @IBOutlet weak public var dateTitleLabel: UILabel!
}
