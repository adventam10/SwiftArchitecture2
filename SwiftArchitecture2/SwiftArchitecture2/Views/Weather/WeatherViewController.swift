//
//  WeatherViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController, WeatherPresenterOutput {
    var presenter: WeatherPresenter!
    private lazy var myView = WeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refresh(_:)))
        presenter.viewDidLoad()
    }

    override func loadView() {
        view = myView
    }

    @objc private func refresh(_ sender: Any) {
        presenter.didTapRefreshButton()
    }

    func updateViews(with data: WeatherViewData) {
        myView.updateViews(with: data)
    }
}