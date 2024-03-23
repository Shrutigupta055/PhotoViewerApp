//
//  PhotoDetailViewModel.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import Foundation

protocol PhotoDetailViewModelDelegate: AnyObject {
    func loadImage(with data: Data)
}

class PhotoDetailViewModel {
    weak var photoDetailDelegate: PhotoDetailViewModelDelegate?
    private let imageServices: ImageServices
    var imageModel: ImageModel
    var imageData :Data?
   
    init(imageServices: ImageServices, imageModel: ImageModel) {
        self.imageServices = imageServices
        self.imageModel = imageModel
    }
    
    func fetchImage() {
        imageServices.getImage(id: imageModel.id ?? 0, width: imageModel.width ?? 0, height: imageModel.height ?? 0) {
            result in
            switch result {
            case .success(let data):
                self.imageData = data
                self.photoDetailDelegate?.loadImage(with: data)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
