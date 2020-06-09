//
//  WebService.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import Foundation
enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

enum NetworkError : Error{
    case decodingError
    case urlResponseError(code:Int,msg:String)
    case domainError
    case urlError
    case emptyData
}


class WebService {
    func load<T>(resource: Resources<T>, withCompletion completion: @escaping (Result<T, NetworkError>)->()){
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (dataRes, response, error) in
            
            guard let dataRes = dataRes , let response = response as? HTTPURLResponse, error == nil else{
                completion(.failure(.domainError))
                return
            }
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.urlResponseError(code: response.statusCode, msg: "Response Status is not 200")))
                    return
            }
            debugPrint("\n\n Response: \t\t  \(String(bytes: dataRes, encoding: String.Encoding.utf8) ?? "Content-") \n\n")
            let result = try? JSONDecoder().decode(T.self, from: dataRes)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }else{
                
                completion(.failure(.decodingError))
            }
            }.resume()
    }
}
