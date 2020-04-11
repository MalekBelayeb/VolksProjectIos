//
//  AddPostViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/5/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var descriptionEdit: UITextField!
    
    @IBOutlet weak var addOutlet: UIButton!
    
    var user = User()
    
    @IBAction func addAction(_ sender: Any) {
        
        let post = Post()
        post.username = user.username!
        post.description = descriptionEdit.text!
        
        PostRepository.getInstance().add(post: post, completionHandler: {data in

            if(data.count == 21)
            {
                self.performSegue(withIdentifier: "ReturnToHome", sender: self)
            }
         
        })
        
    }
    
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
         textField.resignFirstResponder()
         
     return true
     }
     

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        
        if(segue.identifier == "ReturnToHome" )
        {
        
            let destination = segue.destination as! HomeViewController
            destination.user = self.user
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionEdit.delegate = self
        
        usernameLabel.text = user.username!
        

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
