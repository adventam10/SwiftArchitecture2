//
//  PrefectureListViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class PrefectureListViewController: UIViewController, PrefectureListPresenterOutput {
    private var presenter: PrefectureListPresenter!
    private lazy var myView = PrefectureListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.tableView.delegate = self
        myView.tableView.dataSource = self
        myView.areaFilterButton.addTarget(self, action: #selector(filterByArea(_:)), for: .touchUpInside)
        myView.favoriteFilterButton.addTarget(self, action: #selector(filterByFavorite(_:)), for: .touchUpInside)
        presenter = .init(view: self)
        presenter.viewDidLoad()
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
            viewController.presenter = .init(view: viewController, model: weatherModel)
        }
    }

    func updateViews(with data: PrefectureListViewData) {
        myView.updateViews(with: data)
        myView.tableView.reloadData()
    }

    @objc private func filterByArea(_ sender: Any) {
        presenter.didTapAreaFilterAreaButton(sender)
    }

    @objc private func filterByFavorite(_ sender: Any) {
        presenter.didTapFavoriteFilterButton()
    }

    func showAreaFilterViewController(button: UIButton) {
        let viewController = AreaFilterViewController()
        viewController.presenter = presenter.makeAreaFilterPresenter(view: viewController)
        viewController.delegate = self
        showPopover(viewController: viewController,
                    sourceView: button,
                    viewSize: viewController.viewSize,
                    direction: .up,
                    delegate: self)
    }
}

extension PrefectureListViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension PrefectureListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension PrefectureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTableDataList
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myView.cellIdentifier, for: indexPath) as! PrefectureListTableViewCell
        cell.delegate = self
        cell.updateViews(with: presenter.makePrefectureListTableViewCellData(forRow: indexPath.row))
        return cell
    }
}

extension PrefectureListViewController: PrefectureListTableViewCellDelegate {
    func prefectureListTableViewCell(_ cell: PrefectureListTableViewCell, didChangeFavorite sender: Any) {
        guard let indexPath = myView.tableView.indexPath(for: cell) else {
            return
        }
        presenter.didTapFavoriteButton(at: indexPath)
    }
}

extension PrefectureListViewController: AreaFilterViewControllerDelegate {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>) {
        presenter.didChangeSelectedAreaIds(selectedAreaIds)
    }
}
