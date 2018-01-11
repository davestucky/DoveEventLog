//
//  DataManager.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 12/18/17.
//  Copyright © 2017 Dave Stucky. All rights reserved.
//

import Foundation
import UIKit


public class DataManager {
    
    // get Document Directory
    static fileprivate func getDocumentDirectory () -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        }else{
            fatalError("Unable to access document directory")
        }
    }
    
    // Save any kind of codable objects
    static func save <T:Encodable> (_ object:T, with fileURL:URL){
        
        var request = URLRequest(url: fileURL)
        request.httpMethod = "POST"
        let newPost = object
        let jsonTodo :Data
        do{
            jsonTodo = try JSONSerialization.data(withJSONObject: newPost, options: [])
            request.httpBody = jsonTodo
            print(request)
        }catch{
            print("Error: cannot create JSON from todo")
            return
            
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }
        
        
        
//        let task = session.dataTask(with: request) { (data, _, error) in
//            guard let data = data else {return}
//            do{
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            }catch{
//                print(error)
//            }
//            }.resume()
//    }
//
//
//
//        if let jsonData = try? JSONEncoder().encode(object) {
//
//                print(jsonData)
//            }
//        catch  {
//              print("Failed to write JSON data: \(error.localizedDescription)")
//         }
        
//    }

    
    // Load any kind of codable objects
    static func load <T:Decodable> (_ fileName:String, with type:T.Type) -> T {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            }catch{
                fatalError(error.localizedDescription)
            }
            
        }else{
            fatalError("Data unavailable at path \(url.path)")
        }
        
    }
    
    
    // Load data from a file
    static func loadData (_ fileName:String) -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File not found at path \(url.path)")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            return data
            
        }else{
            fatalError("Data unavailable at path \(url.path)")
        }
        
    }
    
    // Load all files from a directory
    static func loadAll <T:Decodable> (_ type:T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            
            var modelObjects = [T]()
            
            for fileName in files {
                modelObjects.append(load(fileName, with: type))
            }
            
            return modelObjects
            
            
        }catch{
            fatalError("could not load any files")
        }
    }
    
    // Delete a file
    static func delete (_ fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
    }
    
    
    
}
