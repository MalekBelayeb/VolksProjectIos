//
//  InvitationGroupViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class InvitationGroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var invitations : [Invitation] = []
    
    var groupName :  String = ""
    
    var invitation = Invitation()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  invitations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    

    @objc func acceptTrigg(sender:UIButton)
      {
        
        let userGroup = UserGroup()
        userGroup.username = invitation.sender
        userGroup.groupeName = invitation.receiver
        userGroup.role = "USER"
        
        
        UserGroupRepository.getInstance().add(userGroup: userGroup, completionHandler: {data in
            
            if(data.count == 21)
            {
                
                InvitationRepository.getInstance().remove(receiver: self.invitation.receiver, sender:self.invitation.sender, completionHandler: {data in
                   
                    
                    
                    })
                
                InvitationRepository.getInstance().getInvitationByReceiver(receiver: self.groupName, completionHandler: {invitations in
                    
                    self.invitations = invitations
                    
                    self.tableView.reloadData()
                    
                })
                
            }
            
        })
        
        
      }
    
    @objc func declineTrigg(sender:UIButton)
      {
          
     InvitationRepository.getInstance().remove(receiver: self.invitation.receiver, sender:self.invitation.sender, completionHandler: {data in
                    
 
                })
        
        
        InvitationRepository.getInstance().getInvitationByReceiver(receiver: self.groupName, completionHandler: {invitations in
            
            self.invitations = invitations
            
            self.tableView.reloadData()
            
        })
        
        
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        InvitationRepository.getInstance().getInvitationByReceiver(receiver: groupName, completionHandler: {invitations in
            
            self.invitations = invitations
            
            self.tableView.reloadData()
            
        })

        
        

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
