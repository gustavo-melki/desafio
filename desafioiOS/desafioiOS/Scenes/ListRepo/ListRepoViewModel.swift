//
//  ListRepoViewModel.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation

class ListRepoViewModel {
  
    private let service: ListRepoServiceProtocol
    
    init(service: ListRepoServiceProtocol) {
      self.service = service
    }
    
    func loadContacts(_ completion: @escaping (Result<[Repo], Error>) -> Void) {
        
      service.fetchRepos { result in
        switch result {
          case .success (let repos):
          completion(.success(repos))
          case .failure (let error):
          completion(.failure(error))
        }
      }
    }
}
