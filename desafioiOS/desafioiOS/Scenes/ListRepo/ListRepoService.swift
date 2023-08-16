//
//  ListRepoService.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation
import UIKit



protocol ListRepoServiceProtocol {
  func fetchRepos(completion: @escaping  (Result<[Repo], Error>) -> Void)
}

class ListRepoService: ListRepoServiceProtocol {
  
 
  func fetchRepos(completion: @escaping (Result<[Repo], Error>) -> Void) {
    
    guard let selectedUser = SelectedRepo.shared.selectedUser else { return }
    let apiURL = "https://api.github.com/users/\(selectedUser)/repos"
    
    guard let api = URL(string: apiURL) else {
      completion(.failure(ErrorTypes.errorURL))
      return
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: api) { (data, response, error) in
      guard let jsonData = data else {
        completion(.failure(ErrorTypes.errorData))
        return
      }
      
      guard let _ = response else {
        completion(.failure(ErrorTypes.errorResponse))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode([Repo].self, from: jsonData)
        
        completion(.success(decoded))
      } catch let error {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
}

