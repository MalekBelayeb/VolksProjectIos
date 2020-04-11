//
//  MessageRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/13/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageRepository{
    
    
    private static var instance: MessageRepository?

    public static func getInstance() -> MessageRepository{
        if(instance == nil){
            instance = MessageRepository()
        }
        return instance!
    }
    
    func getMessages(connectedUsername : String,username : String ,completionHandler: @escaping (_ user: [Message]) -> ()) {
      
      let url = Helper.ENDPOINT+"message/getAllBySenderReceiver/"+connectedUsername+"/"+username
         
          AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
              switch responseData.result {
              case .success:
                  let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                  if(swiftyJsonVar!.arrayValue.count > 0)
                  {
                            var messages : [Message] = []
                      for i in 0...swiftyJsonVar!.arrayValue.count-1
                      {
                          
                      let message = Message()
                      
                          
                          message.id = swiftyJsonVar!.arrayValue[i]["id"].int ?? -1
                                                  
                        message.message = swiftyJsonVar!.arrayValue[i]["message"].string ?? ""
                        message.receiver = swiftyJsonVar!.arrayValue[i]["receiver"].string ?? ""
                        message.sender = swiftyJsonVar!.arrayValue[i]["sender"].string ?? ""
                        
                          messages.append(message)
                      }
                          completionHandler(messages)
                      
                  }
              
                  break
              case .failure(let error):
                  print(error)
                  break
              }
          })
      }
    
    
    
    func getDiscussions(connectedUsername : String ,completionHandler: @escaping (_ user: [Message]) -> ()) {
      
      let url = Helper.ENDPOINT+"message/getDiscussionsOfUsername/"+connectedUsername
         
          AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
              switch responseData.result {
              case .success:
                  let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                  if(swiftyJsonVar!.arrayValue.count > 0)
                  {
                            var messages : [Message] = []
                      for i in 0...swiftyJsonVar!.arrayValue.count-1
                      {
                          
                      let message = Message()
                      
                          
                          message.id = swiftyJsonVar!.arrayValue[i]["id"].int ?? -1
                                                  
                        message.message = swiftyJsonVar!.arrayValue[i]["message"].string ?? ""
                        message.receiver = swiftyJsonVar!.arrayValue[i]["receiver"].string ?? ""
                        message.sender = swiftyJsonVar!.arrayValue[i]["sender"].string ?? ""
                        
                          messages.append(message)
                      }
                          completionHandler(messages)
                      
                  }
              
                  break
              case .failure(let error):
                  print(error)
                  break
              }
          })
      }
    
}
