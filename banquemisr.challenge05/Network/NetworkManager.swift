//
//  NetworkManager.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    func getRequest(parameter: [String: Any]? = nil,
                    urlString: String,
                    success: @escaping (Any?) -> Void,
                    failed: @escaping (Any?, _ errorMessage: String?) -> Void) {
                    
            guard var urlComponents = URLComponents(string: urlString) else {
                failed(nil, "Invalid URL")
                return
            }
            
            // Handle query parameters if present
            if let parameter = parameter {
                urlComponents.queryItems = parameter.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
            
            guard let url = urlComponents.url else {
                failed(nil, "Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmI4YTU4MjIxYTNmMmEyNjhhODQyMGZjMTU5MTllOCIsIm5iZiI6MTcyNDg2OTkyOS4wMjY5MjUsInN1YiI6IjY2Y2Y2YmI1MzRmOWM4NTE1OGE0NzEyNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.coES2_UQi9J5OwKA6Z53en5hlk1HbitqqzgiOeca7Ec"]
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    print("url : ", urlString)
                    
                    if let error = error as NSError? {
                        print("ErrorCode \(error.code) \n \(error.localizedDescription)")
                        
                        if error.code == -1005 || error.code == -1004 {
                            failed(nil, "Could not connect to the server.")
                        } else {
                            failed(nil, "Could not connect to the server.")
                        }
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        failed(nil, "Invalid response from server.")
                        return
                    }
                    
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print("Type of anyObject: \(type(of: data))")
                            success(json)
                        } catch {
                            failed(nil, "Failed to parse response.")
                        }
                    } else {
                        failed(nil, "No data received.")
                    }
                }
            }
            
            task.resume()
    }
    
}
