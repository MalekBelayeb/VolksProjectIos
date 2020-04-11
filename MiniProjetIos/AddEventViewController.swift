//
//  AddEventViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController,UITextFieldDelegate {

    var connectedUsername = ""

    
    @IBOutlet weak var eventNameTextField: UITextField!
    
    
    @IBOutlet weak var descriptionEventTextField: UITextField!
    
    @IBOutlet weak var cityEventTextField: UITextField!
    
    @IBOutlet weak var stateEventTextField: UITextField!
    
    @IBOutlet weak var countryEventTextField: UITextField!
    
    @IBOutlet weak var createBtnEvent: UIButton!
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
         textField.resignFirstResponder()
         
     return true
     }
    
    @IBOutlet weak var dateEvent: UIDatePicker!

    var dateString = ""

    @IBAction func dateEventChanged(_ sender: Any) {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short

        dateFormatter.dateFormat = "yyyy/MM/dd"
        let strDate = dateFormatter.string(from: dateEvent.date)
        self.dateString = strDate
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        
        
        if(dateString == "")
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short

            dateFormatter.dateFormat = "yyyy/MM/dd"
            let strDate = dateFormatter.string(from: dateEvent.date)

            dateString = strDate
        }
        
        let event = Event()
        event.name = eventNameTextField.text!
        event.description = descriptionEventTextField.text!
        event.place = cityEventTextField.text!
        event.country = countryEventTextField.text!
        event.state = stateEventTextField.text!
        event.creator = connectedUsername
        event.strDate = self.dateString
    
        
        EventRepository.getInstance().add(event: event, completionHandler: {data in
            
            if(data.count == 21)
            {
            
                self.eventNameTextField.text = ""
                self.descriptionEventTextField.text = ""
                self.cityEventTextField.text = ""
                self.countryEventTextField.text = ""
                self.stateEventTextField.text = ""
                
            }
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      eventNameTextField.delegate = self
        descriptionEventTextField.delegate = self
        cityEventTextField.delegate = self
      countryEventTextField.delegate = self
      stateEventTextField.delegate = self
           
        
        
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
