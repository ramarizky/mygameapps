//
//  NetworkError.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 19/02/23.
//

import Foundation

public enum NetworkError: Error, LocalizedError {

    case middlewareError(code: Int, message: String?)
    var localizedDescription: String {
        switch self {
        case .middlewareError(_, let message):
            return message ?? ""
        }
    }
}

public struct ErrorHandling: Decodable, Error, LocalizedError {
    let success: Bool
    let data: DataClass
    let message: String
    let code: Int
    let codeName: String

    enum CodingKeys: String, CodingKey {
        case success, data, message, code
        case codeName = "code_name"
    }
}

// MARK: - DataClass
public struct DataClass: Decodable {
}
