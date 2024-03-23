//
//  MockServices.swift
//  AmexAssignemntTests
//
//  Created by Shruti Gupta on 04/02/24.
//

import Foundation
import UIKit
@testable import AmexAssignemnt

class MockImageService: ImageServices {
    
    var mockResults: Result<[ImageModel], Error>?
    var mockData: Result<Data, Error>?
    
    func fetchImageList(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        if let result = mockResults {
            completion(result)
        }
        else {
            completion(.failure(APIError.invalidURL))
        }
    }
    
    func getImage(id: Int, width: Int, height: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        if let result = mockData {
            completion(result)
        }
        else {
            completion(.failure(APIError.invalidData))
        }
    }
}

