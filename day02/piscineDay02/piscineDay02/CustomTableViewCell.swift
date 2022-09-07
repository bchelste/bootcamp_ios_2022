//
//  CustomTableViewCell.swift
//  piscineDay02
//
//  Created by Artem Potekhin on 11.08.2022.
//

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
    
    func configureCell(person: PersonData) {
        nameLabel.text = person.name
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: person.date)
        commentLabel.text = "\u{1F480}" + "\n" + person.comment
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        let sheet = UIImage(named: "sheet") ?? UIImage()
        contentView.backgroundColor = UIColor(patternImage: sheet)
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

class EmptyCell: UITableViewCell {
    
    static let identifier = "EmptyCell"

    let background: UIView = {
        let bgView = UIView(frame: CGRect())
        bgView.translatesAutoresizingMaskIntoConstraints = false
        return bgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(background)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),


        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


