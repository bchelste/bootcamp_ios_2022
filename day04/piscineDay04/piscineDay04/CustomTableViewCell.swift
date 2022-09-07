//
//  CustomTableViewCell.swift
//  piscineDay04
//
//  Created by Artem Potekhin on 14.08.2022.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let background: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sheet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configureCell(news: TweetNews) {
        nameLabel.text = news.user?.name ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let dateStringDateFormatter = DateFormatter()
        dateStringDateFormatter.locale = Locale(identifier: "en_US")
        dateStringDateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"

        let tmpStr = news.createdAt ?? ""
        let tmpDate = dateStringDateFormatter.date(from: tmpStr) ?? Date()

        dateLabel.text = dateFormatter.string(from: tmpDate)
        commentLabel.text = news.text ?? ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(stackView)
        contentView.addSubview(commentLabel)

        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            commentLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
