//
//  APIERROR.swift
//  AmexAssignemnt
//
//  Created by Shruti Gupta on 06/02/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case networkError(description: String)
}
