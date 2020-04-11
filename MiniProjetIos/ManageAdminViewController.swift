//
//  ManageAdminViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class ManageAdminViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var admins : [User] = []
    
    var groupName : String = ""
    
    var username : String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return admins.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                    
                let contentView = cell.viewWithTag(0)

                let usernameLabel = contentView?.viewWithTag(1) as! UILabel
        let btn = contentView?.viewWithTag(2) as! UIButton
           
                usernameLabel.text = admins[indexPath.row].username!
        self.username = admins[indexPath.row].username!
        
        btn.addTarget(self, action:#selector(deleteTrigg), for: .touchUpInside)
            
        
        return cell
    }
    

    @IBOutlet weak var usernameAdmin: UITextField!
    
    
    @IBAction func addAdmin(_ sender: Any) {
        
        let invitation = Invitation()
        invitation.sender = groupName
        invitation.receiver = usernameAdmin.text!
        invitation.type = "ADMIN"
        invitation.content = "The creator of group want you to join to his group and become an administrator"
        
        InvitationRepository.getInstance().add(invitation: invitation, completionHandler: {
            data in
            
            if(data.count == 21)
            {
                self.usernameAdmin.text = ""
            }
            
            
        })
        
    }
    
    
    
    
       @objc func deleteTrigg(sender:UIButton)
         {
            UserGroupRepository.getInstance().remove(username: username, groupName: groupName, completionHandler: {data in
                
                
            })
            
            UserGroupRepository.getInstance().getUserByGroupNameAndRole(groupeName: groupName, role: "ADMIN", completionHandler: {
                       users in
                   
                       self.admins = users
                       self.tableView.reloadData()
                       
                   })
           
         }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
    return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        usernameAdmin.delegate = self
        UserGroupRepository.getInstance().getUserByGroupNameAndRole(groupeName: groupName, role: "ADMIN", completionHandler: {
            users in
        
            self.admins = users
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
