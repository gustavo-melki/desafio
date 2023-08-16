//
//  ListRepoViewController.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation
import UIKit

class ListRepoViewController: UIViewController {
  
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(RepoCell.self, forCellReuseIdentifier: String(describing: RepoCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var repos = [Repo]()
    var viewModel: ListRepoViewModel!
    var selectedUser: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
  
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListRepoViewModel(service: ListRepoService())
        configureViews()
        
        navigationController?.title = "Lista de Repositorios"
        
        loadData()
    }
  
  
  private func showAlert(title: String, message: String, btnTitle: String = "OK") {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
      self.present(alert, animated: true)
    
  }
    
    func configureViews() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    
    func loadData() {
        viewModel.loadContacts { result in
            DispatchQueue.main.async {
              
              switch result {
                case .success (let repos):
                 self.repos = repos
                 self.tableView.reloadData()
                 self.activity.stopAnimating()
                
                case .failure (let error):
                self.showAlert(title: "Ops, ocorreu um erro", message: error.localizedDescription)
              }
            }
        }
    }
}

extension ListRepoViewController : UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return repos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoCell.self), for: indexPath) as? RepoCell else {
          return UITableViewCell()
      }
      
      let repo = repos[indexPath.row]
      cell.fullnameLabel.text = repo.name
      return cell
  }
  
  
}
