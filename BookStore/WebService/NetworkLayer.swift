//
//  WebService.swift
//  BookStore
//
//  Created by Sanjay Mali on 29/04/21.
//
import Foundation
protocol NetworkLayerProtocol {
    func post(_ api: String,parameters:[String:Any], completion:@escaping (Result<Data, Error>) -> Void)
}
class NetworkLayer: NetworkLayerProtocol {
    var urlString = "http://skunkworks.ignitesol.com:8000"
    /// Perform POST request
    /// - Parameters:
    ///   - url: Remote API endpoint
    ///   - parameters: Request's JSON data
    ///   - completion: Completion handler that either return response's JSON data or error
    //    http://skunkworks.ignitesol.com:8000/books
    static let shared = NetworkLayer()
    
    private init(){
        
    }
    func post(_ api:String, parameters: [String:Any], completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string:urlString + api)!
        var request = URLRequest(url:url)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print(error.localizedDescription)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                print("HTTP Request Failed \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
