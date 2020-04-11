//
//  MyPostViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/6/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class MyPostViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    
    var mypost : [Post] = []
    var username : String = ""
        
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return mypost.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

     let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
         
     let contentView = cell.viewWithTag(0)

    let descriptionLabel = contentView?.viewWithTag(1) as! UILabel
    descriptionLabel.text = mypost[indexPath.row].description


     return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        PostRepository.getInstance().getPostByUsername(username: username , completionHandler: { posts in
            
            self.mypost = posts
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
