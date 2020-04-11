//
//  DateHandler.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation


class DateHandler
{
    
    
    private static var instance: DateHandler?

    public static func getInstance() -> DateHandler{
        if(instance == nil){
            instance = DateHandler()
        }
        return instance!
    }
    
    
    func compareDate(date1 : Date,date2 : Date) -> Bool
    {
        
        
        let calendar1 = Calendar.current
      let day1 =   calendar1.component(.year, from: date1)
      let month1 =   calendar1.component(.month, from: date1)
      let year1 =  calendar1.component(.day, from: date1)
        
        let calendar2 = Calendar.current
           let day2 =    calendar2.component(.year, from: date2)
        let month2 =    calendar2.component(.month, from: date2)
           let year2 =     calendar2.component(.day, from: date2)
            
    if(day1 == day2 && month1 == month2 && year1 == year2)
    {
        return true
    }else{
        return false
        }
        
        
    }
    
    func isToday(dateStr : String) -> Bool
    {
        
        let isoDate = dateStr
      let startIndex = isoDate.index(isoDate.startIndex, offsetBy: 0)
      let endIndex = isoDate.index(startIndex, offsetBy: 10)
      var Msg_Date_ = isoDate[startIndex..<endIndex].description
              
  let date = Date()
        let isoDate2 = Calendar.current.date(byAdding: .day,value: -1, to: date)!.description
let startIndex2 = isoDate2.index(isoDate2.startIndex, offsetBy: 0)
 let endIndex2 = isoDate2.index(startIndex2, offsetBy: 10)
 var Msg_Date_2 = isoDate2[startIndex2..<endIndex2].description
        
                  if(Msg_Date_ == Msg_Date_2)
                             {
                                    return true
                              }else
                  {
                    return false
                   }
    }
    
    
    func getCleanDate(date : String) -> String
    {
        var res = ""
        
        if(date != "")
        {
            let isoDate = date
               let startIndex = isoDate.index(isoDate.startIndex, offsetBy: 0)
               let endIndex = isoDate.index(startIndex, offsetBy: 10)
               res = isoDate[startIndex..<endIndex].description
             
            
        }
        return res
    }
    
    
    func fromStringToDate(date:String)-> Date{
        
      let expiryDate = "2020-01-10" // Jan 10 2020

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date) ?? Date()
        
        return date
        
    }
    
    
    
}
