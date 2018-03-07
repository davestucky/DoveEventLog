//
//  WUADStructs.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 12/17/17.
//  Copyright © 2017 Dave Stucky. All rights reserved.
//

import Foundation

struct FuneralKey:Decodable{
    let funeralKey:String
}

struct WeddingKey:Decodable{
    let wedBrideKey:String
}

struct EventKey:Decodable{
    let eventkey:String
}


struct TblFuneralInfo: Codable {
    let funeralKey: String
    let decFName: String
    let decLName: String
    let funeralDate: String
    let funeralTime: String
    let funeralHome: String
    let funeralAddress: String
    let funeralCity: String
    let funeralState: String
    let cemeteryName: String
    let cemeteryAddress: String
    let cemeteryCity: String
    let cemeteryState: String
    let notes: String
    let furneralDirector: String
    
//    func saveItem() {
//        DataManager.save(self, with: funeralKey)
//    }
    
//    func deleteItem() {
//        DataManager.delete(funeralKey)
//    }
    
//    mutating func markAsCompleted() {
//        self.completed = true
//        DataManager.save(self, with: funeralKey)
//    }
    
}

struct TblEventsInfo: Codable {
    let task: String
    let eventkey: String
    let eventname: String
    let eventdate: String
    let eventtime: String
    let locname: String
    let locaddress: String
    let loccity: String
    let locstate: String
    let eventcontactname: String
    let specialinstructions: String
    let eventcalID: String
    
//    func saveItem() {
//        DataManager.save(self, with: "event")
//    }
    
//    func deleteItem() {
//        DataManager.delete(eventkey)
//    }
    
//    mutating func markAsCompleted() {
//        self.completed = true
//        DataManager.save(self, with: String)
//    }
    
}

struct TblBridesInfo: Codable {
    let wedBrideKey: String
    let brideFName: String
    let brideLName: String
    let brideAddress: String
    let brideCity: String
    let brideState: String
    let brideZip: String
    let bridePhone: String
    let brideEmail: String
    let brideMom: String
    let brideDad: String
    let wedDate: String
    let wedTime: String
    
//    func saveItem() {
//        DataManager.save(self, with: wedBrideKey)
//    }
    
//    func deleteItem() {
//        DataManager.delete(wedBrideKey)
//    }
    
//    mutating func markAsCompleted() {
//        self.completed = true
//        DataManager.save(self, with: wedBrideKey)
//    }
    
}

struct TblGroomInfo: Codable {
    let wedBrideKey: String
    let groomFName: String
    let groomLName: String
    let groomMom: String
    let groomDad: String
    
//    func saveItem() {
//        DataManager.save(self, with: wedBrideKey)
//    }
    
//    func deleteItem() {
//        DataManager.delete(wedBrideKey)
//    }
    
//    mutating func markAsCompleted() {
//        self.completed = true
//        DataManager.save(self, with: uuidString)
//    }
    
}

struct TblPhotoInfo: Codable {
    let wedBrideKey: String
    let wedPhotographer: String
    let wedPhotographerAddress: String
    let wedPhotographerCity: String
    let wedPhotographerPhone: String
    let wedPhotographerEmail: String
    let contacted: String
    
//    func saveItem() {
//        DataManager.save(self, with: wedBrideKey)
//    }
    
//    func deleteItem() {
//        DataManager.delete(wedBrideKey)
//    }
    
//    mutating func markAsCompleted() {
//        self.completed = true
//        DataManager.save(self, with: wedBrideKey)
//    }
    
}

struct TblVenueInfo: Codable {
    let wedBrideKey: String
    let wedVenue: String
    let wedVenueAddress: String
    let wedVenueCity: String
    let wedVenueState: String
    let wedVenueZip: String
    let webVenuePhone: String
    let wedVenueEmail: String
    let wedVenueInOut: String
    let wedMainColor: String
    let wedSecColor: String
    let wedTerColor: String
    let wedSpecialInstructions: String
    let wedHoldRelease: String
    let wedNumDoves: String
    
//    func saveItem() {
//        DataManager.save(self, with: wedBrideKey)
//    }
    
//    func deleteItem() {
//        DataManager.delete(wedBrideKey)
//    }
    
//    mutating func markAsCompleted() {
//        self.completed = true
//        DataManager.save(self, with: wedBrideKey)
//    }
    
}
