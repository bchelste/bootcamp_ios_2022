//
//  ViewController.swift
//  piscineDay04
//
//  Created by Artem Potekhin on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var newsStorage = [TweetNews]()
    
    lazy var apiController = APIController(delegate: self, token: accessKey)
    
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 20)
        textField.textAlignment = .left
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.placeholder = "key word"
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
  
    }
    
    func setConstraints() {
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Tweets"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationController?.navigationBar.backgroundColor = UIColor(named: "navigationBarGrey")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizer()
        self.searchTextField.delegate = self
        configureUI()
        configureTableView()
        setConstraints()
        
    }
        
    func fillTable(replyArray: [TweetNews]) {
        print(replyArray)
        newsStorage = replyArray
        tableView.reloadData()
    }
    
    func handleAlertsNSError(replyErrors: NSError) {
        print(replyErrors)
        showAlertController(error: replyErrors.localizedDescription)

    }
    
    func handleAlertsTweetError(replyErrors: TweetError) {
        print(replyErrors.errorDescription)
        showAlertController(error: replyErrors.errorDescription)
    }
    
    
    func showAlertController(error: String) {
        let alert = UIAlertController(title: "Warning",
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
    
}

extension ViewController: APITwitterDelegate {
    func errorTweetsHandle(error: TweetError) {
        DispatchQueue.main.async {
            self.handleAlertsTweetError(replyErrors: error)
        }
    }
    
    
    func receiveTweets(array: [TweetNews]) {
        DispatchQueue.main.async {
            self.fillTable(replyArray: array)
            self.tableView.reloadData()
        }
    }
    
    func errorTweetsHandle(error: NSError) {
        DispatchQueue.main.async {
            self.handleAlertsNSError(replyErrors: error)
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(news: newsStorage[indexPath.row])
        return cell
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let keyWord = textField.text ?? ""
        DispatchQueue.main.async {
            self.apiController.fetchTweets(src: keyWord)
        }
        return searchTextField.resignFirstResponder()
    }
    
    func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
