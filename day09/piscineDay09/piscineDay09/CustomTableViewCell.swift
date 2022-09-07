//
//  CustomTableViewCell.swift
//  piscineDay09
//
//  Created by Artem Potekhin on 23.08.2022.
//

import Foundation
import UIKit
import ArticleManager

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    lazy var articleLanguage: String = ""
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
//        label.backgroundColor = .systemMint
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .left
        return label
    }()
    
    private let modificationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .left
        return label
    }()
    
    private let articleImage: UIImageView = {
//        let imageView = UIImageView(frame: CGRect(origin: CGPoint(),
//                                                  size: CGSize(width: 200,
//                                                               height: 200)))
        let imageView = UIImageView()
//        imageView.backgroundColor = .gray
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
//        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let separationLine: UIView = {
        let separator = UIView()
//        let separator = UIView(frame: CGRect(origin: CGPoint(),
//                                             size: CGSize(width: 200,
//                                                          height: 2)))
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .black
        return separator
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   articleImage,
                                                   contentLabel,
                                                   creationDateLabel,
                                                   modificationDateLabel,
                                                   separationLine
                                                  ])

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
//        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    func configureCell(articleData: Article) {
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.locale = Locale(identifier: "en_US")
        dateFormatterDay.dateFormat = "d MMM yyyy"
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.locale = Locale(identifier: "en_US")
        dateFormatterTime.dateFormat = "HH:mm:ss"
        
        let currentLanguage = Locale.current.languageCode ?? ""
        
        titleLabel.text = articleData.title ?? ""
        contentLabel.text = articleData.content ?? ""
        
//        articleImage.image = nil
//        DispatchQueue.main.async {
//            if let data = articleData.image {
//                self.articleImage.image = UIImage(data: data)
//            } else {
//                self.articleImage.image = nil
//            }
//        }
        
        if let data = articleData.image {
            articleImage.image = UIImage(data: data)
        } else {
            articleImage.image = nil
        }
        
        let creationDate = articleData.creationDate ?? Date()
        let modificationDate = articleData.modificationDate ?? creationDate
        articleLanguage = articleData.language ?? currentLanguage
        var tmpDay = dateFormatterDay.string(from: creationDate)
        var tmpTime = dateFormatterTime.string(from: creationDate)
        creationDateLabel.text = "Creation: \(tmpDay) at \(tmpTime)"
        tmpDay = dateFormatterDay.string(from: modificationDate)
        tmpTime = dateFormatterTime.string(from: modificationDate)
        modificationDateLabel.text = "Modification: \(tmpDay) at \(tmpTime)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray4
        contentView.backgroundColor = .clear
        contentView.addSubview(stackView)

        
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
//            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            
//            articleImage.widthAnchor.constraint(equalToConstant: 200),
//            articleImage.heightAnchor.constraint(equalToConstant: 200),
//            articleImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
//            articleImage.heightAnchor.constraint(equalTo: articleImage.widthAnchor),
            contentLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
            creationDateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
            modificationDateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
            
            separationLine.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
            separationLine.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            

        ])
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        NSLayoutConstraint.activate([
//            contentLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
//            creationDateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
//            modificationDateLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
////            articleImage.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
////            articleImage.heightAnchor.constraint(equalTo: articleImage.widthAnchor),
//            separationLine.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.95),
//            separationLine.heightAnchor.constraint(equalToConstant: 1),
//
//            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
//        ])
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
