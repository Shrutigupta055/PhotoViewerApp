//
//  PhotoListViewController.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import UIKit

class PhotoListViewController: UIViewController{
    private let viewModel = PhotoListViewModel(imageService: ImageService())
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PhotoListTableViewCell.self, forCellReuseIdentifier: Identifier.cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        self.viewModel.fetchImageList()
        setupTableView()
    }
    
    //MARK: - setUp UI
   private func setupView() {
        self.view.addSubview(tableView)
        self.navigationItem.title = "Photo List"
        viewModel.photoListDelegate = self
        self.view.showActivityIndicator()
    }
    
    private func setupTableView() {
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - PhotoListViewModelDelegate
extension PhotoListViewController: PhotoListViewModelDelegate {
    func loadListView(list: [ImageModel]) {
        self.viewModel.photoList = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.hideActivityIndicator()
        }
    }
}

// MARK: - UITableViewDataSource
extension PhotoListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cellIdentifier, for: indexPath) as? PhotoListTableViewCell else {
                return UITableViewCell()
            }
        let model = self.viewModel.photoList[indexPath.row]
        cell.filenameLabel.text = model.filename
        
        viewModel.fetchImage(index: indexPath.row){ data in
            DispatchQueue.main.async{
                cell.photoListImageView.image = UIImage(data: data)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PhotoListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewModel =  self.viewModel.viewModelforPhotoDetail(index: indexPath.row) else { return }
        let detailViewController = PhotoDetailViewController(photoDetailViewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}



