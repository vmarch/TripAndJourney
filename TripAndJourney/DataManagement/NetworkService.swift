//
//  NetworkService.swift
//  TripAndJourney
//
//  Created by devtolife on 15.09.21.
//

import Foundation
class NetworkService{
    class func connectToServer(bodyDataText: String, completion: @escaping (Data?, Error?) -> ()){
        
        let url = URL(string: (ConectData().testIsLoggedEndpoint))!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let bodyData: String = bodyDataText
        request.httpBody = bodyData.data(using: .utf8)
        
        let dataTask = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            completion(data,nil)
            
        }
        dataTask.resume()
    }
}
