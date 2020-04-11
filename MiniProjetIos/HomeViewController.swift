//
//  HomeViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/19/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ExpandingMenu

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    var x = 0
    var user = User()
    
    @IBOutlet weak var rightTrailling: NSLayoutConstraint!
    
    @IBOutlet weak var leftLeading: NSLayoutConstraint!
    

    var menuOut = false
    let appdelegate = UIApplication.shared.delegate as!  AppDelegate

    
    @IBAction func eventsAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToEvent", sender: self)
        
    }
    
    @IBAction func groupAction(_ sender: Any) {
        performSegue(withIdentifier: "MoveToGroups", sender: self)
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    var posts : [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                   
                   let contentView = cell.viewWithTag(0)

                    let usernameLabel = contentView?.viewWithTag(1) as! UILabel
        let descriptionTextView = contentView?.viewWithTag(2) as! UILabel
        let imageProfile = contentView?.viewWithTag(3) as! UIImageView
        imageProfile.makeItRound()

        ImageRepository.getInstance().downloadImages(username: posts[indexPath.row].username, completionHandler: {image in
          
          imageProfile.image = image
              
          })
        
        
        
        usernameLabel.text = posts[indexPath.row].username
        descriptionTextView.text = posts[indexPath.row].description
             
        return cell
    }
    
    @IBAction func invitationShow(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToUserInvitations", sender: self)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = Post()
        post.id = posts[indexPath.row].id
        post.username = posts[indexPath.row].username
        post.description = posts[indexPath.row].description
        
        performSegue(withIdentifier: "MoveToPost", sender: post)
        
    }
    
    
    
    @IBOutlet weak var invitationOutlet: UIButton!
    
    
    
    
    @IBOutlet weak var inboxOutlet: UIButton!
    
    @IBAction func inboxOnClick(_ sender: Any) {
        
        
        performSegue(withIdentifier: "MoveToInbox", sender: self)
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        

    
    }
    
    
    @IBAction func profileAction(_ sender: Any) {
        print("ssssssss")
    
        self.performSegue(withIdentifier: "MoveToProfile", sender: self)
        
            
    }
    
    
    
    
    
    @IBAction func addPostAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToAddPost", sender: user)
        
        
    }
    
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

        if(segue.identifier == "MoveToProfile")
        {
        
        let destination = segue.destination as! ParentProfileViewController
        destination.user = self.user
        
        }else if ( segue.identifier == "MoveToPost" )
        {
            let post = sender as! Post
            let destination = segue.destination as! PostViewController
            destination.post = post
            destination.user = self.user
            
        }else if (segue.identifier == "MoveToAddPost")
        {
            
            let destination = segue.destination as! AddPostViewController
              destination.user = self.user
            
        }else if (segue.identifier == "MoveToGroups")
        {
            let destination = segue.destination as! GroupViewController
            
            destination.user = self.user
            
            
        }else if(segue.identifier == "MoveToUserInvitations")
        {
            
            let destination = segue.destination as! UserInvitationViewController
            destination.user = self.user
            
        }
        else if (segue.identifier == "MoveToEvent")
        {
            let destination = segue.destination as! EventViewController
            destination.connectedUsername = self.user.username!
            
        }else if(segue.identifier == "MoveToInbox")
        {
            let destination = segue.destination as! InboxViewController
            destination.connectedUsename = self.user.username!
            
        }
    
    
    
    }

    
    
    @IBAction func showSideMenu(_ sender: Any) {
        
        print("ssssss")
               
               if(menuOut == false)
               {
                   leftLeading.constant = 150
                   rightTrailling.constant = -150
                   menuOut = true
                   
                   
               }else{
                   leftLeading.constant = 0
                           rightTrailling.constant = 0
                           menuOut = false
                   
               }
               
               UITableView.animate(withDuration: 0.2,delay: 0.0,options: .curveEaseIn, animations: {
                   
                   self.tableview.layoutIfNeeded()
                   
               })
             
        
        
    }
    
    
    
    
  
    
    
    
    @IBAction func addBtnAction(_ sender: Any) {
        
        
        performSegue(withIdentifier: "MoveToAddPost", sender: user)
        
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
               
            
      PostRepository.getInstance().getPosts(completionHandler: {postsList in
     
        
            print(postsList)
            self.posts = postsList
        self.tableview.reloadData()
            
        })
        
        
        
        InvitationRepository.getInstance().getInvitationByReceiver(receiver: self.user.username!, completionHandler: {
             invitations in
             
     self.invitationOutlet.setTitle("  Invitation("+String(invitations.count)+")", for: .normal)
                   
         })
        
        
        DiscussionController.getInstance().getDiscussions(connectedUsername: user.username!,completionHandler: {
            
            finalList in
            self.inboxOutlet.setTitle("  Inbox("+String(finalList.count)+")", for: .normal)
        
        })
        
        
    }
  

    
    
 
    

}
