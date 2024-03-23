//
//  PhotoDetailViewControllerTests.swift
//  AmexAssignemntTests
//
//  Created by Shruti Gupta on 01/02/24.
//

import XCTest
@testable import AmexAssignemnt

final class PhotoDetailViewControllerTests: XCTestCase {
    
    private var photoList = [ImageModel]()
    private var mockService = MockImageService()
    private var detailViewModel: PhotoDetailViewModel?
    private var detailViewController: PhotoDetailViewController?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        photoList = [
            ImageModel(format:"jpeg",width:5000,height:3333,filename:"0.jpeg",id:0,author:"Alejandro Escamilla",author_url:"https://unsplash.com/photos/yC-Yzbqy7PY",post_url:"https://unsplash.com/photos/yC-Yzbqy7PY"),
            ImageModel(format:"jpeg",width:3887,height:4899,filename:"23.jpeg",id:23,author:"Alejandro Escamilla",author_url:"https://unsplash.com/photos/8yqds_91OLw",post_url:"https://unsplash.com/photos/8yqds_91OLw")
        ]
    }
    
   private func testLandscapeImage() {
        createDetailViewController(for: 0)
        let _ = detailViewController!.calculateDimention()
        let size = detailViewController!.detailImageView.frame.size
        let imageViewCenterY = detailViewController!.detailImageView.frame.midY
        let viewCenterY = detailViewController!.view.frame.midY
        
        XCTAssertEqual(imageViewCenterY, viewCenterY)
        XCTAssertTrue(size.width > size.height)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width)
    }
    
    private func testPortraitImage() {
        createDetailViewController(for: 1)
        let _ = detailViewController!.calculateDimention()
        let size = detailViewController!.detailImageView.frame.size
        let imageViewCenterY = detailViewController!.detailImageView.frame.midY
        let viewCenterY = detailViewController!.view.frame.midY
        
        XCTAssertNotEqual(imageViewCenterY, viewCenterY)
        XCTAssertTrue(size.width < size.height)
        XCTAssertEqual(size.width, UIScreen.main.bounds.width)
    }
    
    private func createDetailViewController(for index: Int) {
        let model = photoList[index]
        detailViewModel = PhotoDetailViewModel(imageServices: mockService, imageModel: model)
        detailViewController = PhotoDetailViewController(photoDetailViewModel: detailViewModel)
        detailViewController?.viewWillAppear(false)
        detailViewController?.view.layoutIfNeeded()
    }
}
