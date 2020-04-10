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

enum Area: Int, CaseIterable {

    case hokkaido
    case tohoku
    case kanto
    case chubu
    case kinki
    case chugoku
    case shikoku
    case kyushu
}

final class AreaFilterViewController: UIViewController {

    weak var delegate: AreaFilterViewControllerDelegate?
    var selectedAreaIds: Set<Int> = [] {
        didSet {
            delegate?.areaFilterViewController(self, didChangeSelectedAreaIds: selectedAreaIds)
        }
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
        table.separatorInset = .zero
        table.rowHeight = 44
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private let allCheckButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("すべて", for: .normal)
        button.setImage(UIImage(named: "btn_check_normal"), for: .normal)
        button.setImage(UIImage(named: "btn_check_selected"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        button.contentEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .leading
        return button
    }()

    private let areaList = Area.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubViews()
        setupLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        allCheckButton.addTarget(self, action: #selector(allCheck(_:)), for: .touchUpInside)
        allCheckButton.isSelected = areaList.allSatisfy { selectedAreaIds.contains($0.rawValue) }
    }

    // MARK: - Setup Views
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(allCheckButton)
        mainStackView.addArrangedSubview(makeSeparatorView())
        mainStackView.addArrangedSubview(tableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
            ])
        NSLayoutConstraint.activate([
            allCheckButton.heightAnchor.constraint(equalToConstant: 44)
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
    @objc private func allCheck(_ sender: Any) {
        allCheckButton.isSelected.toggle()
        updateAreaIds(isAllCheck: allCheckButton.isSelected)
        tableView.reloadData()
    }

    // MARK: - Update AreaIds
    private func updateAreaIds(_ id: Int) {
        if selectedAreaIds.contains(id) {
            selectedAreaIds.remove(id)
        } else {
            selectedAreaIds.insert(id)
        }
    }

    private func updateAreaIds(isAllCheck: Bool) {
        if isAllCheck {
            selectedAreaIds = Set(areaList.map { $0.rawValue })
        } else {
            selectedAreaIds.removeAll()
        }
    }
}

extension AreaFilterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let area = areaList[indexPath.row]
        updateAreaIds(area.rawValue)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        allCheckButton.isSelected = areaList.allSatisfy { selectedAreaIds.contains($0.rawValue) }
    }
}

extension AreaFilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        let area = areaList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .default, reuseIdentifier: identifier)
        cell.imageView?.highlightedImage = UIImage(named: "btn_check_selected")
        cell.imageView?.image = UIImage(named: "btn_check_normal")
        cell.imageView?.isHighlighted = selectedAreaIds.contains(area.rawValue)
        switch area {
        case .hokkaido:
            cell.textLabel?.text = "北海道"
        case .tohoku:
            cell.textLabel?.text = "東北"
        case .kanto:
            cell.textLabel?.text = "関東"
        case .chubu:
            cell.textLabel?.text = "中部"
        case .kinki:
            cell.textLabel?.text = "近畿"
        case .chugoku:
            cell.textLabel?.text = "中国"
        case .shikoku:
            cell.textLabel?.text = "四国"
        case .kyushu:
            cell.textLabel?.text = "九州"
        }
        return cell
    }
}
