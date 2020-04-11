//
//  AddGroupViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit
import SearchTextField
	
class AddGroupViewController: UIViewController,UITextFieldDelegate	 {

    
    @IBOutlet weak var groupName: UITextField!

    
    var mySearchTextField = SearchTextField()


    // Set the array of strings you want to suggest
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var adminTextField: UITextField!
    
    var user = User()
    
    
    let suggestions = [ "red", "orange", "yellow", "green", "blue", "purple" ]

    @IBAction func addGroup(_ sender: Any) {
        
        var group = Group()
        group.name = groupName.text!
        group.description = descriptionTextField.text!
        group.creator = user.username!
        GroupRepository.getInstance().add(group: group, completionHandler: {data in
            if(data.count == 21 )
            {
                self.performSegue(withIdentifier: "ReturnToGroup", sender: self)
                
            }
            
        })
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
    return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mySearchTextField = SearchTextField(frame: CGRect(x: 40, y: 40, width: 40, height: 40))
        mySearchTextField.filterStrings(["Red", "Blue", "Yellow"])
        self.view.addSubview(mySearchTextField)
        
        groupName.delegate  = self
        descriptionTextField.delegate = self
        adminTextField.delegate = self
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
