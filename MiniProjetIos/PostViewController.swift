//
//  PostViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/5/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class PostViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
   
    var comments : [Comment] = []
    
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var commentTextView: UITextField!
    
    @IBOutlet weak var usernameBtnOutlet: UIButton!
    
    var username : String = ""
    var postDescription : String = ""
    var post = Post()
    var user = User()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
            
        let contentView = cell.viewWithTag(0)

        let usernameBtn = contentView?.viewWithTag(1) as! UIButton
        let commentTextView = contentView?.viewWithTag(2) as! UILabel
        usernameBtn.setTitle(comments[indexPath.row].username, for: .normal)
        commentTextView.text = comments[indexPath.row].comment
        
            usernameBtn.addTarget(self, action:#selector(triggBtn), for: .touchUpInside)
        
        
        return cell
    }

    @IBAction func usernameAction(_ sender: Any) {
      
        
        self.username = usernameBtnOutlet.currentTitle!
        
        performSegue(withIdentifier: "MoveToOtherProfile", sender: self)
        
    }
   
  @objc func triggBtn(sender:UIButton)
    {
        
        self.username = sender.currentTitle!
        print("--------#performSegue "+String(user.username!))

        performSegue(withIdentifier: "MoveToOtherProfile", sender: self)

    }
    
    
    @IBAction func commentAction(_ sender: Any) {
        
        let comment = Comment()
        comment.username = user.username!
        comment.post = post.id
        comment.comment = commentTextView.text!
        CommentRepository.getInstance().add(comment: comment, completionHandler: {data in
            
            if(data.count == 21)
            {

                CommentRepository.getInstance().getUsers(post: self.post.id, completionHandler: {
                    comments in
                    self.comments = comments
                    self.tableView.reloadData()
                })

                self.commentTextView.text = ""
                
            }
            
        })
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "MoveToOtherProfile")
        {
            
            print("--------#Prepare "+String(user.username!))

            let destination = segue.destination as! OtherProfileViewController
            

            
            destination.userMovedTo = self.username

         
          
            destination.user = self.user
            
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            textField.resignFirstResponder()
            
        return true
        }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameBtnOutlet.setTitle(post.username, for: .normal)
        postDescriptionLabel.text = post.description
 
        CommentRepository.getInstance().getUsers(post: post.id, completionHandler: {
            comments in
            self.comments = comments
            self.tableView.reloadData()
        })
        
        commentTextView.delegate = self
    
        print("--------#ViewDidLoad "+String(user.username!))
        
    }
    

}
