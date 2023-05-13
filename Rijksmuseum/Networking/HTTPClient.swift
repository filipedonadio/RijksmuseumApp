//
//  HTTPClient.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 13/05/2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, parameters: [URLQueryItem]?, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, parameters: [URLQueryItem]? = nil, responseModel: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL.appending(endpoint.path)) else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        if let parameters {
            request.url?.append(queryItems: parameters)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw RequestError.decode
                }
                
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw error
        }
    }
}
