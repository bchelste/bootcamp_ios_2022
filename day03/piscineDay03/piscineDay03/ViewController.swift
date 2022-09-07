//
//  ViewController.swift
//  piscineDay03
//
//  Created by Artem Potekhin on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var imagesColectionView: UICollectionView! = nil
    
    private func configureUI() {
        navigationItem.title = "Images"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(1.0))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                              leading: 5,
                                                              bottom: 5,
                                                              trailing: 5)
        let groupSize =  NSCollectionLayoutSize (widthDimension: .fractionalWidth( 1.0 ),
                                                 heightDimension: .fractionalWidth( 0.4 ) )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: fullPhotoItem,
                                                       count: 2)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureCollectionView() {
        
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        imagesColectionView = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
        
    }
    
    weak var infoDelegate: InfoDelegate?
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return URLSessionManager.shared.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.configureCell(item: indexPath.row, controller: self)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item #\(indexPath.row) was selected")
        let secondViewController = ScrollImageViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
        self.infoDelegate = secondViewController
        infoDelegate?.sendInfo(item: indexPath.row)
        
    }
    
}

protocol InfoDelegate: AnyObject {
    func sendInfo(item: Int)
}


