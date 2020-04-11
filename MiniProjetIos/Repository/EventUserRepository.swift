//
//  EventUserRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class EventUserRepository{
    
    
    private static var instance: EventUserRepository?

     public static func getInstance() -> EventUserRepository{
         if(instance == nil){
             instance = EventUserRepository()
         }
         return instance!
     }
    
    func add(event:EventUser, completionHandler: @escaping (_ response: Data) -> ())
    {
        let parameters = [
            "username": event.username,
            "event_name": event.eventName,
            "role":event.role
            ] as [String : Any]
     
        AF.request(Helper.ENDPOINT+"events_user/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    func getEventUser(eventName:String,username:String,completionHandler: @escaping (_ user: [EventUser]) -> ()) {
       
           let url = Helper.ENDPOINT+"events_user/getByUsername/"+username+"/"+eventName
          
           AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
               switch responseData.result {
               case .success:
                   let swiftyJsonVar = try? JSON(data:responseData.data!)
             
                   if(swiftyJsonVar!.arrayValue.count > 0)
                   {
                             var eventUSers : [EventUser] = []
                       for i in 0...swiftyJsonVar!.arrayValue.count-1
                       {
                   
               let eventUser = EventUser()
       
                 
                   eventUser.username = swiftyJsonVar!.arrayValue[i]["username"].string!

                eventUser.eventName = swiftyJsonVar!.arrayValue[i]["event_name"].string ?? ""

     
                   eventUSers.append(eventUser)
                
                       }
                           completionHandler(eventUSers)
                       
                   }
               
                   break
               case .failure(let error):
                   print(error)
                   break
               }
           })
       }


    

    
    
    func getEventUserByEventName(eventName:String,completionHandler: @escaping (_ user: [EventUser]) -> ()) {
        
            let url = Helper.ENDPOINT+"events_user/getByEventName"+eventName
           
            AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
                switch responseData.result {
                case .success:
                    let swiftyJsonVar = try? JSON(data:responseData.data!)
              
                    if(swiftyJsonVar!.arrayValue.count > 0)
                    {
                              var eventUSers : [EventUser] = []
                        for i in 0...swiftyJsonVar!.arrayValue.count-1
                        {
                    
                let eventUser = EventUser()
        
                  
                    eventUser.username = swiftyJsonVar!.arrayValue[i]["username"].string!

                 eventUser.eventName = swiftyJsonVar!.arrayValue[i]["event_name"].string ?? ""

      
                    eventUSers.append(eventUser)
                 
                        }
                            completionHandler(eventUSers)
                        
                    }
                
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
    
    func remove(eventName:String,username:String, completionHandler: @escaping (_ response: Data) -> ())
    {
      
    AF.request(Helper.ENDPOINT+"events_user/delete/"+username+"/"+eventName, method:.delete ,encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    
     
}
