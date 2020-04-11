//
//  PostRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/5/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class PostRepository
{
    
    
     private static var instance: PostRepository?

     public static func getInstance() -> PostRepository{
         if(instance == nil){
             instance = PostRepository()
         }
         return instance!
     }
    
    func getPosts(completionHandler: @escaping (_ user: [Post]) -> ()) {
      
          let url = Helper.ENDPOINT+"posts/getAll"
         
          AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
              switch responseData.result {
              case .success:
                  let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                  if(swiftyJsonVar!.arrayValue.count > 0)
                  {
                            var posts : [Post] = []
                      for i in 0...swiftyJsonVar!.arrayValue.count-1
                      {
                          
                      let post = Post()
              
                        post.id =  swiftyJsonVar!.arrayValue[i]["id"].int!
                        
                          post.username = swiftyJsonVar!.arrayValue[i]["username"].string!

                        post.description = swiftyJsonVar!.arrayValue[i]["description"].string!

                        
                          posts.append(post)
                      }
                          completionHandler(posts)
                      
                  }
              
                  break
              case .failure(let error):
                  print(error)
                  break
              }
          })
      }
    
    
    func add(post:Post, completionHandler: @escaping (_ response: Data) -> ())
      {
          let parameters = [
          "username": post.username,
          "description": post.description
              ] as [String : Any]
       
        
          AF.request(Helper.ENDPOINT+"posts/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
          
              completionHandler(responseData.data!)
          
          })
          
          }
    
        
    
    func addPostGroup(post:Post, completionHandler: @escaping (_ response: Data) -> ())
      {
          let parameters = [
            "username": post.username,
            "group_name": post.groupName,
            "description":post.description
              ] as [String : Any]
       
        
          AF.request(Helper.ENDPOINT+"group_post/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
          
              completionHandler(responseData.data!)
          
          })
          
         }
    
    
    
        func getPostNumber( username:String,completionHandler: @escaping (_ postsList: Int) -> ()) {
         
             let url = Helper.ENDPOINT+"posts/getAll/"+username
            
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
    
    
    func getPostByUsername(username : String,completionHandler: @escaping (_ post: [Post]) -> ()) {
    
        let url = Helper.ENDPOINT+"posts/getAll/"+username
       
        AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success:
                let swiftyJsonVar = try? JSON(data:responseData.data!)
          
                if(swiftyJsonVar!.arrayValue.count > 0)
                {
                          var posts : [Post] = []
                    for i in 0...swiftyJsonVar!.arrayValue.count-1
                    {
                        
                    let post = Post()
                    
            post.username = swiftyJsonVar!.arrayValue[i]["username"].string!
            post.description = swiftyJsonVar!.arrayValue[i]["description"].string!
                        
                        posts.append(post)

                    }
                        completionHandler(posts)
                    
                }
            
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    
    func getPostsGroup(name:String,completionHandler: @escaping (_ user: [Post]) -> ()) {
      
          let url = Helper.ENDPOINT+"group_post/getByGroup/"+name
         
          AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
              switch responseData.result {
              case .success:
                  let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                  if(swiftyJsonVar!.arrayValue.count > 0)
                  {
                            var posts : [Post] = []
                      for i in 0...swiftyJsonVar!.arrayValue.count-1
                      {
                          
                      let post = Post()
              
                        post.id =  swiftyJsonVar!.arrayValue[i]["id"].int!
                        
                          post.username = swiftyJsonVar!.arrayValue[i]["username"].string!

                        post.description = swiftyJsonVar!.arrayValue[i]["description"].string!

                        
                          posts.append(post)
                      }
                          completionHandler(posts)
                      
                  }
              
                  break
              case .failure(let error):
                  print(error)
                  break
              }
          })
      }
    
    
}
