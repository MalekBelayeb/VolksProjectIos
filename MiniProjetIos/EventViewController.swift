//
//  EventViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class EventViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate  {
  
    
    
    var todayEvents : [Event] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return todayEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell",for: indexPath)
                           
                           let contentView = cell.viewWithTag(0)
        
        let eventImageView = contentView?.viewWithTag(1) as! UIImageView
               
                            let eventnameLabel = contentView?.viewWithTag(2) as! UILabel
        
        eventnameLabel.text = todayEvents[indexPath.row].name
        
        //   groupnameLabel.text = group[indexPath.row].name
        //   descriptionLabel.text = "group[indexPath.row].description"
           
           return cell
      
    
    
    }
    
    
    
    
    var events : [Event] = []
    @IBOutlet weak var tableView: UITableView!
    var connectedUsername = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if(events[indexPath.row].creator == connectedUsername)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellule2",for: indexPath)
                               let contentView = cell.viewWithTag(0)
                             let eventName = contentView?.viewWithTag(2) as! UILabel
                             let eventDescription = contentView?.viewWithTag(3) as! UILabel
             let eventDate = contentView?.viewWithTag(4) as! UILabel
                             eventName.text = events[indexPath.row].name
                             eventDescription.text = events[indexPath.row].description
                   eventDate.text = DateHandler.getInstance().getCleanDate(date: events[indexPath.row].strDate) 
            
            return cell
            
        }else{
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                     let contentView = cell.viewWithTag(0)
                   let eventName = contentView?.viewWithTag(2) as! UILabel
                   let eventDescription = contentView?.viewWithTag(3) as! UILabel
                let eventDate = contentView?.viewWithTag(4) as! UILabel

            eventDate.text = DateHandler.getInstance().getCleanDate(date: events[indexPath.row].strDate)
            eventName.text = events[indexPath.row].name
                   eventDescription.text = events[indexPath.row].description
                   return cell

        }
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var event = Event()
        event = events[indexPath.row]
        performSegue(withIdentifier: "MoveToProfileEvent", sender: event)
        
    }
    
    
    @IBOutlet weak var eventTodayCollectionView: UICollectionView!
    
    @IBAction func addEventAction(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToAddEvent", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        EventRepository.getInstance().getEvents(completionHandler: {events in
            
            self.events = events
            self.tableView.reloadData()
    
            for i in events {
                if(i.strDate != "")
                {
                    
                    print(i.strDate)
                    if(DateHandler.getInstance().isToday(dateStr: i.strDate))
                    {
                        self.todayEvents.append(i)
                    }
                    
                }
            }
            
            self.eventTodayCollectionView.reloadData()
            
            print(self.todayEvents)
            
            
            
        })
        
        
    
        
        
        
        

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "MoveToAddEvent")
        {
            
            
            let destination = segue.destination as! AddEventViewController
            destination.connectedUsername = connectedUsername
            
            
        }else if(segue.identifier == "MoveToProfileEvent")
        {
            let event = sender as! Event
            let destination = segue.destination as! EventProfileViewController
            destination.event = event
            
            destination.connectedUsername = connectedUsername
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
