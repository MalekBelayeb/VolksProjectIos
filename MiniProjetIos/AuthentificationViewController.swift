//
//  AuthentificationViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/20/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit
import Parse
import FacebookLogin
import FacebookCore
import FBSDKCoreKit

extension UIImageView{
    
    func makeItRound(){
         self.layer.borderWidth = 2
         self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.systemPink.cgColor
         self.layer.cornerRadius = self.frame.height/2
         self.clipsToBounds = true
    }
    
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension String {
  func replace(string:String, replacement:String) -> String {
      return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
  }

  func removeWhitespace() -> String {
      return self.replace(string: " ", replacement: "")
  }
}

class AuthentificationViewController: UIViewController,UITextFieldDelegate,LoginButtonDelegate {
    
    
    
  let appdelegate = UIApplication.shared.delegate as!  AppDelegate

    
    
    @IBOutlet weak var usernameOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var rememberMeOutlet: UISwitch!
    
    let loginButton = FBLoginButton(frame: CGRect(x: 25, y: 400, width: 320, height: 50), permissions: [.publicProfile])
    
    
    	
    
    @IBAction func rememberMeAction(_ sender: Any) {
        
    }
    
    
    var username :String = ""
    
    @IBAction func authentificateAction(_ sender: Any) {

    
        if(usernameOutlet.text! != "" && passwordOutlet.text! != "")
        {
            
            UserRepository.getInstance().getUser(username: usernameOutlet.text!, completionHandler:{  user in
                
                if(type(of: user) == User.self)
                {
                    if(user.password! == self.passwordOutlet.text!  )
                               {
                                
                                                       // self.appdelegate.saveUserToServer(username: user.username!)
                        
                                self.moveToHome(user: user)
                                
                                if(self.rememberMeOutlet.isOn)
                                {
                                
                    SessionUtils.getInstance().updateSession(username: user.username!, rememberme: 1)
                                    
                                }
                    
                    }
                
                }else {
                    
                    SessionUtils.getInstance().add(user: user)
                 //   self.appdelegate.saveUserToServer(username: user.username!)
                        
                                self.moveToHome(user: user)
                                
                                if(self.rememberMeOutlet.isOn)
                                {
                                
                    SessionUtils.getInstance().updateSession(username: user.username!, rememberme: 1)
                                    
                                }
                    
                    
                    
                }
                
                
               })
                  
            
        }
        
        
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        
    return true
    }
    
    
    
    func initView ()
    {
        rememberMeOutlet.isOn = false
    }


   /*   func askToSendPushnotifications()
       {
       // print(   SessionUtils.getInstance().getAllSession())
        
        if(SessionUtils.getInstance().getSession(rememberme: 1).count > 0)
        {
            SessionUtils.getInstance().updateSession(username: SessionUtils.getInstance().getSession(rememberme: 1)[0].username!, isconnected: 1)
            self.username = SessionUtils.getInstance().getSession(rememberme: 1)[0].username!
        performSegue(withIdentifier: "MoveToHome", sender: self)
        
        }
        
    }*/
    
    func askToSendPushnotifications() {
        let alertView = UIAlertController(title: "Send a push to the news channel", message: nil, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
            //self.sendPushNotifications()
        }
        alertView.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
        }
        
        alertView.addAction(cancelAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }

    func sendPushNotifications(to:String,message:String) {
        let cloudParams : [AnyHashable:String] = ["username":to,"message":message]
     PFCloud.callFunction(inBackground: "pushsample", withParameters: cloudParams, block: {
               (result: Any?, error: Error?) -> Void in
               if error != nil {
                   if let descrip = error?.localizedDescription{
                       print(descrip)
                   }
               }else{
                   print(result as! String)
               }
           })
    }
    

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
         print("User Logged In")

         if ((error) != nil)
         {
             // Process error
         }
         else if result!.isCancelled {

         }
         else {
            
        print("User Succeffuly logged")
            
            
        fetchForFBProfile()
            
            
        }
        
    }
    
    
    
    
//MARK:- fetchForFbProfile
    func fetchForFBProfile()
    {
    
        let myGraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, birthday, age_range, picture.width(400), gender"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
        myGraphRequest.start(completionHandler: { (connection, result, error) in
            if let res = result {
                var responseDict = res as! [String:Any]
                
                let fullName = responseDict["name"] as! String
                let firstName = responseDict["first_name"] as! String
                let lastName = responseDict["last_name"] as! String
                let email = responseDict["email"] as! String
                let idFb = responseDict["id"] as! String
                let pictureDict = responseDict["picture"] as! [String:Any]
                let imageDict = pictureDict["data"] as! [String:Any]
                let imageUrl = imageDict["url"] as! String
                
                print("user id: \(idFb), firstName: \(firstName), fullname: \(fullName), lastname: \(lastName), picture: \(imageUrl), email: \(email)")
                
                
            
                UserRepository.getInstance().userExist(username: fullName.removeWhitespace(), completionHandler: {
                    
                    value in
                    if(value == 1)
                    {
                    
                        UserRepository.getInstance().getUser(username: fullName.removeWhitespace(), completionHandler: {
                            user in
                            let user1 = User()
                                                 user1.username = fullName.removeWhitespace()
                                                 user1.password = ""
                            
                            self.moveToHome(user: user1)
                            
                  

                        })
                        
                                     
                        
                    }else{
                        
                        let user = User()
                        user.username = fullName.removeWhitespace()
                        user.password = ""
                        
                        
                        UserRepository.getInstance().add(user: user, completionHandler: {
                            data in
                            
                            if(data.count == 21)
                            {
                 
                                self.moveToHome(user: user)

                                             
                            }
                            
                            
                                }
                            )
                        
                        
                        
                    }
                    


                })
                
                
                
        }
        })
   
 
    }
            
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
                print("User logged out")
    }
    

    
    func moveToHome(user:User)
    {
        
        SessionUtils.getInstance().add(user: user)
                              
        SessionUtils.getInstance().updateSession(username: user.username!, isconnected: 1)
        self.username = user.username!
                             
        performSegue(withIdentifier: "MoveToHome", sender: user)
        
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var tempList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        usernameOutlet.delegate = self
        passwordOutlet.delegate = self
        loginButton.delegate = self
        
        self.view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 325).isActive = true

        UserGroupRepository.getInstance().getUserByUsernameAndRole(username: "akthem", groupName: "jjj", completionHandler: {user in
            print("ssssssssssssss")
            print(user)
        })
        
     
        /* for i in SessionUtils.getInstance().getAllSession(){
            
            SessionUtils.getInstance().deleteSession(username: i.username!)
            
        }*/
        
       // self.sendPushNotifications(to: "malek", message: "yeeeeeesss")
        
        print("----------------->")
        
        UserRepository.getInstance().getUser(username: "malek", completionHandler: {
            data in
            print(data.toJSONString()!)
            
        })
        
        
   
        //appdelegate.sendPushNotification()
    /*    ImageRepository.getInstance().downloadImages(username: Helper.ENDPOINT+"uploads/malek", completionHandler: {image in
            self.imageView.image = image
        })
        */
        //self.sendPushNotifications()
       // appdelegate.sendPushNotification()
        if let accessToken = AccessToken.current{
            
            print("User connected")
            print(accessToken)
        
            self.fetchForFBProfile()
        }
    
        
        //print(SessionUtils.getInstance().getAllSession())
       // sendPushNotifications()
/*        let user = User(username: "eeeee", password: "qqqq",firstName: "sqsd",lastName: "ddd",email: "qdd",address: "ssss",phoneNumber: 555)
  */
       
        //SessionUtils.getInstance().deleteSession(username: "abcc")
        
        //print(SessionUtils.getInstance().getAllSession())
        
        /* UserRepository.getInstance().addUser(user: user, userImage: UIImage(named: "edit.png")!, completionHandler:
            {
            
            */
        
      /*  UserRepository.getInstance().upload(image: UIImage(named: "edit.png")!, progressCompletion: { res in
            print(res)
            
            
        }, completion: {
            
        })*/
     
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if( segue.identifier == "MoveToHome")
        {
         

            var destination = segue.destination as! HomeViewController

            print("----------->"+username)
            

            destination.user = SessionUtils.getInstance().getConnectedUser(username: self.username)
            
            
            
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

}
