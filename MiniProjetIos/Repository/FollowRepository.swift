//
//  FollowRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/5/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class FollowRepository{
    
    
      private static var instance: FollowRepository?

      public static func getInstance() -> FollowRepository{
          if(instance == nil){
              instance = FollowRepository()
          }
          return instance!
      }
     
    
    
    
       func add(follow:Follow, completionHandler: @escaping (_ response: Data) -> ())
       {
           let parameters = [
           "username": follow.username,
           "following":follow.following
               ] as [String : Any]
        
           AF.request(Helper.ENDPOINT+"followers/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
           
               completionHandler(responseData.data!)
           
           })
           
           }
    
    
    func remove(following:String,username:String, completionHandler: @escaping (_ response: Data) -> ())
    {
      
    AF.request(Helper.ENDPOINT+"followers/delete/"+username+"/"+following, method:.delete ,encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    
    func getFollow( following:String,username:String,completionHandler: @escaping (_ followList: Int) -> ()) {
     
         let url = Helper.ENDPOINT+"followers/getOne/"+username+"/"+following
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                                      completionHandler(swiftyJsonVar!.arrayValue.count)

                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
        
        
        
        
     }
     
    
    
    func getFollowing( following:String,completionHandler: @escaping (_ followList: Int) -> ()) {
     
         let url = Helper.ENDPOINT+"followers/getAllFollowing/"+following
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                                      completionHandler(swiftyJsonVar!.arrayValue.count)

                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
    
}

    
    
        func getFollows( username:String,completionHandler: @escaping (_ followList: Int) -> ()) {
             
                 let url = Helper.ENDPOINT+"followers/getAllFollowers/"+username
                
                 AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
                     switch responseData.result {
                     case .success:
                         let swiftyJsonVar = try? JSON(data:responseData.data!)
                   
                                              completionHandler(swiftyJsonVar!.arrayValue.count)

                         break
                     case .failure(let error):
                         print(error)
                         break
                     }
                 })
            
            
         }
    
    
    
        func getFollowers( username:String,completionHandler: @escaping (_ followList: [Follow]) -> ()) {
             
                 let url = Helper.ENDPOINT+"followers/getAllFollowing/"+username
                
                 AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
                     switch responseData.result {
                     case .success:
                         let swiftyJsonVar = try? JSON(data:responseData.data!)
                        
                         if(swiftyJsonVar!.arrayValue.count > 0)
                            {
                                      var follows : [Follow] = []
                                for i in 0...swiftyJsonVar!.arrayValue.count-1
                                {
                                    
                                let follow = Follow()
                                
                                    follow.username = swiftyJsonVar!.arrayValue[i]["username"].string!
                                   
                               
                                    follows.append(follow)
                                }
                                    completionHandler(follows)
                                
                            }
                        break
                     case .failure(let error):
                         print(error)
                         break
                     }
                 })
            
            
         }
        
        
    
    func getFollowings( username:String,completionHandler: @escaping (_ followList: [Follow]) -> ()) {
             
                 let url = Helper.ENDPOINT+"followers/getAllFollowers/"+username
                
                 AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
                     switch responseData.result {
                     case .success:
                         let swiftyJsonVar = try? JSON(data:responseData.data!)
                        
                         if(swiftyJsonVar!.arrayValue.count > 0)
                            {
                                      var follows : [Follow] = []
                                for i in 0...swiftyJsonVar!.arrayValue.count-1
                                {
                                    
                                let follow = Follow()
                                
                                    follow.username = swiftyJsonVar!.arrayValue[i]["username"].string!
                                   
                               
                                    follows.append(follow)
                                }
                                    completionHandler(follows)
                                
                            }
                        break
                     case .failure(let error):
                         print(error)
                         break
                     }
                 })
            
            
         }
    
    
    
        
    }
    

