//
//  WeatherView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class WeatherView: XibLoadView {
    @IBOutlet private weak var dayAfterTomorrowView: WeatherInfoView!
    @IBOutlet private weak var todayView: WeatherInfoView!
    @IBOutlet private weak var tomorrowView: WeatherInfoView!

    func updateViews(with data: WeatherViewData) {
        todayView.updateViews(with: data.today)
        tomorrowView.updateViews(with: data.tomorrow)
        dayAfterTomorrowView.updateViews(with: data.dayAfterTomorrow)
    }
}
