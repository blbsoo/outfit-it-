//
//  Global.swift
//  Outfit App
//
//  Created by Krishna Sharma on 03/12/21.
//

import Foundation


class GlobalConstant: NSObject {
    
    let timeFormatter = "hh:mm a"
    
    func timeStampToDate(timeStamp:Double)-> String {
        let converted = NSDate(timeIntervalSince1970: timeStamp / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = timeFormatter
        return dateFormatter.string(from: converted as Date)
    }
    
    func chatIDCreation(userID:String, senderID:String)-> String {
        return userID + "_" + senderID
    }
}
