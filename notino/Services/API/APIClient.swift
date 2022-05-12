//
//  APIClient.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

/// API Client class for handling network requests
class APIClient {
    private let requestManager: APIClientRequestManager

    typealias Completion<T: Decodable> = APIClientRequestManager.APIRequestCompletion<T>

    static let shared: APIClient = {
        let manager = APIClientRequestManager(enviroment: .development)
        return APIClient(requestManager: manager)
    }()

    init(requestManager: APIClientRequestManager) {
        self.requestManager = requestManager
    }

    func sendRequest<Req: Request, Res: Response>(_ request: Req, completion: @escaping Completion<Res>) {
        DispatchQueue.global().async {
            do {
                let urlRequest = try self.requestManager.createURLRequest(from: request)
                self.requestManager.sendRequest(urlRequest, completion: { result in
                    DispatchQueue.main.async {
                        completion(result)
                    }
                })
            } catch let error as APIError {
                completion(.failure(error))
            } catch {}
        }
    }
}
