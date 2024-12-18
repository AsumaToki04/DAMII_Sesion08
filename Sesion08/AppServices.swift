//
//  AppServices.swift
//  Sesion08
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import Alamofire

struct AppServices {
    static let shared = AppServices()
    private let baseUrl = "https://2782e730-dbaf-414a-8426-bc759689516f.mock.pstmn.io"
    private var getPriorities: String
    private var getTags: String
    private var getCategories: String
    
    private init() {
        getTags = "\(baseUrl)/getTags"
        getPriorities = "\(baseUrl)/getPriorities"
        getCategories = "\(baseUrl)/getAllCategories"
    }
    
    func getListTags() async throws -> [Tag] {
        try await withCheckedThrowingContinuation { continuation in
            AF.request(getTags)
                .validate() //validando response
                .responseDecodable(of: [Tag].self) { resp in //deserializar items
                    switch resp.result {
                    case .success(let items):
                        continuation.resume(returning: items)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getListPriorities() async throws -> [Priority] {
        try await withCheckedThrowingContinuation { continuation in
            AF.request(getPriorities)
                .validate() //validando response
                .responseDecodable(of: [Priority].self) { resp in //deserializar items
                    switch resp.result {
                    case .success(let items):
                        continuation.resume(returning: items)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getListCategories() async throws -> [Category] {
        try await withCheckedThrowingContinuation { continuation in
            AF.request(getCategories)
                .validate() //validando response
                .responseDecodable(of: [Category].self) { resp in //deserializar items
                    switch resp.result {
                    case .success(let items):
                        continuation.resume(returning: items)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
