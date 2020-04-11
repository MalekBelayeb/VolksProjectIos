//
//  SessionRepository.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/21/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import Foundation
import CoreData
import  UIKit



class SessionUtils:UIViewController  {

    let appdelegate = UIApplication.shared.delegate as!  AppDelegate
    
    private static var instance: SessionUtils?

    public static func getInstance() -> SessionUtils{
        if(instance == nil){
            instance = SessionUtils()
        }
        return instance!
    }
    
    public func add(user:User) {

        
        if(getSession(username:user.username!).count == 0)
        {
        
      let context = appdelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.insertNewObject(forEntityName: "UserSession", into: context)
     
            entity.setValue(user.username!, forKey: "username")
            entity.setValue(0, forKey: "isconnected")
            entity.setValue(0, forKey: "rememberme")
            entity.setValue(user.address, forKey: "address")
            entity.setValue(user.partner, forKey: "partner")
            entity.setValue(user.job, forKey: "job")
               entity.setValue(user.sexe, forKey: "sexe")
            entity.setValue(user.birthDate, forKey: "birth_date")




        
             do {
        
                try context.save()
            
             }catch{
                 
             }
            }
     }
    
    public func getSession(username: String) -> [UserSession]
    {
        let context = appdelegate.persistentContainer.viewContext
              
        var data = [UserSession]()
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")

              fetchRequest.returnsObjectsAsFaults = false

              fetchRequest.predicate = NSPredicate(format: "username == %@",username)

              data = try! context.fetch(fetchRequest) as! [UserSession]
            
       return data
    }
    
    
    public func getSession(isconnected: Int16) -> [UserSession]
    {
        let context = appdelegate.persistentContainer.viewContext
              
        var data = [UserSession]()
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")

              fetchRequest.returnsObjectsAsFaults = false

              fetchRequest.predicate = NSPredicate(format: "isconnected == %@",String(isconnected))

              data = try! context.fetch(fetchRequest) as! [UserSession]
            
       return data
    }
    
    public func getSession(rememberme: Int16) -> [UserSession]
    {
        let context = appdelegate.persistentContainer.viewContext
              
        var data = [UserSession]()
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")

              fetchRequest.returnsObjectsAsFaults = false

              fetchRequest.predicate = NSPredicate(format: "rememberme == %@",String(rememberme))

              data = try! context.fetch(fetchRequest) as! [UserSession]
            
       return data
    }
    
    public func getSession(username:String,isconnected: Int16) -> [UserSession]
    {
        let context = appdelegate.persistentContainer.viewContext
              
        var data = [UserSession]()
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")

              fetchRequest.returnsObjectsAsFaults = false

              fetchRequest.predicate = NSPredicate(format: "isconnected == %@",String(isconnected))
        fetchRequest.predicate = NSPredicate(format: "username == %@",username)

              data = try! context.fetch(fetchRequest) as! [UserSession]
            
       return data
    }
    
    public func getAllSession() -> [UserSession]
    {
        let context = appdelegate.persistentContainer.viewContext
              
        var data = [UserSession]()
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")

              fetchRequest.returnsObjectsAsFaults = false

              data = try! context.fetch(fetchRequest) as! [UserSession]
            
       return data
    }
    
    
    public func updateSession(username: String,isconnected:Int16)
    {

        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest :NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserSession")
        fetchRequest.predicate = NSPredicate(format: "username == %@",username)
        do
        {
            let test = try context.fetch(fetchRequest)
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(isconnected, forKey: "isconnected")
                
            do{
                try context.save()
            }catch{
                print(error)
            }
            
        }catch
        {
            print(error)
        }
        
        
    }
    
      
    public func updateSessionForUser(user :User)
      {

          let context = appdelegate.persistentContainer.viewContext
          let fetchRequest :NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserSession")
        fetchRequest.predicate = NSPredicate(format: "username == %@",user.username!)
          do
          {
              let test = try context.fetch(fetchRequest)
                  let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(user.address, forKey: "address")
            
            objectUpdate.setValue(user.partner, forKey: "partner")
              
            objectUpdate.setValue(user.job, forKey: "job")
            objectUpdate.setValue(user.birthDate, forKey: "birth_date")

              
            do{
                  try context.save()
              }catch{
                  print(error)
              }
              
          }catch
          {
              print(error)
          }
          
          
      }
      
      
    
    public func updateSession(username: String,rememberme:Int16)
    {

        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest :NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserSession")
        fetchRequest.predicate = NSPredicate(format: "username == %@",username)
        do
        {
            let test = try context.fetch(fetchRequest)
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(rememberme, forKey: "rememberme")
                
            do{
                try context.save()
            }catch{
                print(error)
            }
            
        }catch
        {
            print(error)
        }
        
        
    }
    
    
    public func deleteSession(username: String)
    {

        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest :NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserSession")
        fetchRequest.predicate = NSPredicate(format: "username == %@",username)
        do
        {
            let test = try context.fetch(fetchRequest)
                let objectToDelete = test[0] as! NSManagedObject
                context.delete(objectToDelete)
            
            do{
                try context.save()
            }catch{
                print(error)
            }
            
        }catch
        {
            print(error)
        }
        
        
    }
    

    
    public func getConnectedUser(username : String ) -> User
    {
        let sessionUser = getSession(username: username,isconnected: 1)
        
        
        if(!sessionUser.isEmpty)
        {

            print( sessionUser[0])
            let user = User()
           
                user.username = sessionUser[0].username!

            if( sessionUser[0] .birth_date == nil)
            {
                user.birthDate = ""
            }else{
                user.birthDate = sessionUser[0] .birth_date!

            }
            
            if(sessionUser[0].address == nil)
            {
                user.address = ""
            }else{
                user.address = sessionUser[0].address!
            }
            
            if(sessionUser[0].job == nil)
            {
                user.job = ""
                
            }else {
                
                user.job = sessionUser[0].job!
            }
            
            if( sessionUser[0].sexe == nil)
            {
                user.sexe = ""
            
            }else {
                
                user.sexe = sessionUser[0].sexe!
            }
            
            if( sessionUser[0].partner == nil )
            {
                user.partner = ""
            }else {
                
                user.partner = sessionUser[0].partner!

            }
            
                
            return user
        
        }else{
            
            return User()
        
        }

    }
    

}
