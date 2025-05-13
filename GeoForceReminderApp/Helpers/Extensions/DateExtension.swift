//
//  RedirectHelper.swift
//  FaizanHelpingCode
//
//  Created by Usama on 2022/5/2.
//

import Foundation

extension Date {
    func getFormattedDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    func formatDate(format: String = "dd / MM / yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Date {
    
    func byAddingMonths(months: Int) -> Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let newDate = calendar.date(byAdding: .month, value:months , to: self)!
        
        return newDate
    }
    
    func byAddingDays(days: Int) -> Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let newDate = calendar.date(byAdding: .day, value:days , to: self)!
        
        return newDate
    }
}

 
 extension Date {
     
     func daysBetween(date: Date) -> Int {
         return Date.daysBetween(start: self, end: date)
     }
     
     static func daysBetween(start: Date, end: Date) -> Int {
         let calendar = Calendar.current
         
         // Replace the hour (time) of both dates with 00:00
         let date1 = calendar.startOfDay(for: start)
         let date2 = calendar.startOfDay(for: end)
         
         let a = calendar.dateComponents([.day], from: date1, to: date2)
         return a.value(for: .day)!
     }
 }

 
 extension Date {
     func timeAgoDisplay() -> String {

         let calendar = Calendar.current
         let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
         let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
         let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
         let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

         if minuteAgo < self {
             let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
             return "\(diff) sec ago"
         } else if hourAgo < self {
             let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
             return "\(diff) min ago"
         } else if dayAgo < self {
             let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
             return "\(diff) hrs ago"
         } else if weekAgo < self {
             let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
             return "\(diff) days ago"
         }
         let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
         return "\(diff) weeks ago"
     }
 }


 public enum DateFormat : String
 {
     case onlyTime = "HH:mm"
     case twelveHoursTime = "h a"
     case MonthName = "MMMM"
     case MonthNameShort = "MMM"
     case dayDateOnly = "MM"
     case dayOnly = "dd"
     case weekname = "EEEE"
     case monthDay = "MMMM dd EEEE"
     case MonthYear = "MMMM yyyy"
     case defaultDate = "yyyy-MM-dd"
     case headingDate = "MMM d, yyyy"
     case defaultTime = "HH:mm:ss"
     case WeekTime = "E, h:mm a"
     case WeekTime2 = "h:mm a"
     case WithFullTime = "yyyy-MM-dd HH:mm:ssZ"
     case fullDate =  "YYYY-MM-dd HH:mm:ss"
     case DateFormat_2 =  "MMMM dd,yyyy"
     case DateFormat_3 =  "d MMM"
     case DateFormat_ddMMMYYYY = "dd MMM YYYY"
     case DateFormat_MMddyyyy = "MM/dd/yyyy"
     case checkOutFormat = "MM-dd-yyyy"
     case longDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
     case DateFormat_ddMMMM = "dd, MMMM, yyyy HH:mm a"
     case DateFormate_Notification = "dd-MM-yyyy HH:mm:ss"
     case ToDateFormate = "dd-MM-yyyy, EEE hh:mm a"
 }

//2022-11-03 00:00:00
 extension Date {
     
     public func toString(format: String) -> String{
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
         dateFormatter.timeZone = TimeZone.current
         let stringForm = dateFormatter.string(from: self)
         return stringForm
     }
 }
