//
//  Date Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 29.08.2023.
//

import Foundation

extension Date{
    
    public func timeIntervalSince()->DateComponents{
        let calendar = Calendar.current
        let startDate = self
        let endDate = Date.now

        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate, to: endDate)

        return components
    }
    public func toISO8601()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.string(from: self) + "Z"
        return date
    }
    
    /// "dd.MM.yyyy"
    public func toString()->String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    /// "yyyy-MM-dd"
    public func toStringYearFirst()->String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public func timeToString()->String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.string(from: self)
        return date
    }
    
    public static func timeStringToDate(date:Date, time:String)->Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let date = dateFormatter.date(from: "\(date.toStringYearFirst()) \(time)")!
        return date
    }
    
    public func getDayName()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        return dateFormatter.string(from: self)
    }
    
    static func dateFromISO8601(_ ISOString:String) -> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from:ISOString){
            return date
        }else{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:ISOString)
            return date
        }
        
    }
    
    
    static func dateToString(_ dateString:String)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from:dateString)
        
        return date
    }
    
    static func timeFromString(_ timeString:String) ->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let date = dateFormatter.date(from:timeString)
        
        return date
    }
}
