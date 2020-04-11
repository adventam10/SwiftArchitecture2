//
//  WeatherView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public final class WeatherView: XibLoadView {
    @IBOutlet public weak var dayAfterTomorrowView: WeatherInfoView!
    @IBOutlet public weak var todayView: WeatherInfoView!
    @IBOutlet public weak var tomorrowView: WeatherInfoView!
    public let noImage = UIImage(named: "icon_no_image", in: .init(for: WeatherView.self), compatibleWith: nil)!
}
