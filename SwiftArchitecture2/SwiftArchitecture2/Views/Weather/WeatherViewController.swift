//
//  WeatherViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

final class WeatherViewController: UIViewController {
    var viewModel: WeatherViewModel!
    private lazy var myView = WeatherView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: nil)

        viewModel.refreshButtonAction.completed.observeValues { [weak self] in
            self?.hideProgress()
        }
        viewModel.refreshButtonAction.errors.observeValues { [weak self] error in
            self?.showAlert(message: error.localizedDescription)
        }
        navigationItem.rightBarButtonItem?.reactive.pressed = CocoaAction(viewModel.refreshButtonAction) { [weak self] _ in
            self?.showProgress()
        }
        viewModel.weatherViewData.producer.startWithValues { [weak self] data in
            self?.myView.updateViews(with: data)
        }
    }

    override func loadView() {
        view = myView
    }
}
