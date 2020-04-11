//
//  ChildrenViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/13/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class ChildrenViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var childrens : [Children] = []
    
    @IBOutlet weak var tableView: UITableView!

    var connectedUsername = ""
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
   

              let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                                         let contentView = cell.viewWithTag(0)
               let childrenName = contentView?.viewWithTag(2) as! UILabel
               let childrenBirthday = contentView?.viewWithTag(3) as! UILabel
           
        childrenName.text = childrens[indexPath.row].name
        childrenBirthday.text = DateHandler.getInstance().getCleanDate(date: childrens[indexPath.row].birthday)
        
        
return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ChildrenRepository.getInstance().getChildrensByParent(username: connectedUsername, completionHandler: {childrens in
            
            
            self.childrens = childrens
            self.tableView.reloadData()
            
        })
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
