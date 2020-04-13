//
//  WeatherInfoView.swift
//  Views
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class WeatherInfoView: XibLoadView {
    @IBOutlet private weak var minCelsiusLabel: UILabel!
    @IBOutlet private weak var maxCelsiusLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var dateTitleLabel: UILabel!

    func updateViews(with data: WeatherInfoViewData) {
        minCelsiusLabel.text = data.minCelsius
        maxCelsiusLabel.text = data.maxCelsius
        weatherLabel.text = data.weather
        imageView.image = getImage(imageData: data.imageData)
        dateLabel.text = data.date
        dateTitleLabel.text = data.dateTitle
    }

    private func getImage(imageData: Data?) -> UIImage {
        guard let imageData = imageData,
            let image = UIImage(data: imageData) else {
                return UIImage(named: "icon_no_image")!
        }
        return image
    }
}
