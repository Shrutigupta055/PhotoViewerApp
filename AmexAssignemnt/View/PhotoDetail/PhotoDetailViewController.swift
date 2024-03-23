//
//  PhotoListViewController.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    private let viewModel: PhotoDetailViewModel?
    
    let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(photoDetailViewModel:PhotoDetailViewModel?) {
        self.viewModel = photoDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - setup UI
    private func setupUI() {
        self.view.addSubview(detailImageView)
        self.view.addSubview(authorLabel)
        self.view.backgroundColor = .white
        self.setImageViewConstraints()
        self.setAuthorLabelConstraints()
        self.view.showActivityIndicator()
        self.setupViewModel()
        authorLabel.text = self.viewModel?.imageModel.author ?? ""
        self.navigationItem.title = self.viewModel?.imageModel.filename ?? ""
    }
    
    private func setupViewModel() {
        self.viewModel?.photoDetailDelegate = self
        self.viewModel?.fetchImage()
    }
    
    func calculateDimention() -> CGFloat {
        guard let width = self.viewModel?.imageModel.width ,let height = self.viewModel?.imageModel.height else{ return 0.0 }
        let aspectRatio = CGFloat(width) / CGFloat(height)
        let maxWidth = UIScreen.main.bounds.width
        let dynamicHeight = maxWidth / aspectRatio
        return dynamicHeight
    }
    
    private func setImageViewConstraints(){
        let dynamicHeight = calculateDimention()
        NSLayoutConstraint.activate([
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: dynamicHeight),
        ])
        if self.viewModel?.imageModel.height ?? 0 < self.viewModel?.imageModel.width ?? 0{
            NSLayoutConstraint.activate([
                detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                detailImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                detailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ])
        }
    }
    
    private func setAuthorLabelConstraints(){
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: Constraints.padding),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.padding),
        ])
    }
}

//MARK: -PhotoDetailViewModelDelegate
extension PhotoDetailViewController : PhotoDetailViewModelDelegate{
    func loadImage(with data: Data) {
        DispatchQueue.main.async {
            self.detailImageView.image = UIImage(data: data)
            self.view.hideActivityIndicator()
        }
    }
}
