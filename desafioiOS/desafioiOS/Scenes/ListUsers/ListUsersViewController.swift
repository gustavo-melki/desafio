//
//  ListUsersViewController.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import UIKit

class ListUserViewController: UIViewController  {
  
  @IBOutlet weak var tableview: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  
  var users = [User]()
  var viewModel: ListUsersViewModel!
  
  var filtredData = [User]()
  var isSearching = false


  lazy var activity: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.hidesWhenStopped = true
    activity.startAnimating()
    return activity
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = ListUsersViewModel(service: ListUserService())
    loadData()
  }
  
  private func showAlert(title: String, message: String, btnTitle: String = "OK") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: btnTitle, style: .default, handler: nil))
    self.present(alert, animated: true)
    
  }
  
  
  func loadData() {
    viewModel.loadContacts { result in
      DispatchQueue.main.async {
        
        switch result {
        case .success (let users):
          self.users = users
          self.tableview.reloadData()
          self.activity.stopAnimating()
          
        case .failure (let error):
          self.showAlert(title: "Ops, ocorreu um erro", message: error.localizedDescription)
        }
      }
    }
  }
  
}

extension ListUserViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     if isSearching {
       return filtredData.count
     } else {
       return users.count
     }
    
  }
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCell.self), for: indexPath) as? UserCell else {
      return UITableViewCell()
    }
     
     if isSearching {
       let user = filtredData[indexPath.row]
       cell.fullnameLabel.text = user.login
       
       if let urlPhoto = URL(string: user.avatar_url) {
         do {
           let data = try Data(contentsOf: urlPhoto)
           let image = UIImage(data: data)
           cell.userImage.image = image
         } catch _ {}
       }
      
     } else {
       let user = users[indexPath.row]
       cell.fullnameLabel.text = user.login
       
       if let urlPhoto = URL(string: user.avatar_url) {
         do {
           let data = try Data(contentsOf: urlPhoto)
           let image = UIImage(data: data)
           cell.userImage.image = image
         } catch _ {}
       }
     }
     return cell
  }
  
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "main", bundle:nil)
    let listRepoViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! ListRepoViewController
    SelectedRepo.shared.selectedUser = users[indexPath.row].login
    self.present(listRepoViewController, animated:true, completion:nil)
  }
}

extension ListUserViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    let arrayData = users.map {$0.login}
    let filtredDataString = arrayData.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
    let filtredDataObj = users.filter({filtredDataString.contains($0.login)})
    
    
    filtredData = filtredDataObj
    isSearching = true
    tableview.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    searchBar.text = ""
    tableview.reloadData()
  }
}
