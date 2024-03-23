//
//  PhotoListTableViewCell.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {
    let photoListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let filenameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(photoListImageView)
        addSubview(filenameLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            // Photo List Image View
            photoListImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding),
            photoListImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constraints.padding),
            photoListImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constraints.tableViewRowHeight),
            photoListImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding),

            // Filename Label
            filenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constraints.padding),
            filenameLabel.leadingAnchor.constraint(equalTo: photoListImageView.trailingAnchor, constant: Constraints.padding),
            filenameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constraints.padding),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
