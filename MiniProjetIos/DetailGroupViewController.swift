//
//  DetailGroupViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class DetailGroupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    
    var posts : [Post] = []
    var groupName : String = ""
    var user = User()

   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
   
       textField.resignFirstResponder()
       
   return true
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                
            let contentView = cell.viewWithTag(0)

            let usernameLabel = contentView?.viewWithTag(1) as! UILabel
            let contentLabel = contentView?.viewWithTag(2) as! UILabel
            
            usernameLabel.text = posts[indexPath.row].username
            contentLabel.text = posts[indexPath.row].description
                
                
    return cell
    }
    

    
    @IBOutlet weak var groupNameLabel: UILabel!
    
    
    @IBOutlet weak var postNumberLabel: UILabel!
    
    @IBOutlet weak var memberNumberLabel: UILabel!
    
    
    @IBOutlet weak var usernamePostEditText: UILabel!
    @IBOutlet weak var postEditText: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    
    @IBAction func manageAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToAdmins", sender: self)
        
    }
    
    @IBAction func invitationsAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToGroupInvitation", sender: self)
        
    }
    
    
    
    
    @IBAction func postAction(_ sender: Any) {
        
        let post = Post()
        
        post.groupName = groupName
        
        post.username = user.username!
        
        post.description = self.postEditText.text!
        
        PostRepository.getInstance().addPostGroup(post: post, completionHandler: {
            data in
            if(data.count == 21)
            {
                PostRepository.getInstance().getPostsGroup(name: self.groupName, completionHandler: {posts in
                       
                       self.posts = posts
                       self.tableView.reloadData()
                       
                   })
            }
            
        })
        
    }
    
    @IBOutlet weak var askForAMembership: UIButton!
    
    @IBOutlet weak var invitationButton: UIButton!
    
    @IBOutlet weak var manageButton: UIButton!
    
    
    
    @IBAction func askForMembershipAction(_ sender: Any) {
        
        
        let invitation = Invitation()
        invitation.sender = user.username!
        invitation.receiver = groupName
        invitation.type = "GROUP"
        invitation.content = "A request for a membership sent by "+user.username!
        InvitationRepository.getInstance().add(invitation: invitation) { (data) in
            
            if(data.count == 21)
            {
            
                self.askForAMembership.setTitle("Waiting for a confirmation ...", for: .normal)
                self.askForAMembership.isEnabled = false
            }
            
        }
        
    }
    
    
    @IBOutlet weak var usernameConnected: UILabel!
    
    @IBOutlet weak var imageConnected: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameConnected.text = user.username!
        
        postEditText.delegate = self
        tableView.isHidden = true
        askForAMembership.isHidden = false
        invitationButton.isHidden = true
        manageButton.isHidden = true
        tableView.isHidden = true

  
        
        UserGroupRepository.getInstance().getUserByUsernameAndRole(username: user.username!,groupName: groupName) { users in
            if(type(of: users) == UserGroup.self)
            {
                if(users.role == "ADMIN")
                {
                  
                  self.invitationButton.isHidden = false
                  self.askForAMembership.isHidden = true
                  self.tableView.isHidden = false
                  self.manageButton.isHidden = true
               
                    
                }else if(users.role == "USER") {
                    
                  self.invitationButton.isHidden = true
                  self.askForAMembership.isHidden = true
                  self.tableView.isHidden = false
                  self.manageButton.isHidden = true
       
                }else{
                    
                    print("iiiiiiiii")
                }
                
                // self.hideAndShow(value: false)

            }else{
                
               // print("iiiiiiiiiiiiii")
                
                        self.invitationButton.isHidden = true
                         self.askForAMembership.isHidden = false
                         self.tableView.isHidden = true
                         self.manageButton.isHidden = true
            
            }
        
        }
        
        
        GroupRepository.getInstance().getGroupsByCreator(creator: user.username!) { groups in
            
            for g in groups {
                
                if(g.name == self.groupName)
                {
                    self.manageButton.isHidden = false
                    self.askForAMembership.isHidden = true
                    
                    self.invitationButton.isHidden = false
                    
                    self.tableView.isHidden = false
                    
                }
            }
            
        }
        
        
        
        InvitationRepository.getInstance().getInvitation(sender: user.username!, receiver: groupName, completionHandler:
            {invitations in
                if(invitations.count > 0)
                {
                    self.askForAMembership.setTitle("Waiting for a confirmation ...", for: .normal)
                               self.askForAMembership.isEnabled = false
                      
                }
                
        }
                
                
        )
        
        
        
        
        
        PostRepository.getInstance().getPostsGroup(name: self.groupName, completionHandler: {posts in
            
            self.postNumberLabel.text = String(posts.count)
        })
        
        
        UserGroupRepository.getInstance().getUserByGroupName(groupName: groupName, completionHandler: {
            users in
            self.memberNumberLabel.text = String(users.count)
            
        })
        
        
        
        groupNameLabel.text = groupName
        
        PostRepository.getInstance().getPostsGroup(name: groupName, completionHandler: {posts in
            
            self.posts = posts
            self.tableView.reloadData()
            
        })
        
        
        // Do any additional setup after loading the view.
    }
    

        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.


        if(segue.identifier == "MoveToGroupInvitation")
        {
            
            let destination = segue.destination as! InvitationGroupViewController
            destination.groupName = self.groupName
        }else if (segue.identifier == "MoveToAdmins")
        {
            let destination = segue.destination as! ManageAdminViewController
            destination.groupName = self.groupName

            
        }

    }
    

}
