//
//  NetworkFactory.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 19/02/23.
//

import Foundation

public enum NetworkFactory {
    case getListGames
    case getDetailGames(id: String)
}

extension NetworkFactory {

    public enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }

    // MARK: URL PATH API
    public var path: String {
        switch self {
        case .getListGames:
            return "games"
        case .getDetailGames(let id):
            return "games/\(id)"
        }
    }
    // MARK: URL QUERY PARAMS / URL PARAMS
    public var queryItems: [URLQueryItem] {
        switch self {
        case.getListGames, .getDetailGames:
            return []
        }
    }

    // MARK: BASE URL API
    public var baseApi: String? {
        switch self {
        case .getListGames, .getDetailGames:
            return "api.rawg.io"
        }
    }

    // MARK: HTTP METHOD
    public var method: RequestMethod {
        switch self {
        case .getListGames, .getDetailGames:
            return .get
        }
    }

    // MARK: BODY PARAMS API
    public var bodyParam: [String: Any]? {
        switch self {
        case .getListGames, .getDetailGames:
            return [:]
        }
    }

    // MARK: URL LINK
    public var url: URL {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        var finalParams: [URLQueryItem] = self.queryItems
        finalParams.append(URLQueryItem(name: "key", value: apiKey))
        components.path = "/api/" + path
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }

    // Header param
    public var headers: [String : String]? {
        switch self {
        case .getListGames, .getDetailGames:
            return getHeaders()
        }
    }

    fileprivate func getHeaders() -> [String: String] {
        let header = ["Content-Type": "application/json", "Accept" : "*/*"]
        return header
    }
}
