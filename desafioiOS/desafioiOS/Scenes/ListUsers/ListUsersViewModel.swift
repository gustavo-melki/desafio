//
//  ListUsersViewModel.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation

class ListUsersViewModel {
  
    private let service: ListUserServiceProtocol
    
    init(service: ListUserServiceProtocol) {
      self.service = service
    }
    
    func loadContacts(_ completion: @escaping (Result<[User], Error>) -> Void) {
        
      service.fetchContacts { result in
        switch result {
          case .success (let users):
          completion(.success(users))
          case .failure (let error):
          completion(.failure(error))
        }
      }
    }
}
