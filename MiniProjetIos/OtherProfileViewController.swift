//
//  OtherProfileViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/5/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class OtherProfileViewController: UIViewController {

    
    var user = User()
    var x = 0
    var username : String = ""
    var userMovedTo : String = ""
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var postsOutlet: UILabel!
    @IBOutlet weak var followingOutlet: UILabel!
    @IBOutlet weak var followersOutlet: UILabel!
    
    @IBOutlet weak var followOutlet: UIButton!
    
    
    
    @IBOutlet weak var sexeOutlet: UILabel!
    
    @IBOutlet weak var birthdayOutlet: UILabel!
    
    
    @IBOutlet weak var addressOutlet: UILabel!
    
    
    @IBOutlet weak var jobOutlet: UILabel!
    
    @IBOutlet weak var partnerOutlet: UILabel!
    
   var y = 0
    
    
    func initProfile()
    {
    

        UserRepository.getInstance().getUser(username: userMovedTo, completionHandler: {user in
            
            self.sexeOutlet.text = user.sexe
            self.birthdayOutlet.text = DateHandler.getInstance().getCleanDate(date: user.birthDate)
            self.jobOutlet.text = user.job
            self.partnerOutlet.text = user.partner
            self.addressOutlet.text = user.address
        
        })
        
       /* ChildrenRepository.getInstance().getChildrensByParent(username: user.username!, completionHandler: {childrens in
            
            self.childrenNumber.text = String(childrens.count)
         
            
        })*/
        
    }
    
    
    @IBAction func childrenOnClick(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToOtherChildren", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initProfile()
        PostRepository.getInstance().getPostNumber(username: userMovedTo, completionHandler: {num in
            
            self.postsOutlet.text = String(num)
        })
        initAndRefreshView()
        initFollow()
        UserRepository.getInstance().getUser(username:userMovedTo, completionHandler: {user in
            
            
            self.usernameLabel.text = user.username!
        
            
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func followersAction(_ sender: Any) {
        
        self.y = 1

        performSegue(withIdentifier: "MoveToOtherList", sender: self)
        
        
    }
    
    @IBAction func followingAction(_ sender: Any) {
        
        self.y = 2

        performSegue(withIdentifier: "MoveToOtherList", sender: self)
        
    }
    
    @IBAction func followAction(_ sender: Any) {
        
        updateFollow()
    }
    
    @IBAction func moveToMyPosts(_ sender: Any) {
        
        
        performSegue(withIdentifier: "MoveToMyPost", sender: self)
        
    }
    
    func initAndRefreshView()
    {
        
         FollowRepository.getInstance().getFollows(username: userMovedTo, completionHandler: {numberOfFollowing in
          
              self.followingOutlet.text = String(numberOfFollowing)
          }
              
          )
          
          FollowRepository.getInstance().getFollowing(following: userMovedTo) { numberOfFollowers in
        
              self.followersOutlet.text = String(numberOfFollowers)
              
          }
          
    }
    
    
    func initFollow()
    {
        FollowRepository.getInstance().getFollow(following: self.userMovedTo, username: user.username!) { followingCount in
            
            if(followingCount==0)
            {
               
                self.x = 2
                self.followOutlet.setTitle("Follow", for: .normal)

            }else{

                self.x = 1
                self.followOutlet.setTitle("Unfollow", for: .normal)


            }
            
            
            
        }
    }
    
    
    func updateFollow()
    {
        
        x+=1
        
        if(x%2 == 0)
        {

            FollowRepository.getInstance().remove(following: self.userMovedTo, username: user.username!, completionHandler: {
                data in

                if(data.count == 19)
                {
                    
                    self.initAndRefreshView()
                    self.followOutlet.setTitle("Follow", for: .normal)
                          
                }

            })
            
              
        }else{
            

            FollowRepository.getInstance().getFollow(following: self.userMovedTo, username: user.username!, completionHandler: {followers in
            
                if(followers == 0)
                {
                    
                         let follow = Follow()
                                        follow.username = self.user.username!
                                        follow.following = self.userMovedTo
                                        FollowRepository.getInstance().add(follow: follow, completionHandler: {data in

                                         if(data.count == 21){

                                             self.followOutlet.setTitle("Unfollow", for: .normal)
                                            self.initAndRefreshView()

                                         }
                                         
                                        
                                        })
                }
                
            })
     
            
            
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    @IBOutlet weak var chatOutlet: UIButton!
    
    @IBAction func chatAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToChat", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "MoveToMyPost")
        {
            
        
            let destination = segue.destination as! MyPostViewController
            
            destination.username = self.userMovedTo
            
            
        }else if (segue.identifier == "MoveToChat" )
        {
            let destination = segue.destination as! ChatViewController
                    
            destination.connectedUsername = user.username!
                destination.username = userMovedTo
            
        }else if (segue.identifier == "MoveToOtherChildren")
        {
            
            let destination = segue.destination as! OtherChildrenViewController
                      
          destination.username = self.userMovedTo
                   
            
        }else if (segue.identifier == "MoveToOtherList")
        {
            
            let destination = segue.destination as! OtherListViewController
                              
                  destination.username = self.userMovedTo
                  destination.x = self.y
               
        }
        
    }
    
    
}
