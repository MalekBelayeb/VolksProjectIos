//
//  ProfileViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/19/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var user = User()
    
    
    @IBOutlet weak var usernameOutlet: UILabel!
    
    @IBOutlet weak var sexeOutlet: UILabel!
 
    @IBOutlet weak var birthDateOutlet: UILabel!
    
    @IBOutlet weak var adressOutlet: UILabel!
    
    @IBOutlet weak var jobOutlet: UILabel!
    
    @IBOutlet weak var partnerOutlet: UILabel!
    
    @IBOutlet weak var childrenNumber: UILabel!
    
    
    @IBOutlet weak var childrenNumberOutlet: UILabel!
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBAction func childrenAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToChildren", sender: self)
        
    }
    
    func initProfile()
    {
    
        usernameOutlet.text = user.username

        UserRepository.getInstance().getUser(username: user.username!, completionHandler: {user in
            
            self.sexeOutlet.text = user.sexe
            self.birthDateOutlet.text = DateHandler.getInstance().getCleanDate(date: user.birthDate)
            self.jobOutlet.text = user.job
            self.partnerOutlet.text = user.partner
            self.adressOutlet.text = user.address
        
        })
        
        ChildrenRepository.getInstance().getChildrensByParent(username: user.username!, completionHandler: {childrens in
            
            self.childrenNumber.text = String(childrens.count)
         
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
      ImageRepository.getInstance().downloadImages(username: user.username!, completionHandler: {image in
        
        self.imageProfile.makeItRound()
        self.imageProfile.image = image
            
        })
        
        initProfile()
        print(user.username!)
        //print(SessionUtils.getInstance().getAllSession())
        
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "MoveToChildren")
        {
            let destination = segue.destination as! ChildrenViewController
            destination.connectedUsername = self.user.username!
        }
        
    }
   

}
