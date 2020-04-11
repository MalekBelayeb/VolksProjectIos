//
//  CommentRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/5/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommentRepository{
    
    
    
    
     private static var instance: CommentRepository?

     public static func getInstance() -> CommentRepository{
         if(instance == nil){
             instance = CommentRepository()
         }
         return instance!
     }
    
    
       func add(comment:Comment, completionHandler: @escaping (_ response: Data) -> ())
       {
           let parameters = [
            "post": comment.post,
           "username": comment.username,
           "comment":comment.comment
               ] as [String : Any]
        
           AF.request(Helper.ENDPOINT+"comments/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
           
               completionHandler(responseData.data!)
           
           })
           
           }
    
    
    
    func getUsers(post : Int,completionHandler: @escaping (_ commentsList: [Comment]) -> ()) {
     
         let url = Helper.ENDPOINT+"comments/getByPost/"+String(post)
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                 if(swiftyJsonVar!.arrayValue.count > 0)
                 {
                           var comments : [Comment] = []
                     for i in 0...swiftyJsonVar!.arrayValue.count-1
                     {
                         
                     let comment = Comment()
                     
                        
                      //comment.post = swiftyJsonVar!.arrayValue[i]["post"].int!
                        
                        comment.username = swiftyJsonVar!.arrayValue[i]["username"].string!
                        comment.comment = swiftyJsonVar!.arrayValue[i]["comment"].string!
                        
                    
                         comments.append(comment)
                     }
                         completionHandler(comments)
                     
                 }
             
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
     }
     
    
}
