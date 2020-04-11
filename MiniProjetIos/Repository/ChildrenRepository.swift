//
//  ChildrenRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/13/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChildrenRepository
{
    
    private static var instance: ChildrenRepository?

    public static func getInstance() -> ChildrenRepository{
        if(instance == nil){
            instance = ChildrenRepository()
        }
        return instance!
    }
    
    
    func add(children:Children, completionHandler: @escaping (_ response: Data) -> ())
     {
         let parameters = [
            "name": children.name,
            "birthday": children.birthday,
         "sexe":children.sexe,
         "parent":children.parent,
         "description":children.description,
         "disease":children.disease
             ] as [String : Any]
      
         AF.request(Helper.ENDPOINT+"children/add", method:.post , parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
         
             completionHandler(responseData.data!)
         
         })
         
         }

    
    func getChildrensByParent(username : String ,completionHandler: @escaping (_ user: [Children]) -> ()) {
    
        let url = Helper.ENDPOINT+"children/getByParent/"+username
       
        AF.request(url,method: .get,encoding:JSONEncoding.default).responseJSON(completionHandler: { (responseData) -> Void in
            switch responseData.result {
            case .success:
                let swiftyJsonVar = try? JSON(data:responseData.data!)
          
                if(swiftyJsonVar!.arrayValue.count > 0)
                {
                          var childrens : [Children] = []
                    for i in 0...swiftyJsonVar!.arrayValue.count-1
                    {
                        
                    let children = Children()
                    
                        
                        children.id = swiftyJsonVar!.arrayValue[i]["id"].int ?? -1
                                                
                              children.name = swiftyJsonVar!.arrayValue[i]["name"].string!
                              children.parent = swiftyJsonVar!.arrayValue[i]["parent"].string ?? ""
                               
                              children.description =  swiftyJsonVar!.arrayValue[i]["description"].string ?? ""
                              children.birthday = swiftyJsonVar!.arrayValue[i]["birthday"].string ?? ""
                              children.sexe = swiftyJsonVar!.arrayValue[i]["sexe"].string ?? ""
                              
                               children.disease = swiftyJsonVar!.arrayValue[i]["disease"].string ?? ""
                            
           
                        childrens.append(children)
                    }
                        completionHandler(childrens)
                    
                }
            
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
}
