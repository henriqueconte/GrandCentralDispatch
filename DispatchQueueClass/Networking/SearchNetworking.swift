//
//  ArtistNetworking.swift
//  DispatchQueueClass
//
//  Created by Henrique Figueiredo Conte on 27/08/19.
//  Copyright © 2019 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


class SearchNetworking {
    
    var apiKey: String = ""
    var heroName: String?
    
    init() {
        apiKey = "2374884709264264"
        
    }
    
    func getHeroRequest(heroName: String?, completion: @escaping (Data?, _ error: Error?) -> Void) {
        
        if heroName == nil || self.heroName == nil{
            self.heroName = "batman"
        } else {
            self.heroName = heroName
        }
        let heroURLString = "https://superheroapi.com/api/\(apiKey)/search/\(self.heroName!)/"
        guard let heroURL = URL(string: heroURLString) else {
            print("Could not find super hero")
            return
        }
        
        var request = URLRequest(url: heroURL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "")
                completion(data, error)
                return
            }

            completion(dataResponse, error)

        })
        dataTask.resume()
    }
    
    func getHeroImage(heroID: String, completion: @escaping (Data?, _ error: Error?) -> Void) {
        let heroURL = "https://superheroapi.com/api/\(apiKey)/\(heroID)/image/"
        guard let heroImageURL = URL(string: heroURL) else {
            print("invalid heroImageURL")
            return
        }
        var request = URLRequest(url: heroImageURL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "")
                completion(data, error)
                return
            }
            completion(dataResponse, error)
        })
        dataTask.resume()
    }
}


