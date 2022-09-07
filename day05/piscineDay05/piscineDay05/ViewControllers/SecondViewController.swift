//
//  SecondViewController.swift
//  piscineDay05
//
//  Created by Artem Potekhin on 14.08.2022.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    weak var tabBarDelegate: TabBarDelegate?
    weak var openMapDelegate: OpenMapDelegate?
    
    var storageData = [String]()
    
    func addStartData() {
        for item in LocationManager.shared.locationsStorage {
            storageData.append(item.title)
        }

    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    func configureTableView() {

        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setConstraints() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStartData()
        setConstraints()
        configureTableView()

    }
}
    
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(data: storageData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell #\(indexPath.row) was tapped")
        tabBarDelegate?.openFirstViewController()
        openMapDelegate?.setLocation(item: indexPath.row)
        
    }
}
