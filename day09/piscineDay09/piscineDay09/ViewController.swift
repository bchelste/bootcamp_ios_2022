//
//  ViewController.swift
//  piscineDay09
//
//  Created by Artem Potekhin on 22.08.2022.
//

import UIKit
import ArticleManager

class ViewController: UIViewController {
    
//    var myArticles = [Article]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        setConstraints()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemGray5
        self.title = "Diary".localized()
        let buttonImage = UIImage(systemName: "plus")
        navigationItem.rightBarButtonItem  = UIBarButtonItem(image: buttonImage,
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(addButtonTap))
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        myArticles = ArticleManager.shared.getAllArticles()
        configureViewController()
        configureTableView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
        setConstraints()
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(.all)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        AppUtility.lockOrientation(.portrait)
//        DispatchQueue.main.async {
////            self.myArticles = ArticleManager.shared.getAllArticles()
//            self.tableView.reloadData()
//        }
//        myArticles = ArticleManager.shared.getAllArticles()
        tableView.reloadData()
    }
    
    @objc func addButtonTap() {
        print("addButton was tapped")
        let secondViewController = SecondViewController()
        secondViewController.getCurrentArticle(article: nil)
        navigationController?.pushViewController(secondViewController, animated: true)
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleManager.shared.getAllArticles().count
//        return myArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
                return UITableViewCell()
        }
//        cell.configureCell(articleData: myArticles[indexPath.row])
        let articleStorrage = ArticleManager.shared.getAllArticles()
        cell.configureCell(articleData: articleStorrage[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell was tapped")
        let secondViewController = SecondViewController()
        secondViewController.getCurrentArticle(article: ArticleManager.shared.getAllArticles()[indexPath.row])
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    // MARK: - delete cell
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let victim = ArticleManager.shared.getAllArticles()[indexPath.row]
            ArticleManager.shared.removeArticle(article: victim)
//            myArticles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ArticleManager.shared.save()
            tableView.endUpdates()
            
        }
    }
    
    
}

