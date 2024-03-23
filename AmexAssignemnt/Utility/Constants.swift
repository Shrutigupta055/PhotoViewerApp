//
//  ApiConstants.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 01/02/24.
//

import Foundation

let development = "https://picsum.photos/"
let production = ""

enum NetworkEnvironment {
    case development
    case production
}

var selectedEnvironment : NetworkEnvironment{
    return .development
}

var baseURL : String{
    switch selectedEnvironment{
    case .development :
        return development
    case .production :
        return production
    }
}

enum ApiEndPoints{
    case getPhotosList
    case getPhotosDetail(id:Int,width:Int,height:Int)
    
    var endPoint : String{
        switch self {
        case .getPhotosList :
            return baseURL + "list"
        case let .getPhotosDetail(id,width,height) :
            return baseURL + "\(width)/\(height)?image=\(id)"
        }
    }
}

struct Constraints{
    static let imageWidth = 120
    static let imageHeight = 120
    static let tableViewRowHeight = 120.0
    static let padding : CGFloat = 10.0
}

struct Identifier{
    static let cellIdentifier = "PhotoListTableViewCell"
}
