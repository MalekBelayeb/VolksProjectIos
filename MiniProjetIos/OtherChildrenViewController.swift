//
//  OtherChildrenViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/14/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit

class OtherChildrenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var username : String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
                                 let contentView = cell.viewWithTag(0)
       let childrenName = contentView?.viewWithTag(2) as! UILabel
       let childrenBirthday = contentView?.viewWithTag(3) as! UILabel
   
childrenName.text = childrenList[indexPath.row].name
childrenBirthday.text = DateHandler.getInstance().getCleanDate(date: childrenList[indexPath.row].birthday)
        
                
        return cell
    }
    

    var childrenList : [Children] = []
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     ChildrenRepository.getInstance().getChildrensByParent(username: username, completionHandler: {childrens in
         
         self.childrenList = childrens
         self.tableView.reloadData()
         
     })
    
        
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
