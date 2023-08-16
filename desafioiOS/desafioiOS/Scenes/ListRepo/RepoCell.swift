//
//  RepoCell.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import Foundation
import UIKit

class RepoCell: UITableViewCell {
  lazy var fullnameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    configureViews()
  }
  
  func configureViews() {
    contentView.addSubview(fullnameLabel)
    
    fullnameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
    fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
}
