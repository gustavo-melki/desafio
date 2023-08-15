//
//  User.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation

struct User: Decodable {
    let login: String
    let id: Int
    let avatar_url: String
}
