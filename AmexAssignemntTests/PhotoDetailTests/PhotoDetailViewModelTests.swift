//
//  PhotoDetailViewModelTests.swift
//  AmexAssignemntTests
//
//  Created by Shruti Gupta on 06/02/24.
//

import XCTest
@testable import AmexAssignemnt

final class PhotoDetailViewModelTests: XCTestCase {
    
    private var photoList = [ImageModel]()
    private var mockService = MockImageService()
    private var detailViewModel: PhotoDetailViewModel?
    
    override func setUpWithError() throws {
        photoList = [
            ImageModel(format:"jpeg",width:5000,height:3333,filename:"0.jpeg",id:0,author:"Alejandro Escamilla",author_url:"https://unsplash.com/photos/yC-Yzbqy7PY",post_url:"https://unsplash.com/photos/yC-Yzbqy7PY"),
            ImageModel(format:"jpeg",width:3887,height:4899,filename:"23.jpeg",id:23,author:"Alejandro Escamilla",author_url:"https://unsplash.com/photos/8yqds_91OLw",post_url:"https://unsplash.com/photos/8yqds_91OLw")
        ]
    }
    
    
    func testImageDownloadSuccess() {
        // Given
        let image = UIImage(systemName: "star.fill")!
        let data = image.jpegData(compressionQuality: 0.5)
        mockService.mockData = .success(data!)
        detailViewModel = PhotoDetailViewModel(imageServices: mockService, imageModel: photoList[0])
        
        // When
        detailViewModel?.fetchImage()
        
        // Then
        XCTAssertEqual(detailViewModel!.imageData, data)
    }
    
    func testImageDownloadFailure() {
        // Given
        mockService.mockData = .failure(APIError.invalidData)
        detailViewModel = PhotoDetailViewModel(imageServices: mockService, imageModel: photoList[0])
        
        // When
        detailViewModel?.fetchImage()
        
        // Then
        XCTAssertNil(detailViewModel!.imageData)
    }
}
