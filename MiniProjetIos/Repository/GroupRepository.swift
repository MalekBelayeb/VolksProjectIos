//
//  GroupRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class GroupRepository
{
    
    
    
    
     private static var instance: GroupRepository?

     public static func getInstance() -> GroupRepository{
         if(instance == nil){
             instance = GroupRepository()
         }
         return instance!
     }
    
    
    
    
    
    func getAllGroups(completionHandler: @escaping (_ commentsList: [Group]) -> ()) {
     
         let url = Helper.ENDPOINT+"group/getAll"
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                 if(swiftyJsonVar!.arrayValue.count > 0)
                 {
                           var groups : [Group] = []
                     for i in 0...swiftyJsonVar!.arrayValue.count-1
                     {
                         
                     let group = Group()
                     
                        
                      //comment.post = swiftyJsonVar!.arrayValue[i]["post"].int!
                        
                        group.name = swiftyJsonVar!.arrayValue[i]["name"].string!
                        group.creator = swiftyJsonVar!.arrayValue[i]["creator"].string!
                        group.description = swiftyJsonVar!.arrayValue[i]["description"].string!
                                         
                    
                         groups.append(group)
                     }
                         completionHandler(groups)
                     
                 }
             
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
     }
    
    func add(group:Group, completionHandler: @escaping (_ response: Data) -> ())
      {
          let parameters = [
          "name": group.name,
          "description": group.description,
          "creator":group.creator
              ] as [String : Any]
       
          AF.request(Helper.ENDPOINT+"group/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
          
              completionHandler(responseData.data!)
          
          })
          
          }
    
    
    
    
    
    func getGroupsByCreator(creator : String,completionHandler: @escaping (_ commentsList: [Group]) -> ()) {
     
         let url = Helper.ENDPOINT+"group/getByCreator/"+creator
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                 if(swiftyJsonVar!.arrayValue.count > 0)
                 {
                           var groups : [Group] = []
                     for i in 0...swiftyJsonVar!.arrayValue.count-1
                     {
                         
                     let group = Group()
                     
                        
                      //comment.post = swiftyJsonVar!.arrayValue[i]["post"].int!
                        
                        group.name = swiftyJsonVar!.arrayValue[i]["name"].string!
                        group.creator = swiftyJsonVar!.arrayValue[i]["creator"].string!
                        group.description = swiftyJsonVar!.arrayValue[i]["description"].string!
                                         
                    
                         groups.append(group)
                     }
                         completionHandler(groups)
                     
                 }
             
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
     }
    
    
}
