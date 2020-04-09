//
//  APIClient.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation
import Alamofire

public enum APIError: Error {
    case network
    case server
    case invalidJSON
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return "ネットワークの接続状態を確認してください。"
        case .server:
            return "サーバーと通信できません。"
        case .invalidJSON:
            return "JSONパース失敗。"
        }
    }
}

public enum HTTPMethod: String {
    case post
    case get
}

public protocol Request {

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var parameter: [String: Any] { get }
    var timeout: TimeInterval { get }
    var contentType: String { get }
    var accept: String { get }
    
    func makeRequest() -> URLRequest
}

public extension Request {
    
    var headerFields: [String: String] {
        return [:]
    }

    var timeout: TimeInterval {
        return 65
    }

    var contentType: String {
        return ""
    }

    var accept: String {
        return ""
    }

    func makeRequest() -> URLRequest {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url, timeoutInterval: timeout)
        urlRequest.httpMethod = method.rawValue
        if !parameter.isEmpty {
            if let request = try? URLEncoding.default.encode(urlRequest, with: parameter) {
                urlRequest = request
            }
        }
        headerFields.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if case .post = method {
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        urlRequest.setValue(accept, forHTTPHeaderField: "Accept")
        return urlRequest
    }
}

public protocol APIClient {
    func request(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void)
}

public final class DefaultAPIClient: APIClient {

    public static let shared = DefaultAPIClient()

    private init() {}

    public func request(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void) {
        AF.request(request.makeRequest()).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(response.response?.statusCode == nil ? .network : .server))
            }
        }
    }
}
