//
//  UserInvitationViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class UserInvitationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

       var invitations : [Invitation] = []
     
        var user = User()
    var newuser = User()
    
     var invitation = Invitation()
     
    @IBOutlet weak var tableView: UITableView!

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return  invitations.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        
        if(invitations[indexPath.row].type == "PARTNERSHIP")
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellule2",for: indexPath)
            

            let contentView = cell.viewWithTag(0)
            let usernameLabel = contentView?.viewWithTag(1) as! UILabel
                
           let acceptBtn = contentView?.viewWithTag(2) as! UIButton
  
           let declineBtn = contentView?.viewWithTag(3) as! UIButton
        
            usernameLabel.text = invitations[indexPath.row].sender
                           
           self.invitation = invitations[indexPath.row]
                   
            acceptBtn.addTarget(self, action:#selector(acceptPartnerInvitation), for: .touchUpInside)
                       
            declineBtn.addTarget(self, action:#selector(declineTrigg), for: .touchUpInside)

            
            return cell

        }else{
            
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                                 
                 let contentView = cell.viewWithTag(0)

                  let usernameLabel = contentView?.viewWithTag(1) as! UILabel
           
                 let acceptBtn = contentView?.viewWithTag(2) as! UIButton
        
                 let declineBtn = contentView?.viewWithTag(3) as! UIButton
               
                   usernameLabel.text = invitations[indexPath.row].sender
                   
                   self.invitation = invitations[indexPath.row]
                   
                   acceptBtn.addTarget(self, action:#selector(acceptTrigg), for: .touchUpInside)
                   
                    declineBtn.addTarget(self, action:#selector(declineTrigg), for: .touchUpInside)
                       
            return cell

        }
        
           
       }
       
    
    
    @objc func acceptPartnerInvitation(sender:UIButton)
    {
      
            self.newuser.username = self.invitation.sender
            self.newuser.partner = self.invitation.receiver
                    
            UserRepository.getInstance().updatePartner(user:  self.newuser , completionHandler: { data in
                
                
            })
            
             self.newuser.username = self.invitation.receiver
             self.newuser.partner = self.invitation.sender
                   
            UserRepository.getInstance().updatePartner(user: self.newuser, completionHandler: {
                data in
                
            })
            
            InvitationRepository.getInstance().remove(receiver: self.invitation.receiver, sender: self.invitation.sender, completionHandler: {data in })
                  
              InvitationRepository.getInstance().getInvitationByReceiver(receiver: user.username!, completionHandler: {invit in
                  
                  self.invitations = invit
                  
                  self.tableView.reloadData()
              })
            
                
    }
    
    @objc func declinePartnerInvitation(sender:UIButton)
    {
                InvitationRepository.getInstance().remove(receiver: self.invitation.receiver, sender: self.invitation.sender, completionHandler: {data in })
                      
            InvitationRepository.getInstance().getInvitationByReceiver(receiver: user.username!, completionHandler: {invit in
                      
              self.invitations = invit
                      
              self.tableView.reloadData()
                  })
        
    }
    
    
    
    @objc func acceptTrigg(sender:UIButton)
         {
           
           let userGroup = UserGroup()
            userGroup.username = user.username!
           userGroup.groupeName = invitation.sender
            userGroup.role = "ADMIN"
           
            UserGroupRepository.getInstance().add(userGroup: userGroup, completionHandler: {data in
                
                if(data.count == 21 )
                {
                    InvitationRepository.getInstance().remove(receiver: self.invitation.receiver, sender: self.invitation.sender, completionHandler: {data in })
                
                }
                    
            })
      
           InvitationRepository.getInstance().getInvitationByReceiver(receiver: user.username!, completionHandler: {invit in
               
               self.invitations = invit
               
               self.tableView.reloadData()
           })
           
           
         }
       
       @objc func declineTrigg(sender:UIButton)
         {
             
            InvitationRepository.getInstance().remove(receiver: self.invitation.receiver, sender: self.invitation.sender, completionHandler: {data in })
               
           InvitationRepository.getInstance().getInvitationByReceiver(receiver: user.username!, completionHandler: {invit in
               
               self.invitations = invit
               
               self.tableView.reloadData()
           })
           
         }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InvitationRepository.getInstance().getInvitationByReceiver(receiver: user.username!, completionHandler: {invit in
            
            self.invitations = invit
            
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
