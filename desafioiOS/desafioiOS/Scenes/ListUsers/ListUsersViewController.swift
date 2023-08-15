//
//  ListUsersViewController.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import UIKit

class ListUserViewController: UIViewController {
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
        tableView.register(UserCell.self, forCellReuseIdentifier: String(describing: UserCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var users = [User]()
    var viewModel: ListUsersViewModel!
    
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
        viewModel = ListUsersViewModel(service: ListUserService())
        configureViews()
        
        navigationController?.title = "Lista de Usuários"
        
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
                case .success (let users):
                 self.users = users
                 self.tableView.reloadData()
                 self.activity.stopAnimating()
                
                case .failure (let error):
                self.showAlert(title: "Ops, ocorreu um erro", message: error.localizedDescription)
              }
            }
        }
    }
}

extension ListUserViewController : UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCell.self), for: indexPath) as? UserCell else {
          return UITableViewCell()
      }
      
      let user = users[indexPath.row]
      cell.fullnameLabel.text = user.login
      
      if let urlPhoto = URL(string: user.avatar_url) {
          do {
              let data = try Data(contentsOf: urlPhoto)
              let image = UIImage(data: data)
              cell.userImage.image = image
          } catch _ {}
      }

      return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    showAlert(title: "Atenção", message: "oi")
  }
  
}
