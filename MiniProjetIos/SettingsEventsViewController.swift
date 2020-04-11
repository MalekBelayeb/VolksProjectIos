//
//  SettingsEventsViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class SettingsEventsViewController: UIViewController {

    
    var event = Event()
    
    @IBOutlet weak var descriptionEvent: UITextField!
    
    @IBOutlet weak var cityEvent: UITextField!
    
    @IBOutlet weak var stateEvent: UITextField!
    
    @IBOutlet weak var countryEvent: UITextField!
    
    @IBOutlet weak var dateEvent: UIDatePicker!
    
    @IBOutlet weak var updateBtnOutlet: UIButton!
    
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    
    
    @IBAction func updateBtnAction(_ sender: Any) {
        
        event.description = descriptionEvent.text!
        event.country = countryEvent.text!
        event.place = cityEvent.text!
        event.state = stateEvent.text!
        
        EventRepository.getInstance().update(event: event, completionHandler: {data in
            
            if(data.count == 19){
                
                self.performSegue(withIdentifier: "ReturnToProfile", sender: self)
            }
            
        })
        
    }
    
    @IBAction func deleteBtnAction(_ sender: Any) {
 
        let alert = UIAlertController(title: "Confirmation...", message: "Are you sure do you want to delete your event ?", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                           
                            EventRepository.getInstance().remove(name: self.event.name, completionHandler: {data in
                                
                                if(data.count == 19)
                                {
                                    self.performSegue(withIdentifier: "ReturnToEvent", sender: self)
                                }
                                
                            })
                          
                        case .cancel:
                              print("cancel")

                        case .destructive:
                              print("destructive")

                        @unknown default:
                            print("")
                            
                    }}))
                 alert.addAction(UIAlertAction(title: "Cancel", style: .default ))
                 
                  self.present(alert, animated: true, completion: nil)
              
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()



        descriptionEvent.text = event.description
        cityEvent.text = event.place
        stateEvent.text = event.state
        countryEvent.text = event.country

    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if(segue.identifier == "ReturnToEvent")
        {
            
            let destination = segue.destination as! EventViewController
            destination.connectedUsername = event.creator
            
        }else if (segue.identifier == "ReturnToProfile")
        {
            
            let destination = segue.destination as! EventProfileViewController
            destination.event = event
            destination.connectedUsername = event.creator
        }



    }
   

}
