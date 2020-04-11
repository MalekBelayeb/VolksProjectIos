//
//  EventRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class EventRepository
{
    
    
    private static var instance: EventRepository?

     public static func getInstance() -> EventRepository{
         if(instance == nil){
             instance = EventRepository()
         }
         return instance!
     }
    
    
    
func add(event:Event, completionHandler: @escaping (_ response: Data) -> ())
    {
        let parameters = [
            "nom": event.name,
            "description": event.description,
            "creator":event.creator,                    
            "place":event.place,
            "state":event.state,
            "contry":event.country,
            "date" : event.strDate
            ] as [String : Any]
     
        AF.request(Helper.ENDPOINT+"events/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    
    func update(event:Event, completionHandler: @escaping (_ response: Data) -> ())
    {
        let parameters = [
            "description": event.description,
            "contry":event.country,
            "city":event.place ,
            "state":event.state
            ] as [String : Any]
     
        AF.request(Helper.ENDPOINT+"events/update/"+event.name, method:.put , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
     func remove(name:String, completionHandler: @escaping (_ response: Data) -> ())
    {
      
        AF.request(Helper.ENDPOINT+"events/delete/"+name, method:.delete ,encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    func getEvents(completionHandler: @escaping (_ user: [Event]) -> ()) {
      
          let url = Helper.ENDPOINT+"events/getAll"
         
          AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
              switch responseData.result {
              case .success:
                  let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                  if(swiftyJsonVar!.arrayValue.count > 0)
                  {
                            var events : [Event] = []
                      for i in 0...swiftyJsonVar!.arrayValue.count-1
                      {
                          
                      let event = Event()
              
                        event.id =  swiftyJsonVar!.arrayValue[i]["id"].int!
                        
                          event.name = swiftyJsonVar!.arrayValue[i]["nom"].string!

                        event.description = swiftyJsonVar!.arrayValue[i]["description"].string ?? ""

                        event.place = swiftyJsonVar!.arrayValue[i]["place"].string ?? ""
                        event.state = swiftyJsonVar!.arrayValue[i]["state"].string ?? ""
                        event.country = swiftyJsonVar!.arrayValue[i]["contry"].string ?? ""
                        event.creator = swiftyJsonVar!.arrayValue[i]["creator"].string ?? ""

                        event.strDate = swiftyJsonVar!.arrayValue[i]["date"].string ?? ""
                          events.append(event)
                      }
                          completionHandler(events)
                      
                  }
              
                  break
              case .failure(let error):
                  print(error)
                  break
              }
          })
      }
    
}
