//
//  AreaFilterViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

protocol AreaFilterViewControllerDelegate: AnyObject {
    func areaFilterViewController(_ areaFilterViewController: AreaFilterViewController, didChangeSelectedAreaIds selectedAreaIds: Set<Int>)
}

final class AreaFilterViewController: UIViewController {
    weak var delegate: AreaFilterViewControllerDelegate?
    let viewSize = CGSize(width: 150, height: 44 * 9)

    var viewModel: AreaFilterViewModel!
    private lazy var myView = AreaFilterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.tableView.delegate = self
        myView.tableView.dataSource = self
        myView.allCheckButton.reactive.isSelected <~ viewModel.isAllCheck
        viewModel.allCheckButtonAction <~ myView.allCheckButton.reactive.controlEvents(.touchUpInside)
        viewModel.selectedAreaIds.signal.observeValues { [weak self] selectedAreaIds in
            self?.myView.tableView.reloadData()
            self?.didChangeSelectedAreaIds(selectedAreaIds)
        }
    }

    override func loadView() {
        view = myView
    }

    private func didChangeSelectedAreaIds(_ selectedAreaIds: Set<Int>) {
        delegate?.areaFilterViewController(self, didChangeSelectedAreaIds: selectedAreaIds)
    }
}

extension AreaFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAction.apply(indexPath).start()
    }
}

extension AreaFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTableDataList
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.areaFilterTableViewCell, for: indexPath)!
        cell.updateViews(with: viewModel.makeAreaFilterTableViewCellData(forRow: indexPath.row))
        return cell
    }
}
