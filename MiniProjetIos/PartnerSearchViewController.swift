//
//  PartnerSearchViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/14/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit



class PartnerSearchViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate{
    
    var partners :[String] = []
    var searchData : [String] = []
    
    
    var sendTo : String = ""
        var connectedUsername : String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellule",for: indexPath)
        let contentView = cell.viewWithTag(0)
        let pertnerUsername = contentView?.viewWithTag(1) as! UILabel
                
            
        pertnerUsername.text = searchData[indexPath.row]
          
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        self.usernameSearched.text = self.searchData[indexPath.row]
        self.sendTo = self.searchData[indexPath.row]
        self.searchBar.endEditing(true)
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
         textField.resignFirstResponder()
         
     return true
     }

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usernameSearched: UILabel!
    
    
    @IBAction func sendinvitation(_ sender: Any) {
        
        
        let invitation = Invitation()
        invitation.sender = connectedUsername
        invitation.receiver = sendTo
        invitation.type = "PARTNERSHIP"
        invitation.content = "A volk want u to become his partner"
        
        InvitationRepository.getInstance().add(invitation: invitation, completionHandler: {
            data in
            
            if(data.count == 21)
            {
              self.searchBar.text = ""

               self.searchData = self.partners

               self.searchBar.endEditing(true)

              self.tableView.reloadData()
                self.usernameSearched.text = ""
            }
            
            
        })
    
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
       searchData = searchText.isEmpty ? partners : partners.filter

                 {

             (item: String) -> Bool in


             return item.range(of: searchText, options: .caseInsensitive, range: nil,

        locale: nil) != nil

                }

            
                tableView.reloadData()
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.text = ""

         searchData = partners

        searchBar.endEditing(true)

        tableView.reloadData()
    }
    
    
    var tempList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchBar.delegate = self
        // Do any additional setup after loading the view.
       UserRepository.getInstance().getUsers(completionHandler: {users in
            
        for i in users {
          
            self.tempList.append(i.username!)
            
        }
        print(self.tempList)
        self.partners = self.tempList
        self.searchData = self.tempList
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
