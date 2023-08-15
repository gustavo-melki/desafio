//
//  ListUsersService.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation

private let apiURL = "https://api.github.com/users"

protocol ListUserServiceProtocol {
  func fetchContacts(completion: @escaping  (Result<[User], Error>) -> Void)
}

class ListUserService: ListUserServiceProtocol {
  
  func fetchContacts(completion: @escaping (Result<[User], Error>) -> Void) {
    
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
        let decoded = try decoder.decode([User].self, from: jsonData)
        
        completion(.success(decoded))
      } catch let error {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
}

enum ErrorTypes: Error {
  case errorURL
  case errorResponse
  case errorData
}
