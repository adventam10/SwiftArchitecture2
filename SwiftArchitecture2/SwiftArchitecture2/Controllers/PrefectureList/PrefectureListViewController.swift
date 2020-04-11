//
//  PrefectureListViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//
import UIKit
import Models
import Views

final class PrefectureListViewController: UIViewController {
    var model: PrefectureListModel! {
        didSet {
            registerModel()
        }
    }

    private lazy var myView = PrefectureListView()

    private var tableDataList: [CityData] = [] {
        didSet {
            updateViews()
        }
    }
    private var isCheckFavoriteFilter = false
    private var selectedAreaIds: Set<Int> = []

    private func registerModel() {
        selectedAreaIds = Set(Area.allCases.map { $0.id })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.tableView.delegate = self
        myView.tableView.dataSource = self
        myView.areaFilterButton.addTarget(self, action: #selector(filterByArea(_:)), for: .touchUpInside)
        myView.favoriteFilterButton.addTarget(self, action: #selector(filterByFavorite(_:)), for: .touchUpInside)
        model = PrefectureListModel(dataStore: FavoritePrefectureDataStoreImpl())
        tableDataList = model.prefectureList
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
            let weatherModel = sender as? WeatherModel {
            viewController.model = weatherModel
        }
    }

    @objc private func filterByArea(_ sender: Any) {
        showAreaFilterViewController(button: sender as! UIButton)
    }

    @objc private func filterByFavorite(_ sender: Any) {
        isCheckFavoriteFilter.toggle()
        filteredTableDataList()
    }

    private func showAreaFilterViewController(button: UIButton) {
        let viewController = AreaFilterViewController()
        viewController.model = AreaFilterModel(selectedAreaIds: selectedAreaIds)
        viewController.delegate = self
        showPopover(viewController: viewController,
                    sourceView: button,
                    viewSize: viewController.viewSize,
                    direction: .up,
                    delegate: self)
    }

    private func filteredTableDataList() {
        tableDataList = model.prefectureFiltered(isFilterFavorite: isCheckFavoriteFilter,
                                                 favoriteIds: model.favoriteIds,
                                                 selectedAreaIds: selectedAreaIds)
    }

    private func updateViews() {
        myView.favoriteFilterButton.isSelected = isCheckFavoriteFilter
        myView.tableView.reloadData()
    }

    // この処理はもっとどこか共通の場所でやるべきかもしれない
    private func makeAPIClient() -> APIClient {
        #if DUMMY
        return DummyAPIClient.shared
        #else
        return DefaultAPIClient.shared
        #endif
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
        let data = tableDataList[indexPath.row]
        let weatherModel = WeatherModel(cityId: data.cityId, apiClient: makeAPIClient())
        weatherModel.requestWeather { [weak self, weatherModel] result in
            self?.hideProgress()
            switch result {
            case .success:
                self?.performSegue(withIdentifier: "showWeather", sender: weatherModel)
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
        }
    }
}

extension PrefectureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myView.cellIdentifier, for: indexPath) as! PrefectureListTableViewCell
        cell.delegate = self
        let data = tableDataList[indexPath.row]
        cell.nameLabel.text = data.name
        cell.favoriteButton.isSelected = model.favoriteIds.contains(data.cityId)
        return cell
    }
}

extension PrefectureListViewController: PrefectureListTableViewCellDelegate {
    func prefectureListTableViewCell(_ cell: PrefectureListTableViewCell, didChangeFavorite sender: Any) {
        guard let indexPath = myView.tableView.indexPath(for: cell) else {
            return
        }
        let data = tableDataList[indexPath.row]
        let result = model.updateFavoriteIds(cityId: data.cityId)
        switch result {
        case .success:
            filteredTableDataList()
        case .failure:
            // アラートを出すほどではない？？
            print("お気に入りの保存に失敗しました")
            return
        }
    }
}

extension PrefectureListViewController: AreaFilterViewControllerDelegate {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>) {
        self.selectedAreaIds = selectedAreaIds
        filteredTableDataList()
    }
}
