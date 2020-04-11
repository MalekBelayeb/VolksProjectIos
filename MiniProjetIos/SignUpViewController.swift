//
//  SignUpViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/21/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let sexe : [String] = ["Male","Female"]
    
    var selectedSexe = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sexe.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sexe[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.selectedSexe = sexe[row]
    
    }
    
    
    @IBOutlet weak var birthDateOutlat: UIDatePicker!
    var usernameTest = 0
    var passwordTest = 0
    @IBOutlet weak var usernameOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    
    @IBOutlet weak var sexeOutlet: UIPickerView!
    
    
    @IBOutlet weak var signUpOutlet: UIButton!
    
    
    
    @IBOutlet weak var continueToProfile: UIButton!

    var tempUser = User()
    
    var dateString = ""
    
    
    
    
    
    @IBAction func dateChanged(_ sender: Any) {
        
         let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = DateFormatter.Style.short
              dateFormatter.dateFormat = "yyyy/MM/dd"
              let strDate = dateFormatter.string(from: birthDateOutlat.date)
              self.dateString = strDate
    }
    
    
    
    func updateButtonSignUp()
    {
        
        if( usernameTest + passwordTest == 2 )
        {
            signUpOutlet.isHidden = false
            
        }else{
            
            signUpOutlet.isHidden = true
            
        }
    }
    
    @IBAction func usernameEditingChanged(_ sender: Any) {
        if( usernameOutlet.text!.count == 0 )
        {
            usernameTest = 0
        
        }else{
        
            usernameTest = 1

        }
        
        updateButtonSignUp()
    }
    
    @IBAction func passwordEditingChanged(_ sender: Any) {
        
               if(passwordOutlet.text!.count == 0)
               {
                   passwordTest = 0

              
               }else{
                   
                   passwordTest = 1

        }
               
               
               updateButtonSignUp()
    }
    
    
    @IBAction func signUpAction(_ sender: Any) {
    
        
        let user = User(username: usernameOutlet.text ?? "" , password: passwordOutlet.text ?? "",firstName: "",lastName: "",email: "",address: "",phoneNumber: 0)
        user.sexe = selectedSexe
        user.birthDate =   self.dateString
        user.job = ""
        user.partner = ""
        
        print(self.dateString)
        print(selectedSexe)
        print(user.username!)
        UserRepository.getInstance().add(user: user,completionHandler: { response in
           
          if(response.count == 21)
          {
            self.usernameOutlet.text = ""
            self.passwordOutlet.text = ""
         SessionUtils.getInstance().add(user: user)
            self.tempUser = user
            self.continueToProfile.isHidden = false
            self.signUpOutlet.isHidden = true
            self.continueToProfile.frame = self.signUpOutlet.frame
            
            }
            
        })
        

    }
    
    @IBAction func continueToProfileAction(_ sender: Any) {
        
        SessionUtils.getInstance().updateSession(username: tempUser.username!, isconnected: 1)
        performSegue(withIdentifier: "SignUpToProfile", sender: self.tempUser)
        
    }
    
    
    func initView()  {
        continueToProfile.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        updateButtonSignUp()
  
        usernameOutlet.delegate = self
       
        passwordOutlet.delegate = self
       
     
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
    return true
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let user = sender as! User
        let destination = segue.destination as! ParentProfileViewController
        destination.user = user
        
    }

}
