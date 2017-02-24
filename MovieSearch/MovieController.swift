//
//  MovieController.swift
//  MovieSearch
//
//  Created by Clay Mills on 2/24/17.
//  Copyright © 2017 Clay Mills. All rights reserved.
//

import Foundation
//Set up this file Second after model file. set baseURL func for fetch with @escaping, use API key for parameters, networkcontrollerPerformRequest(bigone/wholeenchilada) for .Get, set up the error and data, json serialize, dont forget completions

class MovieController {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie?")
    static func fetchMovieWith(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        guard let url = baseURL else { completion([])
            return}
        let urlParameter = ["api_key":"e35d10ae7d93f4bc00e4674b8bdd240b", "query":searchTerm]
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: urlParameter, body: nil) { (data, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else {NSLog("No data to return")
                    completion([])
                    return
            }
            
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {NSLog("can't serialize JSON \(responseDataString)")
                completion([])
                return
            }
            guard let movieArray = jsonDictionary?["results"] as? [[String:Any]] else {NSLog("can't serialize JSON \(responseDataString)")
                completion([])
                return
            }
            let movies = movieArray.flatMap({Movie(dictionary: $0)})
            completion(movies)
            
        }
    }
}
