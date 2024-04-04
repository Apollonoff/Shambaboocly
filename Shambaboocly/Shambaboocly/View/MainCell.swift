//
//  MainCell.swift
//  Shambaboocly
//
//  Created by Arseniy Apollonov on 04.04.2024.
//

import UIKit

enum CellState {
    case dead
    case alive
    case life
    
    func getImageName() -> String {
        switch self {
        case .dead:
            return "deadImage"
        case .alive:
            return "aliveImage"
        case .life:
            return "lifeImage"
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .dead:
            return "Мертвая"
        case .alive:
            return "Живая"
        case .life:
            return "Жизнь"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .dead:
            return "или прикидывается"
        case .alive:
            return "и шевелится!"
        case .life:
            return "Ку-ку!"
        }
    }
}

final class MainCell: UITableViewCell {
    
    static let identifier = "MainCellIdentifier"
    
    private let newContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        setupNewContentView()
        setupCellImage()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMainCell(title: String, desctription: String, imageName: String) {
        titleLabel.text = title
        descriptionLabel.text = desctription
        cellImage.image = UIImage(named: imageName)
    }
}
// MARK: - Layouts
private extension MainCell {
    
    func setupNewContentView() {
        self.contentView.addSubview(newContentView)
        NSLayoutConstraint.activate([
            newContentView.topAnchor.constraint(
                equalTo: self.contentView.topAnchor,
                constant: 2),
            newContentView.leadingAnchor.constraint(
                equalTo: self.contentView.leadingAnchor,
                constant: 16),
            newContentView.trailingAnchor.constraint(
                equalTo: self.contentView.trailingAnchor,
                constant: -16),
            newContentView.bottomAnchor.constraint(
                equalTo: self.contentView.bottomAnchor,
                constant: -2),
            newContentView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    func setupCellImage() {
        self.contentView.addSubview(cellImage)
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: newContentView.topAnchor, constant: 16),
            cellImage.leftAnchor.constraint(equalTo: newContentView.leftAnchor, constant: 16),
            cellImage.bottomAnchor.constraint(equalTo: newContentView.bottomAnchor, constant: -16),
            cellImage.heightAnchor.constraint(equalToConstant: 40),
            cellImage.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLabels() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: cellImage.topAnchor),
            
            descriptionLabel.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: newContentView.bottomAnchor, constant: -9)
        ])
    }
}
