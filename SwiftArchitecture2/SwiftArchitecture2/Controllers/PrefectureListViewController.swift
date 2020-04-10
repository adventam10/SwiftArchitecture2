//
//  PrefectureListViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit

let BASE_URL = "http://weather.livedoor.com/forecast/webservice/json/v1"

enum APIError: Error {
    case network
    case server
    case invalidJSON
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network:
            return "ネットワークの接続状態を確認してください。"
        case .server:
            return "サーバーと通信できません。"
        case .invalidJSON:
            return "JSONパース失敗。"
        }
    }
}


final class PrefectureListViewController: UIViewController {

    enum CellItemTag: Int {
        case favoriteButton = 1
        case nameLabel = 2
    }

    enum UserDefaultsKey: String {
        case favoriteIds = "FAVORITE_PREFECTURE_CITY_IDS"
    }

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.rowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let areaFilterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("地方で絞込む", for: .normal)
        button.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        button.setImage(UIImage(named: "btn_filter"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let favoriteFilterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("お気に入りのみ表示する", for: .normal)
        button.setImage(UIImage(named: "btn_check_normal"), for: .normal)
        button.setImage(UIImage(named: "btn_check_selected"), for: .selected)
        button.titleEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 0)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentHorizontalAlignment = .leading
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let headerView: UIView = {
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    private let progressView: UIView = {
        let progress = UIView()
        progress.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let prefectureList: [[String: Any]] = {
        let url = Bundle.main.url(forResource: "CityData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let result = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            return result ?? []
        } catch {
            print(error.localizedDescription)
            return []
        }
    }()
    private let userDefaults = UserDefaults.standard
    private var tableDataList: [[String: Any]] = []
    private var favoriteIds: [String] {
        return userDefaults.array(forKey: UserDefaultsKey.favoriteIds.rawValue) as? [String] ?? []
    }
    private var selectedAreaIds: Set<Int> = Set(Area.allCases.map { $0.rawValue })

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "都道府県"
        view.backgroundColor = .white
        addSubViews()
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
        areaFilterButton.addTarget(self, action: #selector(filterByArea(_:)), for: .touchUpInside)
        favoriteFilterButton.addTarget(self, action: #selector(filterByFavorite(_:)), for: .touchUpInside)
        tableDataList = prefectureList
    }

    // MARK: - Setup Views
    private func addSubViews() {
        view.addSubview(mainStackView)
        headerView.addSubview(favoriteFilterButton)
        headerView.addSubview(areaFilterButton)
        mainStackView.addArrangedSubview(headerView)
        mainStackView.addArrangedSubview(makeSeparatorView())
        mainStackView.addArrangedSubview(tableView)
        progressView.addSubview(indicatorView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
            ])
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 44),
            favoriteFilterButton.widthAnchor.constraint(equalToConstant: 216),
            favoriteFilterButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            favoriteFilterButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            areaFilterButton.widthAnchor.constraint(equalToConstant: 136),
            areaFilterButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            areaFilterButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 0),
            indicatorView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor, constant: 0)
        ])
    }

    private func makeSeparatorView() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .gray
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return separator
    }

    // MARK: - Action
    @objc private func filterByArea(_ sender: Any) {
        if let button = sender as? UIButton {
            showAreaFilterViewController(button: button)
        }
    }

    @objc private func filterByFavorite(_ sender: Any) {
        favoriteFilterButton.isSelected.toggle()
        filteredTableDataList()
        tableView.reloadData()
    }

    // MARK: - Show
    private func showProgress() {
        indicatorView.startAnimating()
        navigationController?.view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: progressView.superview!.topAnchor, constant: 0),
            progressView.bottomAnchor.constraint(equalTo: progressView.superview!.bottomAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: progressView.superview!.leadingAnchor, constant: 0),
            progressView.trailingAnchor.constraint(equalTo: progressView.superview!.trailingAnchor, constant: 0)
        ])
    }

    private func hideProgress() {
        indicatorView.stopAnimating()
        progressView.removeFromSuperview()
    }

    private func showAreaFilterViewController(button: UIButton) {
        let viewController = AreaFilterViewController()
        viewController.selectedAreaIds = selectedAreaIds
        viewController.delegate = self
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: 150, height: 44*9)
        let presentationController = viewController.popoverPresentationController
        presentationController?.delegate = self
        presentationController?.permittedArrowDirections = .up
        presentationController?.sourceView = button
        presentationController?.sourceRect = button.bounds
        present(viewController, animated: true, completion: nil)
    }

    private func showAlert(title: String = "",
                   message: String,
                   buttonTitle: String = "OK",
                   buttonAction: @escaping (() -> Void) = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle,
                                          style: .default,
                                          handler:
            {
                (action: UIAlertAction!) -> Void in
                buttonAction()
        })
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    private func showWeatherViewController(weather: [String: Any?], cityId: String) {
        let viewController = WeatherViewController()
        viewController.cityId = cityId
        viewController.weather = weather
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Update FavoriteIds
    private func addFavoriteId(_ id: String) {
        var list = favoriteIds
        list.append(id)
        userDefaults.set(list, forKey: UserDefaultsKey.favoriteIds.rawValue)
    }

    private func removeFavoriteId(_ id: String) {
        var list = favoriteIds
        list.removeAll { $0 == id }
        userDefaults.set(list, forKey: UserDefaultsKey.favoriteIds.rawValue)
    }

    private func updateFavoriteIds(_ id: String) {
        if favoriteIds.contains(id) {
            removeFavoriteId(id)
        } else {
            addFavoriteId(id)
        }
    }

    // MARK: - Filter
    private func prefectureFiltered(isFilterFavorite: Bool,
                                   favoriteIds: [String],
                                   selectedAreaIds: Set<Int>) -> [[String: Any]] {
        return prefectureList.filter {
            let area = $0["area"] as! Int
            let cityId = $0["cityId"] as! String
            if isFilterFavorite {
                return selectedAreaIds.contains(area) && favoriteIds.contains(cityId)
            } else {
                return selectedAreaIds.contains(area)
            }
        }
    }

    private func filteredTableDataList() {
         tableDataList = prefectureFiltered(isFilterFavorite: favoriteFilterButton.isSelected,
                                            favoriteIds: favoriteIds,
                                            selectedAreaIds: selectedAreaIds)
    }

    // MARK: - Request
    private func requestWeather(cityId: String, completion: @escaping (Result<[String: Any?], APIError>) -> Void) {
        let session = URLSession.shared
        let url = BASE_URL + "?city=\(cityId)"
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let _ = error {
                completion(.failure(.network))
                return
            }

            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(.failure(.server))
                return
            }
            guard let data = data,
                let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] else {
                    completion(.failure(.invalidJSON))
                    return
            }
            completion(.success(result))
        }
        task.resume()
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
        let cityId = tableDataList[indexPath.row]["cityId"] as! String
        requestWeather(cityId: cityId) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideProgress()
                switch result {
                case .success(let weather):
                    self?.showWeatherViewController(weather: weather, cityId: cityId)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
}

extension PrefectureListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(with: tableView)
        cell.accessoryType = .disclosureIndicator
        let favoriteButton = cell.viewWithTag(CellItemTag.favoriteButton.rawValue) as? UIButton
        let nameLabel = cell.viewWithTag(CellItemTag.nameLabel.rawValue) as? UILabel
        favoriteButton?.addTarget(self, action: #selector(changeFavorite(_:)), for: .touchUpInside)
        let data = tableDataList[indexPath.row]
        nameLabel?.text = data["name"] as? String
        let cityId = data["cityId"] as? String
        favoriteButton?.isSelected = cityId.flatMap { favoriteIds.contains($0) } ?? false
        return cell
    }

    private func makeCell(with tableView: UITableView) -> UITableViewCell {
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)

            let button = UIButton()
            button.setImage(UIImage(named: "btn_favorite_normal"), for: .normal)
            button.setImage(UIImage(named: "btn_favorite_selected"), for: .selected)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = CellItemTag.favoriteButton.rawValue
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tag = CellItemTag.nameLabel.rawValue
            
            cell?.contentView.addSubview(button)
            cell?.contentView.addSubview(label)
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 30),
                button.widthAnchor.constraint(equalToConstant: 30),
                button.leadingAnchor.constraint(equalTo: button.superview!.leadingAnchor, constant: 16),
                button.centerYAnchor.constraint(equalTo: button.superview!.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 16),
                label.trailingAnchor.constraint(lessThanOrEqualTo: label.superview!.trailingAnchor, constant: -16),
                label.centerYAnchor.constraint(equalTo: label.superview!.centerYAnchor),
            ])
        }
        return cell!
    }

    @objc private func changeFavorite(_ sender: Any) {
        guard let sender = sender as? UIView,
        let cell = getCell(from: sender),
            let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let data = tableDataList[indexPath.row]
        updateFavoriteIds(data["cityId"] as! String)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func getCell(from targetView: UIView) -> UITableViewCell? {
        var target = targetView
        while let superView = target.superview {
            if let cell = superView as? UITableViewCell {
                return cell
            }
            target = superView
        }
        return nil
    }
}

extension PrefectureListViewController: AreaFilterViewControllerDelegate {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>) {
        self.selectedAreaIds = selectedAreaIds
        filteredTableDataList()
        tableView.reloadData()
    }
}
