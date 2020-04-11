//
//  EventProfileViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class EventProfileViewController: UIViewController {

    
    
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    @IBOutlet weak var eventAdressLabel: UILabel!
    
    var event = Event()
    var connectedUsername = ""
    var x = 1
    var adress = ""
    
    @IBOutlet weak var eventSettingsOutlet: UIButton!
    
    @IBAction func eventSettingsAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToSettingsEvent", sender: self)

        
    }

    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var mapVIewEvent: UIButton!
    
    
    @IBAction func showMapView(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToMap", sender: self)
        
    }

    
    @IBOutlet weak var participateOutlet: UIButton!

    @IBAction func participateAction(_ sender: Any) {
        updateView()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        eventNameLabel.text = event.name
        eventDescriptionLabel.text = event.description
        adress = event.place+","+event.state+","+event.country
        eventDate.text = DateHandler.getInstance().getCleanDate(date: event.strDate)
        eventAdressLabel.text = adress
        if(event.creator == connectedUsername)
        {
            self.eventSettingsOutlet.isHidden = false
            self.participateOutlet.isHidden = true
        }else{
     
              self.eventSettingsOutlet.isHidden = true
               self.participateOutlet.isHidden = false
            self.initView()
            
        }
    }
    
    func initView( )
    {
        
        EventUserRepository.getInstance().getEventUser(eventName: event.name, username: connectedUsername, completionHandler: {events in
            
            if(events.count > 0)
            {
                
                self.showQuit()
                self.x = 2
                
            }else{
                
                self.showParticipate()
                self.x = 3
            }
            
        })
        
        
    }
    
    
    func updateView(){
        
        x = x+1
        
        if(x%2 == 0)
        {

            let eventUser = EventUser()
            eventUser.eventName = self.event.name
            eventUser.username = self.connectedUsername
            EventUserRepository.getInstance().add(event: eventUser, completionHandler: {
                data in
            
                if(data.count == 21)
                {
                    self.showQuit()
                            
                }
                
            })
            
            
        }else{
            
            EventUserRepository.getInstance().remove(eventName: event.name, username: connectedUsername, completionHandler: {
                data in
                if(data.count == 19)
                {
                    self.showParticipate()

                }
            })
            
        }
        
        
    }
    
    func showParticipate(){
        
        
        self.participateOutlet.setTitleColor(UIColor.systemBlue, for: .normal)
        self.participateOutlet.setTitle("Participate", for: .normal)
        self.participateOutlet.isHidden = false
        
    }

    func showQuit(){
    
        self.participateOutlet.setTitleColor(UIColor.red, for: .normal)
    
        self.participateOutlet.setTitle("Quit", for: .normal)
       self.participateOutlet.isHidden = false
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "MoveToMap")
        {
            let destination = segue.destination as! MapViewController
            destination.address = event.country+","+event.state+","+event.place
        }else if (segue.identifier == "MoveToSettingsEvent")
        {
            let destination = segue.destination as! SettingsEventsViewController
            destination.event = event
        }


    }

}
