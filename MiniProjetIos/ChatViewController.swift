//
//  ChatViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON


extension UITableView {

    func scrollToBottom(){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    let appdelegate = UIApplication.shared.delegate as!  AppDelegate

    var manager = SocketManager(socketURL: URL(string: Helper.ENDPOINTSOCKET)!)
    		
    var messages : [Message] = []
    

    var socket:SocketIOClient!
    
    
    var connectedUsername = ""
    var username = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendMessage: UIButton!
   
    @IBOutlet weak var messageOutlet: UITextField!
    
    @IBAction func sendMessage(_ sender: Any) {
        
    //let timestamp = NSDate().timeIntervalSince1970

        socket.emit("messagedetection",with: [connectedUsername,username,self.messageOutlet.text!])
        
        
     //   if(self.messages.count>1){
            
            
            //self.tableView.scrollToBottom()
                
       // }
       
        
        // self.appdelegate.sendPushNotifications(to: username, message: self.connectedUsername+": "+self.messageOutlet.text!)
        self.messageOutlet.text = ""
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
    return true
    }
    
    func receiveMessageSocketEvent()
    {
        
    self.socket.on("message") 	   { data , ack in
              
     let v = data[0] as! Dictionary<String,AnyObject>
        	 print(type(of: data[0]))
          
        let message = v["message"]! as! String
     
        let sender = v["senderNickname"]! as! String
       
        let receiver = v["receiverNickname"]! as! String
        
        let msg = Message()
        msg.message = message
        msg.receiver = receiver
        msg.sender = sender
        
        self.messages.append(msg)
        self.tableView.reloadData()
        self.tableView.scrollToBottom()
        
    }
       // s
    
    }
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
                
        if(self.messages[indexPath.row].sender == connectedUsername)
        {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell",for: indexPath)
                                            
                    let contentView = cell.viewWithTag(0)

                    let usernameLabel = contentView?.viewWithTag(1) as! UILabel
                    
                usernameLabel.text = messages[indexPath.row].message

                return cell
            
        }else{
            
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                                        
                let contentView = cell.viewWithTag(0)

                let usernameLabel = contentView?.viewWithTag(1) as! UILabel
                usernameLabel.text = messages[indexPath.row].message
                return cell
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket = manager.defaultSocket
      
        socket.emit("connection", connectedUsername)
        self.messageOutlet.delegate = self
        
        self.socket.connect()
        self.receiveMessageSocketEvent()
       

        print("messages")
        
        MessageRepository.getInstance().getMessages(connectedUsername: connectedUsername, username: username, completionHandler: {
            
            messages in
                  print(messages)
            
            self.messages = messages
            self.tableView.reloadData()
       
        })
 
        // Do any additional setup after loading the view.
    }
	


    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
