//
//  AreaFilterViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit

protocol AreaFilterViewControllerDelegate: AnyObject {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>)
}

final class AreaFilterViewController: UIViewController, AreaFilterPresenterOutput {
    weak var delegate: AreaFilterViewControllerDelegate?
    let viewSize = CGSize(width: 150, height: 44 * 9)

    var presenter: AreaFilterPresenter!
    private lazy var myView = AreaFilterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.tableView.delegate = self
        myView.tableView.dataSource = self
        myView.allCheckButton.addTarget(self, action: #selector(allCheck(_:)), for: .touchUpInside)
        presenter.viewDidLoad()
    }

    override func loadView() {
        view = myView
    }

    @objc private func allCheck(_ sender: Any) {
        presenter.didTapAllCheckButton()
    }

    func updateViews(with data: AreaFilterViewData) {
        myView.tableView.reloadData()
        myView.updateViews(with: data)
    }

    func didChangeSelectedAreaIds(_ selectedAreaIds: Set<Int>) {
        delegate?.areaFilterViewController(self, didChangeSelectedAreaIds: selectedAreaIds)
    }
}

extension AreaFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension AreaFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfTableDataList
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.areaFilterTableViewCell, for: indexPath)!
        cell.updateViews(with: presenter.makeAreaFilterTableViewCellData(forRow: indexPath.row))
        return cell
    }
}
