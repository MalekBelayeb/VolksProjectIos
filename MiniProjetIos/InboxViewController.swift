//
//  InboxViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/14/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var msgList: [Message] = []
    
    var connectedUsename : String = ""
    
    var usernameMovedTo : String = ""
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        msgList.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
        let contentView = cell.viewWithTag(0)
     
        
        let username = contentView?.viewWithTag(1) as! UILabel
     
        let message = contentView?.viewWithTag(2) as! UITextView
            

        if(msgList[indexPath.row].receiver == connectedUsename)
        {
            username.text = msgList[indexPath.row].sender
            
        }else{
            username.text = msgList[indexPath.row].receiver

        }
        
        message.text = msgList[indexPath.row].message
        return cell
    }
    
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
      
        
        
        
        if(msgList[indexPath.row].receiver == connectedUsename)
             {
                 self.usernameMovedTo = msgList[indexPath.row].sender
                 
             }else{
                 self.usernameMovedTo = msgList[indexPath.row].receiver

             }
        
        performSegue(withIdentifier: "MoveToDiscussion", sender: self)

         
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           DiscussionController.getInstance().getDiscussions(connectedUsername: connectedUsename,completionHandler: {
               
               finalList in
            
            self.msgList = finalList
            self.tableView.reloadData()
           
           })

    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "MoveToDiscussion")
        {
        
        let destination = segue.destination as! ChatViewController
                          
      destination.connectedUsername = connectedUsename
          destination.username = usernameMovedTo
     }
    
    
    }
    
}
