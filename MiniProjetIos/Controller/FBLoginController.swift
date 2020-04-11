//
//  FBLoginController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/11/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation



class FBLoginController
{

    
    
    
    func checkForUserAndAddIfNeeded(username:String)
    {
        
        UserRepository.getInstance().getUser(username: username, completionHandler: {
            user in
            
            
            
        })
        
        
        
        
    }
    
    
    
    
}
