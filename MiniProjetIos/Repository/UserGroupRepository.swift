//
//  UserGroupRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class UserGroupRepository{
    
    
     private static var instance: UserGroupRepository?

     public static func getInstance() -> UserGroupRepository{
         if(instance == nil){
             instance = UserGroupRepository()
         }
         return instance!
     }
    
    		
    func add(userGroup : UserGroup, completionHandler: @escaping (_ response: Data) -> ())
      {
          let parameters = [
            "username": userGroup.username,
            "groupe_name": userGroup.groupeName,
            "role":userGroup.role
              ] as [String : Any]
       
          AF.request(Helper.ENDPOINT+"group_user/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
          
              completionHandler(responseData.data!)
          
          })
        
        
          
          }
    
    func getUserByGroupName(groupName: String, completionHandler: @escaping (_ user: [User]) -> ()) {
        let url = Helper.ENDPOINT+"group_user/getByGroupName/"+groupName
        AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success:
                let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                
               
                if(swiftyJsonVar!.arrayValue.count > 0)
                {
                    var users : [User] = []

                    for i in 0...swiftyJsonVar!.arrayValue.count-1
                                                       {
                    let user = User()
                    user.username = swiftyJsonVar!.arrayValue[i]["username"].string!
                    user.password = swiftyJsonVar!.arrayValue[i]["password"].string!
                    user.id = swiftyJsonVar!.arrayValue[i]["id"].int
                    users.append(user)
                }
                //   let user: User = Mapper<User>().map(JSONString: swiftyJsonVar!.arrayValue[0].string! )!
                completionHandler(users)
                }
            
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    
    func getUserByUsernameAndRole(username: String,groupName :String, completionHandler: @escaping (_ user: UserGroup) -> ()) {
        let url = Helper.ENDPOINT+"group_user/getByUsernameAndGroupName/"+username+"/"+groupName
        AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success:
                let swiftyJsonVar = try? JSON(data:responseData.data!)
        
                if(swiftyJsonVar!.arrayValue.count > 0)
                {

                                                       
                    let user = UserGroup()
                    user.username = swiftyJsonVar!.arrayValue[0]["username"].string!
                    user.role = swiftyJsonVar!.arrayValue[0]["role"].string!
                                      
                    user.groupeName = swiftyJsonVar!.arrayValue[0]["groupe_name"].string!
                    
              
                //   let user: User = Mapper<User>().map(JSONString: swiftyJsonVar!.arrayValue[0].string! )!
                completionHandler(user)
                }
            
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    	
    func getUserByGroupNameAndRole(groupeName: String,role:String, completionHandler: @escaping (_ user: [User]) -> ()) {
         let url = Helper.ENDPOINT+"group_user/getByUsernameAndRole/"+groupeName+"/"+role
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
             
                 
                
                 if(swiftyJsonVar!.arrayValue.count > 0)
                 {
                     var users : [User] = []

                     for i in 0...swiftyJsonVar!.arrayValue.count-1
                                                        {
                     let user = User()
                     user.username = swiftyJsonVar!.arrayValue[i]["username"].string!
                     user.password = swiftyJsonVar!.arrayValue[i]["password"].string!
                     user.id = swiftyJsonVar!.arrayValue[i]["id"].int
                     users.append(user)
                 }
                 //   let user: User = Mapper<User>().map(JSONString: swiftyJsonVar!.arrayValue[0].string! )!
                 completionHandler(users)
                 }
             
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
     }
    
    
    func remove(username:String,groupName : String, completionHandler: @escaping (_ response: Data) -> ())
       {
         
           AF.request(Helper.ENDPOINT+"group_user/delete/"+username+"/"+groupName
               , method:.delete ,encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
           
               completionHandler(responseData.data!)
           
           })
           
           }
    
    
}
