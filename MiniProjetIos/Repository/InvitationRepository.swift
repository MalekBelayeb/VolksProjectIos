//
//  InvitationRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class InvitationRepository{
    
    
    
     private static var instance: InvitationRepository?

     public static func getInstance() -> InvitationRepository{
         if(instance == nil){
             instance = InvitationRepository()
         }
         return instance!
     }
    
    
    
    
    
            
    func add(invitation : Invitation, completionHandler: @escaping (_ response: Data) -> ())
      {
          let parameters = [
            "sender": invitation.sender,
            "receiver": invitation.receiver,
            "content":invitation.content,
            "type":invitation.type
           
            ] as [String : Any]
       
          AF.request(Helper.ENDPOINT+"invitation/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
          
              completionHandler(responseData.data!)
          
          })
          
          }
    
    
    
    func getInvitation(sender : String,receiver:String,completionHandler: @escaping (_ commentsList: [Invitation]) -> ()) {
     
         let url = Helper.ENDPOINT+"invitation/get/"+sender+"/"+receiver
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                 if(swiftyJsonVar!.arrayValue.count > 0)
                 {
                           var invitations : [Invitation] = []
                     for i in 0...swiftyJsonVar!.arrayValue.count-1
                     {
                         
                     let invitation = Invitation()
                     
                        invitation.id = swiftyJsonVar!.arrayValue[i]["id"].int!
                        invitation.sender = swiftyJsonVar!.arrayValue[i]["sender"].string!
                        invitation.receiver = swiftyJsonVar!.arrayValue[i]["receiver"].string!
                        invitation.type = swiftyJsonVar!.arrayValue[i]["type"].string!
                                         
                    
                         invitations.append(invitation)
                     }
                         completionHandler(invitations)
                     
                 }
             
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
     }
    
    
    
     func getInvitationByReceiver(receiver:String,completionHandler: @escaping (_ commentsList: [Invitation]) -> ()) {
      
          let url = Helper.ENDPOINT+"invitation/getAllByReceiver/"+receiver
         
          AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
              switch responseData.result {
              case .success:
                  let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                  if(swiftyJsonVar!.arrayValue.count > 0)
                  {
                            var invitations : [Invitation] = []
                      for i in 0...swiftyJsonVar!.arrayValue.count-1
                      {
                          
                      let invitation = Invitation()
                      
                         invitation.id = swiftyJsonVar!.arrayValue[i]["id"].int!
                         invitation.sender = swiftyJsonVar!.arrayValue[i]["sender"].string!
                         invitation.receiver = swiftyJsonVar!.arrayValue[i]["receiver"].string!
                         invitation.type = swiftyJsonVar!.arrayValue[i]["type"].string!
                                          
                     
                          invitations.append(invitation)
                      }
                          completionHandler(invitations)
                      
                  }
              
                  break
              case .failure(let error):
                  print(error)
                  break
              }
          })
      }
    
 
    
    func remove(receiver:String,sender : String, completionHandler: @escaping (_ response: Data) -> ())
    {
      
        AF.request(Helper.ENDPOINT+"invitation/delete/"+receiver+"/"+sender
            , method:.delete ,encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    
}
