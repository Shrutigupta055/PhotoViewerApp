//
//  PhotoListViewTests.swift
//  AmexAssignemntTests
//
//  Created by Shruti Gupta on 01/02/24.
//

import XCTest
@testable import AmexAssignemnt

final class PhotoListViewModelTests: XCTestCase {
    
    private var mockImageService : MockImageService!
    private var photoListViewModel : PhotoListViewModel!
    private var photoList = [ImageModel]()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockImageService = MockImageService()
        photoListViewModel = PhotoListViewModel(imageService: mockImageService)
        photoList = [
            ImageModel(format:"jpeg",width:5000,height:3333,filename:"0.jpeg",id:0,author:"Alejandro Escamilla",author_url:"",post_url:""),
            ImageModel(format:"jpeg",width:3887,height:4899,filename:"23.jpeg",id:23,author:"Alejandro Escamilla",author_url:"",post_url:"")
        ]
    }
    
    override func tearDown() {
        mockImageService = nil
        photoListViewModel = nil
        super.tearDown()
    }
    
    func testFetchImageListSuccess() {
        //given
        mockImageService.mockResults = .success(photoList)
        
        //when
        photoListViewModel.fetchImageList()
        
        //then
        XCTAssertEqual(photoListViewModel.photoList.count, 2)
        XCTAssertEqual(self.photoListViewModel.photoList[0].filename, "0.jpeg")
        XCTAssertEqual(self.photoListViewModel.photoList[1].filename, "23.jpeg")
    }
    
    func testFetchImageListFailure() {
        //given
        mockImageService.mockResults = .failure(APIError.invalidURL)
        
        //when
        photoListViewModel.fetchImageList()
        
        //then
        XCTAssertTrue(photoListViewModel.photoList.isEmpty)
    }
    
    func testFetchImage() {
        // Given
        let image = UIImage(systemName: "star.fill")!
        let data = image.jpegData(compressionQuality: 0.5)
        mockImageService.mockData = .success(data!)
        photoListViewModel.photoList = photoList
        let expectation = XCTestExpectation(description: "Fetch image completion")
        
        // When
        photoListViewModel.fetchImage(index: 0) { imageData in
            // Then
            XCTAssertNotNil(imageData)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

