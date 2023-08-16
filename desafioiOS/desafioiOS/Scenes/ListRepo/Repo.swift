//
//  Repo.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation

struct Repo: Decodable {
    let name: String
}

class SelectedRepo{
    static let shared = SelectedRepo()
    var selectedUser: String?
}

