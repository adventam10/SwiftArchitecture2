//
//  WeatherView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

public final class WeatherView: XibLoadView {
    
    @IBOutlet weak public var dayAfterTomorrowView: WeatherInfoView!
    @IBOutlet weak public var todayView: WeatherInfoView!
    @IBOutlet weak public var tomorrowView: WeatherInfoView!
    public let noImage =  UIImage(named: "icon_no_image", in: .init(for: WeatherView.self), compatibleWith: nil)!
}
