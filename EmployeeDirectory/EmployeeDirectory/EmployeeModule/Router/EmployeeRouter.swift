//
//  EmployeeRouter.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import Foundation
class EmployeeRouter{
    func getEmployeeList(withCompletion completion: @escaping (Result<[EmployeeResponse?], NetworkError>)->()){
        guard let url = URL(string:EmployeeApi.BASE_URL+EmployeeApi.PATH) else{fatalError("URL Error")}
        var resource = Resources<[EmployeeResponse?]>(url: url)
        resource.httpMethod = .get
        WebService().load(resource: resource) { result in
            switch result{
            case .success(let response):
            debugPrint(response.map({$0?.phone}))
                DispatchQueue.main.async {
                    completion(.success(response))
                }
                
            case .failure(let error):
                debugPrint(error.self)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
    }
}
