//
//  NetworkManager.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import Foundation

protocol ImageServices {
    func fetchImageList(completion: @escaping (Result<[ImageModel], Error>) -> Void)
    func getImage(id: Int, width: Int, height: Int, _ completion: @escaping (Result<Data, Error>) -> Void)
}

class ImageService : ImageServices{
    private let imageCache = NSCache<NSString, NSData>()
    
    func fetchImageList(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        guard let url = URL(string:ApiEndPoints.getPhotosList.endPoint) else {
            return completion(.failure(APIError.invalidURL))
        }
        URLSession.shared.dataTask(with: url) { data, _ , error in
            guard error == nil else {
                completion(.failure(APIError.networkError(description: error!.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            do {
                let images = try JSONDecoder().decode([ImageModel].self, from: data)
                completion(.success(images))
            } catch {
                completion(.failure(APIError.invalidData))
            }
        }.resume()
    }
    
    func getImage(id: Int, width: Int, height: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = ApiEndPoints.getPhotosDetail(id: id, width: width, height: height).endPoint
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        // Check if the image is already in the cache
        if let cachedData = imageCache.object(forKey: urlString as NSString) as Data? {
            completion(.success(cachedData))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.invalidData))
                return
            }
            // Store the data in the cache
            self.imageCache.setObject(data as NSData, forKey: urlString as NSString)
            completion(.success(data))
        }
        dataTask.resume()
    }
}
