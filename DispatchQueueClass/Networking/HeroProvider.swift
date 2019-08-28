//
//  HeroProvider.swift
//  DispatchQueueClass
//
//  Created by Henrique Figueiredo Conte on 27/08/19.
//  Copyright © 2019 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation

class HeroProvider {
    var searchNetworking = SearchNetworking()
    
    var heroImage: Data? = Data()
    var heroName: String? = ""
    var heroID: String? = ""
    let dispatchSemaphore = DispatchSemaphore(value: 1)
    
    func provideHeroInformation(heroName: String?, completion: @escaping (_ image: Data?, _ heroName: String?, _ error: Error?) -> Void) {
        
        dispatchSemaphore.wait()
        print("Request 1 started")
        self.provideHeroID(heroName: heroName) { (heroes, error) in
            
            if let firstHero = heroes?.results?.first {
                self.heroID = firstHero.id
                self.heroName = firstHero.biography?.fullName
                print("Request 1 finished")
                
            }
            self.dispatchSemaphore.signal()
        }
        
        
        dispatchSemaphore.wait()
        print("Request 2 started")
        provideHeroImage { (data, error)  in
            print("Request 2 finished")
            self.heroImage = data
            self.dispatchSemaphore.signal()
            completion(self.heroImage, self.heroName, nil)
        }
        
        
        
    }
    
    func provideHeroID(heroName: String?, completion: @escaping (HeroResult?, _ error: Error?) -> Void) {
        
        searchNetworking.getHeroRequest(heroName: heroName, completion: { (results, error) in
            
            do {
                let heroInformation = try JSONDecoder().decode(HeroResult.self, from: results ?? Data())
                completion(heroInformation, error)
            } catch {
                print("could not decode information")
            }
        })
    }
    
    func provideHeroImage(completion: @escaping (Data?, _ error: Error?) -> Void) {
        searchNetworking.getHeroImage(heroID: heroID ?? "", completion: { (results, error) in
            do {
                let heroImageData = try JSONDecoder().decode(HeroImage.self, from: results ?? Data())
                let heroImageURL = heroImageData.url
                let imagePath = URL(string: heroImageURL!)
                
                if let imageData = try? Data(contentsOf: imagePath!) {
                    completion(imageData, error)
                }
                else {
                    completion(nil, error)
                }
                
            } catch {
                completion(Data(), error)
                print(error)
            }
            
        })
    }
    
}
