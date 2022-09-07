//
//  ViewController.swift
//  piscineDay02
//
//  Created by Artem Potekhin on 11.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(EmptyCell.self,
                           forCellReuseIdentifier: EmptyCell.identifier)
        return tableView
    }()
    
    var data = [PersonData]()
    
    func addStartData() {
        let firstPerson = PersonData(name: "bchelste", date: Date(timeIntervalSinceNow: 90000), comment: "Piscine Swift IOS")

        let secondPerson = PersonData(name: "Petr Petrov", date: Date(timeIntervalSince1970: 0), comment: "kill by knife")

        let thirdPerson = PersonData(name: "Ivan Ivanov", date: Date(), comment: "crush under the wheels of a bus")
        
        data.append(firstPerson)
        data.append(secondPerson)
        data.append(thirdPerson)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        addStartData()
    }
    
    func configureUI() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let buttonImage = UIImage(systemName: "plus", withConfiguration: largeConfig)
        navigationItem.title = "Death Note"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: buttonImage,
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(addButtonTap))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        configureUI()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc private func addButtonTap() {
        let secondViewController = SecondViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
        secondViewController.infoDelegate = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count * 2 - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 1 {
            return tableView.dequeueReusableCell(withIdentifier: EmptyCell.identifier, for: indexPath)
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(person: data[(indexPath.row / 2)])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row % 2 == 1 {
//            return 20
//        } else {
//            return 150
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell was tapped")
    }
    
    
}

extension ViewController: InfoDelegate {
    func sendPersonInfo(info: PersonData) {
        print("info came to ViewController:")
        print(info.name)
        print(info.date)
        print(info.comment)
        data.append(info)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
}

