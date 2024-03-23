//
//  PhotoListViewModel.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import Foundation

protocol PhotoListViewModelDelegate:AnyObject {
    func loadListView(list: [ImageModel])
}

class PhotoListViewModel {
    weak var photoListDelegate: PhotoListViewModelDelegate?
    private let imageService: ImageServices
    var photoList: [ImageModel] = []
    
    init(imageService: ImageServices) {
        self.imageService = imageService
    }
    
    func fetchImageList() {
        imageService.fetchImageList() {
            result in
            switch result {
            case .success(let list):
                self.photoList = list
            case .failure(let error):
                print("Error: \(error)")
            }
            self.photoListDelegate?.loadListView(list:self.photoList)
        }
    }
    
    func fetchImage(index:Int, completion: @escaping (Data) -> Void) {
        guard let id = photoList[index].id else {
            return
        }
        imageService.getImage(id: id, width: Constraints.imageWidth, height: Constraints.imageHeight) {
            result in
            switch result {
            case .success(let data):
               completion(data)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func viewModelforPhotoDetail(index: Int) -> PhotoDetailViewModel? {
        guard index < photoList.count else { return nil }
        let detailViewModel = PhotoDetailViewModel(imageServices: self.imageService, imageModel: photoList[index])
        return detailViewModel
    }    
}

