//
//  AlbumNetworking.swift
//  DispatchQueueClass
//
//  Created by Henrique Figueiredo Conte on 27/08/19.
//  Copyright © 2019 Henrique Figueiredo Conte. All rights reserved.
//

import Foundation


class ImageNetworking {
    
    var imageURL: URL?
    var apiKey: String?
    
    init(){
        apiKey = "2374884709264264"
        guard let albumURL = URL(string: "") else { fatalError("error at getting album url")}
    }
    
    func getAlbumRequest() {
        var request = URLRequest(url: imageURL!)
        request.httpMethod = "GET"
    }
}
