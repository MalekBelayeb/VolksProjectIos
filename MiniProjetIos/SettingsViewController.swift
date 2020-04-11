//
//  SettingsViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/21/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit

class SettingsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate	 {
    
    var user = User()
    
    let fb = LoginManager()
    
    var selectedImage = UIImage()

    @IBOutlet weak var newFirstNameOutlet: UITextField!
    
    @IBOutlet weak var uploadImage: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var newLastNameOutlet: UITextField!
    
    
    @IBOutlet weak var newAddressOutlet: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newEmailOutlet: UITextField!

    
    @IBOutlet weak var changeAction: UIButton!
    
    @IBOutlet weak var newAdress: UITextField!
    
    
    @IBOutlet weak var newJob: UITextField!
    
    
    @IBOutlet weak var newDate: UIDatePicker!
    
    @IBOutlet weak var newPartner: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateString = ""
    
    
    
    
    
    
    @IBAction func moveToSearch(_ sender: Any) {
        
        
        performSegue(withIdentifier: "MoveToSearch", sender: self)
        
    }
    
    
    
    
    
    
    
    @IBAction func changeAction(_ sender: Any) {
        
        let newUser = user
        newUser.address = newAdress.text!
        newUser.job = newJob.text!
        newUser.birthDate = DateHandler.getInstance().getCleanDate(date: dateString)
        
        //print(newUser.birthDate)
        
        UserRepository.getInstance().update(user: newUser, completionHandler: {
            response in
            if(response.count == 19)
            {
                
                
                SessionUtils.getInstance().updateSessionForUser(user: newUser)
                
            }
            
        })
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        self.progressView.isHidden = false
        
        
        ImageRepository.getInstance().uploadImage(img: selectedImage, imageName: user.username!, progressView: self.progressView,uploadButton: self.uploadImage)
        
        
    }
    
    @IBAction func changeImage(_ sender: Any) {
        
        self.showActionSheet()

    }
    
    func camera()
    {
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)

    }

    func gallery()
    {

        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)

    }
    
    
    
    @IBAction func newDate(_ sender: Any) {

        let dateFormatter = DateFormatter()
                   dateFormatter.dateStyle = DateFormatter.Style.short
                   dateFormatter.dateFormat = "yyyy/MM/dd"
                   let strDate = dateFormatter.string(from: datePicker.date)
        self.dateString = DateHandler.getInstance().getCleanDate(date: strDate)

    }
    
    
    
    
    func showActionSheet(){

        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
        { action -> Void in
            self.camera()
        }
        actionSheetController.addAction(saveActionButton)

        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            guard let selectedImage = info[.originalImage] as? UIImage else {
               fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
           }

           imageView.image = selectedImage
        self.uploadImage.isHidden = false
        
        self.selectedImage = selectedImage
           dismiss(animated: true, completion: nil)
       }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newAdress.text = user.address
        newJob.text = user.job
        newPartner.text = user .partner
        dateString = DateHandler.getInstance().getCleanDate(date: user.birthDate)
        
        let date = DateHandler.getInstance().fromStringToDate(date: DateHandler.getInstance().getCleanDate(date: user.birthDate))
        datePicker.setDate(date, animated: true)
        
        
        
       // newLastNameOutlet.text = user.lastName
       // newAddressOutlet.text = user.address
       // newEmailOutlet.text = user.email
        self.progressView.isHidden = true
        self.uploadImage.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAccountAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirmation...", message: "Are you sure do you want to delete your account ?", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                 switch action.style{
                 case .default:
                    UserRepository.getInstance().remove(username: self.user.username!, completionHandler: {
                     data in

                    print(data.count)
                    if(data.count == 19)
                    {
                        SessionUtils.getInstance().updateSession(username: self.user.username!, isconnected: 0)
                                           SessionUtils.getInstance().updateSession(username: self.user.username!, rememberme: 0)
                                           self.performSegue(withIdentifier: "MoveToSignIn", sender: self)
                                       
                    }
                 
                 })
                   
                 case .cancel:
                       print("cancel")

                 case .destructive:
                       print("destructive")

               }}))
          alert.addAction(UIAlertAction(title: "Cancel", style: .default ))
          
           self.present(alert, animated: true, completion: nil)
          
          
        
    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        SessionUtils.getInstance().updateSession(username: user.username!, isconnected: 0)
        SessionUtils.getInstance().updateSession(username: user.username!, rememberme: 0)
        fb.logOut()

        performSegue(withIdentifier: "MoveToSignIn", sender: self)
        
    }
    
    
  
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if(segue.identifier == "MoveToSearch")
        {
            
            let destination = segue.destination as! PartnerSearchViewController
            destination.connectedUsername = user.username!
            
        }
    
    
    
    }
    

}
