//
//  ViewController.swift
//  Shambaboocly
//
//  Created by Arseniy Apollonov on 04.04.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel = MainViewModel()
    
    private var tableArray: [CellState] = [] {
        didSet {
            mainTableView.reloadData()
            scrollToBottom()
        }
    }

    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let createButton = UIButton().createButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup background
        setupViewBackground()
        // setup tableView
        setupMainTableView()
        mainTableView.dataSource = self
        mainTableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        // setup Navigation Bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor(named: "BGColor1")
        self.navigationItem.standardAppearance = navBarAppearance
        navigationItem.title = "Клеточное наполнение"
        // setup createButton
        setupCreateButton()
        createButton.addTarget(self,
                               action: #selector(didTapCreateButton),
                               for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 54, right: 0)
    }
    
    @objc
    private func didTapCreateButton() {
        viewModel.addNewCell()
        tableArray = viewModel.cellsArray
    }
    
    // add gradient background
    private func setupViewBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(named: "BGColor1")?.cgColor ?? UIColor.white.cgColor,
                           UIColor(named: "BGColor2")?.cgColor ?? UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // automatic scroll to bottom of table view
    private func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.tableArray.count-1, section: 0)
            self.mainTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

// MARK: - TableView Data Source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(
            withIdentifier: MainCell.identifier,
            for: indexPath) as? MainCell else {
            return MainCell()
        }
        cell.selectionStyle = .none
        let state = tableArray[indexPath.row]
        cell.configureMainCell(
            title: state.getTitle(),
            desctription: state.getDescription(),
            imageName: state.getImageName())
        return cell
    }
}
// MARK: - Layouts
private extension MainViewController {
    func setupMainTableView() {
        view.addSubview(mainTableView)
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    func setupCreateButton() {
        mainTableView.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 14),
            createButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -14),
            createButton.heightAnchor.constraint(equalToConstant: 36),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
