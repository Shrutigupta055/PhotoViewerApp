//
//  ImageModel.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import Foundation

struct ImageModel : Decodable {
    let format : String?
    let width : Int?
    let height : Int?
    let filename : String?
    let id : Int?
    let author : String?
    let author_url : String?
    let post_url : String?
}
