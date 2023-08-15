//
//  UserCell.swift
//  desafioiOS
//
//  Created by Gustavo Melki Leal on 15/08/23.
//
import UIKit

class UserCell: UITableViewCell {
  lazy var userImage: UIImageView = {
    let imgView = UIImageView()
    imgView.translatesAutoresizingMaskIntoConstraints = false
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    return imgView
  }()
  
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
    contentView.addSubview(userImage)
    contentView.addSubview(fullnameLabel)
    
    userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    userImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    userImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    userImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
    
    fullnameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16).isActive = true
    fullnameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
    fullnameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    fullnameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
}
