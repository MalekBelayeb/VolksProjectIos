//
//  UserRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/20/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON
import ObjectMapper


class UserRepository:NSObject {
    
    let user = User()

    /*
    func getOne(parameters: [String: AnyObject], completionHandler: @escaping (AnyObject?, NSError?) -> ()) {
        PerformRequestgetOne(username: "",completionHandler: completionHandler)
    }
    
    func PerformRequestgetOne(username : String,  completionHandler: (AnyObject?, NSError?) -> ()) -> Void {
        
       let url = "http://192.168.1.7:3003/users/get/"+username
        Alamofire.request(url,method: .get,encoding:JSONEncoding.default).responseJSON { (responseData) -> Void in
        
            let user = User()

            
             if((responseData.result.value) != nil) {
                let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                
                self.user.username = swiftyJsonVar!.arrayValue[0]["username"].string!
                self.user.password = swiftyJsonVar!.arrayValue[0]["password"].string!
                self.user.firstName =  swiftyJsonVar!.arrayValue[0]["first_name"].string
                self.user.lastName = swiftyJsonVar!.arrayValue[0]["last_name"].string
                self.user.email = swiftyJsonVar!.arrayValue[0]["email"].string
                self.user.address = swiftyJsonVar!.arrayValue[0]["address"].string
                self.user.id = swiftyJsonVar!.arrayValue[0]["id"].int
                self.user.phoneNumber = swiftyJsonVar!.arrayValue[0]["phone_number"].int64
                print(self.user.password)
                
             }
            
         }
        
    }*/
    
    private static var instance: UserRepository?

    public static func getInstance() -> UserRepository{
        if(instance == nil){
            instance = UserRepository()
        }
        return instance!
    }
    
    func getUser(username: String, completionHandler: @escaping (_ user: User) -> ()) {
        let url = Helper.ENDPOINT+"users/get/"+username
        
        AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success:
                let swiftyJsonVar = try? JSON(data:responseData.data!)
            
                if(swiftyJsonVar!.arrayValue.count > 0)
                {
            let user = User()
            user.username = swiftyJsonVar!.arrayValue[0]["username"].string!
            user.password = swiftyJsonVar!.arrayValue[0]["password"].string ?? ""
            
            user.partner =  swiftyJsonVar!.arrayValue[0]["partner"].string ?? ""
    user.address = swiftyJsonVar!.arrayValue[0]["address"].string ?? ""
            user.birthDate = swiftyJsonVar!.arrayValue[0]["birth_date"].string ?? ""
            user.id = swiftyJsonVar!.arrayValue[0]["id"].int
            
        user.sexe = swiftyJsonVar!.arrayValue[0]["sexe"].string ?? ""

            user.job = swiftyJsonVar!.arrayValue[0]["job"].string ?? ""
            
                    print(user)
                completionHandler(user)
                    return
                }
            
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    
    
    
    }
    
    
    func userExist(username: String, completionHandler: @escaping (_ user: Int) -> ()) {
         let url = Helper.ENDPOINT+"users/get/"+username
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
     
    
     func getImage(completionHandler: @escaping (_ user: [User]) -> ()) {
     
         let url = Helper.ENDPOINT+"upload/malek"
        
         AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
             switch responseData.result {
             case .success:
                 let swiftyJsonVar = try? JSON(data:responseData.data!)
           
                 
                    print("---------------####")
                    print(swiftyJsonVar!.arrayValue)
                 
                 if(swiftyJsonVar!.arrayValue.count > 0)
                 {
                        

                    
                    var users : [User] = []
                     for i in 0...swiftyJsonVar!.arrayValue.count-1
                     {
                       
                        
               

                     let user = User()
                     
                         //   user.username = swiftyJsonVar!.arrayValue[i]["username"].string!
                    // user.password = swiftyJsonVar!.arrayValue[i]["password"].string!
                    // user.firstName =  swiftyJsonVar!.arrayValue[i]["first_name"].string!
                    // user.lastName = swiftyJsonVar!.arrayValue[i]["last_name"].string!
                    // user.email = swiftyJsonVar!.arrayValue[i]["email"].string!
                    // user.address = swiftyJsonVar!.arrayValue[i]["address"].string!
                    // user.id = swiftyJsonVar!.arrayValue[i]["id"].int
                    // user.phoneNumber = swiftyJsonVar!.arrayValue[i]["phone_number"].int64!
            
                         users.append(user)
                     }
                         completionHandler(users)
                     
                 }
             
                 break
             case .failure(let error):
                 print(error)
                 break
             }
         })
     }
    
    
    func getUsers(completionHandler: @escaping (_ user: [User]) -> ()) {
    
        let url = Helper.ENDPOINT+"users/getAll"
       
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
                   // user.password = swiftyJsonVar!.arrayValue[i]["password"].string!
                   // user.firstName =  swiftyJsonVar!.arrayValue[i]["first_name"].string!
                   // user.lastName = swiftyJsonVar!.arrayValue[i]["last_name"].string!
                   // user.email = swiftyJsonVar!.arrayValue[i]["email"].string!
                   // user.address = swiftyJsonVar!.arrayValue[i]["address"].string!
                   // user.id = swiftyJsonVar!.arrayValue[i]["id"].int
                   // user.phoneNumber = swiftyJsonVar!.arrayValue[i]["phone_number"].int64!
           
                        users.append(user)
                    }
                        completionHandler(users)
                    
                }
            
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    func addUser(user: User, userImage: UIImage, completionHandler: @escaping () -> ()) {
        let url = Helper.ENDPOINT+"users/add"

        
        //11111111
      /*  AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(userImage.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "send.png", mimeType: "image/png")
 /*
            multipartFormData.append(String(user.username!).data(using: .utf8)!, withName: "username", mimeType: "text/json")
            multipartFormData.append(String(user.password!).data(using: .utf8)!, withName: "password", mimeType: "text/plain")*/
                   
            let usernameData = try! JSONSerialization.data(withJSONObject: user.username!, options: [])
            let usernameJsonString = String(data: usernameData, encoding: .utf8)!
            multipartFormData.append(usernameJsonString.data(using: .utf8)!, withName: "username")
         
            let passwordData = try! JSONSerialization.data(withJSONObject: user.password!, options: [])
            let passowrdJsonString = String(data: passwordData, encoding: .utf8)!
            multipartFormData.append(passowrdJsonString.data(using: .utf8)!, withName: "password")

            
        }, to:url){ (result) in
            switch result {
            case .success( let upload, _, _):
                upload.responseString(completionHandler: { (response) in
    
                })
            case .failure(let encodingError):
                print("",encodingError.localizedDescription)

                break
            }
        }*/
    }
    
    
    func add(user:User, completionHandler: @escaping (_ response: Data) -> ())
    {
        let parameters = [
        "username": user.username!,
        "password": user.password!,
        "sexe":user.sexe,
        "birth_date":user.birthDate,
        "job":user.job,
        "number_children":0,
        "number_children_disabilities":0
            ] as [String : Any]
     
        AF.request(Helper.ENDPOINT+"users/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    
    func update(user:User, completionHandler: @escaping (_ response: Data) -> ())
    {
        let parameters = [
        "username": user.username!,
        "email":user.email,
        "address":user.address,
        "first_name":user.firstName,
        "last_name":user.lastName,
        "phone_number":user.phoneNumber,
        "job":user.job,
        "birth_date":user.birthDate,
            "partner":user.partner
            ] as [String : Any]
     
        AF.request(Helper.ENDPOINT+"users/updateForIos", method:.put , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
    
    
     func updatePartner(user:User, completionHandler: @escaping (_ response: Data) -> ())
     {
         let parameters = [
         "username": user.username!,
         "partner":user.partner
             ] as [String : Any]
      
         AF.request(Helper.ENDPOINT+"users/updatePartner", method:.put , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
         
             completionHandler(responseData.data!)
         
         })
         
         }
     
     func remove(username:String, completionHandler: @escaping (_ response: Data) -> ())
    {
      
        AF.request(Helper.ENDPOINT+"users/delete/"+username, method:.delete ,encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
        
            completionHandler(responseData.data!)
        
        })
        
        }
        
    }
    
    
    
    
    


