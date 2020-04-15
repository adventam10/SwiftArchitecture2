//
//  PrefectureListViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

final class PrefectureListViewController: UIViewController {
    private var viewModel: PrefectureListViewModel!
    private lazy var myView = PrefectureListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.tableView.delegate = self
        myView.tableView.dataSource = self

        viewModel = .init(lifetime: reactive.lifetime)
        myView.favoriteFilterButton.reactive.isSelected <~ viewModel.isCheckFavoriteFilter
        viewModel.tableDataList.signal.observe { [weak self] _ in
            self?.myView.tableView.reloadData()
        }
        myView.areaFilterButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] button in
            self?.showAreaFilterViewController(button: button)
        }
        viewModel.favoriteFilterButtonAction <~ myView.favoriteFilterButton.reactive.controlEvents(.touchUpInside)
        viewModel.didSelectRowAction.values.observeValues { [weak self] weatherModel in
            self?.hideProgress()
            self?.showWeatherViewController(model: weatherModel)
        }
        viewModel.didSelectRowAction.errors.observeValues { [weak self] error in
            self?.hideProgress()
            self?.showAlert(message: error.localizedDescription)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = myView.tableView.indexPathForSelectedRow {
            myView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func loadView() {
        view = myView
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? WeatherViewController,
            let weatherModel = sender as? WeatherModelInput {
            viewController.viewModel = .init(lifetime: reactive.lifetime, model: weatherModel)
        }
    }

    private func showAreaFilterViewController(button: UIButton) {
        let viewController = AreaFilterViewController()
        viewController.viewModel = viewModel.makeAreaFilterViewModel()
        viewController.delegate = self
        showPopover(viewController: viewController,
                    sourceView: button,
                    viewSize: viewController.viewSize,
                    direction: .up,
                    delegate: self)
    }

    private func showWeatherViewController(model: WeatherModelInput) {
        performSegue(withIdentifier: R.segue.prefectureListViewController.showWeather,
                     sender: model)
    }
}

extension PrefectureListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension PrefectureListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showProgress()
        viewModel.didSelectRowAction.apply(indexPath).start()
    }
}

extension PrefectureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTableDataList
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.prefectureListTableViewCell, for: indexPath)!
        cell.updateViews(with: viewModel.makePrefectureListTableViewCellData(forRow: indexPath.row))
        let disposable = CompositeDisposable()
        cell.reactive.prepareForReuse.observeValues(disposable.dispose)
        disposable += viewModel.favoriteButtonAction <~ cell.reactive.favoriteButtonEvent.map { _ in indexPath }
        return cell
    }
}

extension PrefectureListViewController: AreaFilterViewControllerDelegate {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>) {
        viewModel.didChangeSelectedAreaIds(selectedAreaIds)
    }
}
