//
//  UIButton+Extension.swift
//  Shambaboocly
//
//  Created by Arseniy Apollonov on 04.04.2024.
//

import UIKit

extension UIButton {
    func createButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "CreateButtonColor")
        button.layer.cornerRadius = 4
        button.setTitle("СОТВОРИТЬ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        return button
    }
}
