//
//  CalEventMaker.swift
//  DoveEventLog
//
//  Created by Dave Stucky on 1/9/18.
//  Copyright © 2018 Dave Stucky. All rights reserved.
//

import Foundation
import EventKit


class CalEventMaker {
    
    static var beginDate: String!
    static var beginTime: String!
    static var eventNarrative:String!
    static var savedEventId : String = ""
    
    static func SetTime(beginDate:String, beginTime:String, eventNarrative:String) {
            let eventStore = EKEventStore()
            let startDate = "\(beginDate) \( beginTime)"
            //string to date
            let dateformatter = DateFormatter()
            //dateformatter.locale
            dateformatter.dateFormat = "MM/dd/yy h:mm a"
            let caldate = dateformatter.date(from: startDate)        //done
            let endDate = caldate?.addingTimeInterval(60 * 60) // One hour
            if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                eventStore.requestAccess(to: .event, completion: {
                    granted, error in
                    self.createEvent(eventStore, title: "Dove release for \(self.eventNarrative)", startDate: caldate!, endDate: endDate!)
                })
            } else {
                createEvent(eventStore, title: "Dove release for \(self.eventNarrative)", startDate: caldate!, endDate: endDate!)
            }
        }
    
        static func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
            let event = EKEvent(eventStore: eventStore)
            event.title = title
            event.startDate = startDate
            event.endDate = endDate
            event.calendar = eventStore.defaultCalendarForNewEvents
            do {
                try eventStore.save(event, span: .thisEvent)
                savedEventId = event.eventIdentifier
            } catch {
                print("Bad things happened")
            }
        }
    
}
