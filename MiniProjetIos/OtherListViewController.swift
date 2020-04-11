//
//  OtherListViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/14/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class OtherListViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var personList : [User] = []
    var x = 0
    
    var username = ""

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
          let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                                         let contentView = cell.viewWithTag(0)
               let personName = contentView?.viewWithTag(2) as! UILabel
        let personSexe = contentView?.viewWithTag(3) as! UILabel
        let personBirthday = contentView?.viewWithTag(4) as! UILabel

           
        personName.text = personList[indexPath.row].username!
        personSexe.text = personList[indexPath.row].sexe

        personBirthday.text = DateHandler.getInstance().getCleanDate(date: personList[indexPath.row].birthDate)
        
        return cell

    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if(x == 1)
        {
            
        
        
        FollowRepository.getInstance().getFollowers(username: username, completionHandler: {followers in
            
            for i in followers{
                print(i)
                
                UserRepository.getInstance().getUser(username: i.username, completionHandler: {user in
                    
                    self.personList.append(user)
                    self.tableView.reloadData()

                                
                })
                
                
            }
            
            })
            
            }else if (x == 2)
        {
            FollowRepository.getInstance().getFollowings(username: username, completionHandler: {followers in
                      
                      for i in followers{
                          print(i)
                          
                          UserRepository.getInstance().getUser(username: i.username, completionHandler: {user in
                              
                              self.personList.append(user)
                              self.tableView.reloadData()

                                          
                          })
                          
                          
                      }
                      
                      })
            
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
