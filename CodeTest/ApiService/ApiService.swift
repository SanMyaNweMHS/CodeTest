//
//  ApiService.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    private init() {}
    
    func fetchData<T>(
        url: String,
        value: T.Type,
        com: @escaping (Result<T, ApiServiceError>)->Void
    ) where T: Codable {
        
//        let headers = ["Authorization" : "Bearer " + Api.ACCESS_TOKEN]
        
        let params = ["fbclid": Api.API_KEY]
        var urlComponent = URLComponents(string: url)
        var queryItems = [URLQueryItem]()
        for param in params {
            queryItems.append(URLQueryItem(name: param.key, value: param.value))
        }
        urlComponent?.queryItems = queryItems
        guard let url = urlComponent?.url else { return }
        
        let requestUrl = URLRequest(url: url)
//        requestUrl.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: requestUrl) { (data, response, error) in
            
            if let _ = error { com(.failure(.unknown)) }
            
            let urlResponse = response as! HTTPURLResponse
            
            let statusCode = urlResponse.statusCode
            
            if 200...299 ~= statusCode {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let data = data else { return }
                
                do {
                    let result = try decoder.decode(T.self, from: data)
                    com(.success(result))
                } catch {
                    com(.failure(.decodingFail))
                }
            } else if 300...500 ~= statusCode {
                com(.failure(.clientFail))
            } else {
                com(.failure(.serverDown))
            }
            
        }
        
        task.resume()
            
    }
}
