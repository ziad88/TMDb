//
//  WebServiceClass.swift
//  banquemisr.challenge05
//
//  Created by mac on 28/08/2024.
//

import Foundation

class WebServiceClass : NSObject {
    
    class func getRequset(urlString: String,  parameters: [String : Any]? = nil, Success : @escaping (DataResponse<Any>) -> ()) {
        
        NetworkManager.sharedInstance.getRequest(parameter: parameters, urlString: urlString, success: { (response:Any!) in
            var dataResponse: DataResponse<Any> = mapAnyToDataResponse(from: response!)!
                if let data = dataResponse.data {
                    print("Data: \(data)")
                } else if let error = dataResponse.error {
                    print("Error: \(error)")
                }
            dataResponse.isSuccess = true
            Success(dataResponse)
            
        }) { (response:Any!,errorMessage) in
            var dataResponse: DataResponse<Any> = mapAnyToDataResponse(from: response!)!
                if let data = dataResponse.data {
                    print("Data: \(data)")
                } else if let error = dataResponse.error {
                    print("Error: \(error)")
                }
            dataResponse.isSuccess = false
            Success(dataResponse)
        }
    }
}

func mapAnyToDataResponse<T>(from any: Any) -> DataResponse<T>? {
    if let dict = any as? [String: Any] {
        let data = dict as? T
        let error = dict["error"] as? Error
        
        return DataResponse<T>(
            data: data,
            error: error
        )
    }
    
    return nil
}

func getObjectViaCodable<T : Codable>(dict : [String : Any]) -> T? {
    if let jsonData = try?  JSONSerialization.data(withJSONObject: dict,options: .prettyPrinted){
        if let res = try? JSONDecoder().decode(T.self, from: jsonData){
            return res
        } else {
            return nil
        }
    } else {
        return nil
    }
}
