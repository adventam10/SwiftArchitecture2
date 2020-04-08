//
//  AreaFilterViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//
import UIKit
import Models
import Views

protocol AreaFilterViewControllerDelegate: AnyObject {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>)
}

final class AreaFilterViewController: UIViewController {

    weak var delegate: AreaFilterViewControllerDelegate?
    let viewSize = CGSize(width: 150, height: 44*9)
    var isAllCheck: Bool {
        return model.areaList.allSatisfy { model.selectedAreaIds.contains($0.id) }
    }

    var model: AreaFilterModel! {
        didSet {
            registerModel()
        }
    }

    private lazy var myView = AreaFilterView()

    deinit {
        model.notificationCenter.removeObserver(self)
    }

    private func registerModel() {
        model.notificationCenter.addObserver(forName: .init(rawValue: "selectedAreaIds"),
                                             object: nil,
                                             queue: nil,
                                             using:
            {
                [weak self] notification in
                if let selectedAreaIds = notification.userInfo?["selectedAreaIds"] as? Set<Int> {
                    if let weakSelf = self {
                        weakSelf.updateViews()
                        weakSelf.delegate?.areaFilterViewController(weakSelf, didChangeSelectedAreaIds: selectedAreaIds)
                    }
                }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.tableView.delegate = self
        myView.tableView.dataSource = self
        myView.allCheckButton.addTarget(self, action: #selector(allCheck(_:)), for: .touchUpInside)
        updateViews()
    }

    override func loadView() {
        view = myView
    }

    @objc private func allCheck(_ sender: Any) {
        model.updateAreaIds(isAllCheck: !isAllCheck)
    }

    private func updateViews() {
        myView.tableView.reloadData()
        myView.allCheckButton.isSelected = isAllCheck
    }
}

extension AreaFilterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let area = model.areaList[indexPath.row]
        model.updateAreaIds(id: area.id)
    }
}

extension AreaFilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.areaList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myView.cellIdentifier, for: indexPath) as! AreaFilterTableViewCell
        let area = model.areaList[indexPath.row]
        cell.nameLabel.text = area.name
        cell.checkButton.isSelected = model.selectedAreaIds.contains(area.id)
        return cell
    }
}
