//
//  DiscussionController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/14/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import Foundation



class DiscussionController{
    
    private static var instance: DiscussionController?

        public static func getInstance() -> DiscussionController{
            if(instance == nil){
                instance = DiscussionController()
            }
            return instance!
        }
    
    

    
    func getDiscussions(connectedUsername: String,completionHandler: @escaping (_ user: [Message]) -> ())
    {
        var senderMessages : [Message] = []
        var receiverMessages : [Message] = []
        var finalList : [Message] = []
        
        
        var senderUsernamesList : [String] = []
        var receiverUsernamesList : [String] = []

        MessageRepository.getInstance().getDiscussions(connectedUsername: connectedUsername, completionHandler: {messages in
            
            for message in messages
            {
                if(message.sender == connectedUsername)
                {
                    senderMessages.append(message)
                    senderUsernamesList.append( message.sender)
                }
                
                if(message.receiver == connectedUsername)
                {
                    receiverMessages.append(message)
                    receiverUsernamesList.append( message.receiver)
                }
            
            
            }
            
            for sMessage in senderMessages
            {
            
                for rMessage in receiverMessages
                {
                    
                    if(sMessage.receiver == rMessage.sender)
                    {
                        if(sMessage.id > rMessage.id){
                            
                            finalList.append(sMessage)
                            
                        }else{
                            
                            finalList.append(rMessage)
                        
                        }
                        
                    }
                    
                    
                    

                    
                }
                
            }
            
            
            completionHandler(finalList)

            
            
            
        })
        
        
    }
    
    
}
