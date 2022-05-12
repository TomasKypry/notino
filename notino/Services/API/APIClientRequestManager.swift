//
//  APIClientRequestManager.swift
//  notino
//
//  Created by Tomáš Kyprý on 12.05.2022.
//

import Foundation

class APIClientRequestManager {
    typealias APIRequestCompletion<T> = (Result<T, APIError>) -> Void

    private(set) var enviroment: APIEnviroment

    let session: URLSession

    init(enviroment: APIEnviroment, session: URLSession = .shared) {
        self.enviroment = enviroment
        self.session = session
    }

    func createURLRequest(from request: Request) throws -> URLRequest {
        // Create URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = enviroment.host
        components.path = "/" + request.path

        guard let url = components.url else {
            throw APIError(.unableToCreateRequest("Could not create URL from components"))
        }

        // Create URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        return urlRequest
    }

    func sendRequest<T: Response>(_ request: URLRequest, completion: @escaping APIRequestCompletion<T>) {
        let task = session.dataTask(with: request) { data, response, error in
            // get response
            guard let response = response as? HTTPURLResponse else {
                let reason = error?.localizedDescription ?? "Unknown reason"
                let errorString = "Could not get HTTPURLResponse: \(reason)"
                let error = APIError(.communicationError(errorString))
                completion(.failure(error))
                return
            }

            // get data
            guard let data = data else {
                let reason = error?.localizedDescription ?? "unknown"
                let errorString = "Nil data from server: \(reason)"
                let error = APIError(.communicationError(errorString))
                completion(.failure(error))
                return
            }

            // check status code
            guard (200...299).contains(response.statusCode) else {
                let reason = error?.localizedDescription ?? "unknown"
                let errorString = "Invalid status code (\(response.statusCode): \(reason)"
                let error = APIError(.communicationError(errorString))
                completion(.failure(error))
                return
            }

            // decode response
            do {
                let decoded = try self.decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                let reason = "\(error)"
                let apiError = APIError(.unableToParseResponse(reason))
                completion(.failure(apiError))
            }
        }
        task.resume()
    }

    private func decode<T: Decodable>(_ type: T.Type, from response: Data) throws -> T {
        let decoded = try JSONDecoder().decode(T.self, from: response)
        return decoded
    }
}
