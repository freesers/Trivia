//
//  ResultController.swift
//  
//
//  Created by Sander de Vries on 14/12/2018.
//

import Foundation

struct ResultController {
    
    static let shared = ResultController()
    
    func submitScore(result: Result) {
        let listUrl = URL(string: "https://ide50-freesers.cs50.io:8080/list")!
        var request = URLRequest(url: listUrl)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = result.description
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(data)
            }
        }
        task.resume()
    }
    
    func fetchScores(completion: @escaping ([ServerResult]?) -> Void) {
        let ScoreListURL = URL(string: "https://ide50-freesers.cs50.io:8080/list")!
        
        let decoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: ScoreListURL) { (data, response, error) in
            if let data = data,
                let scores = try? decoder.decode(ServerResults.self, from: data) {
                completion(scores)
            }
        }
        task.resume()
    }
    
}
