//
//  GetKeys.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 12/8/17.
//  Copyright © 2017 Dave Stucky. All rights reserved.
//

import Foundation
struct FuneralKey:Decodable{
    let funeralKey:String
}
struct WeddingKey:Decodable{
    let weddingKey:String
}

struct EventKey:Decodable{
    let eventKey:String
}


class GetKeys {
    
    var keyFind:String
    var getUrl:String
    
    init(keyFind:String, getUrl:String) {
        self.keyFind = ""
        self.getUrl = ""
    }

    func FindTheKeys() -> [String:String] {
        
        var gotKeys = [keyFind]
    let url = URL(string: getUrl)
    
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
    
    if error == nil {
    do {
        gotKeys = try JSONDecoder().decode([keyFind], from: data!)
        
    
    }catch {
    print("JSON Error")
    }
    }
    }.resume()
        return gotKeys
}
}
