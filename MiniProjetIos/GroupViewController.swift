//
//  GroupViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 12/12/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
   
    var group : [Group] = []
    var user = User()
    
    @IBOutlet weak var groupCollectioView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellule",for: indexPath)
                        
                        let contentView = cell.viewWithTag(0)

                         let groupnameLabel = contentView?.viewWithTag(1) as! UILabel
        let descriptionLabel = contentView?.viewWithTag(2) as! UILabel
             
        groupnameLabel.text = group[indexPath.row].name
        descriptionLabel.text = "group[indexPath.row].description"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let groupToMove = group[indexPath.row]
        
        performSegue(withIdentifier: "MoveToDetailGroup", sender: groupToMove)
        
        
    }
    
    @IBAction func moveToAddGroup(_ sender: Any) {
        
        performSegue(withIdentifier: "MoveToAddGroup", sender: self)
        
    }
    
    
    @IBAction func showMyGroups(_ sender: Any) {
        
        GroupRepository.getInstance().getGroupsByCreator(creator: user.username!, completionHandler: {
            groups in
            
            self.group = groups
            self.groupCollectioView.reloadData()
            
        })
        
    }
    
    
    
    
    @IBAction func showAllGroups(_ sender: Any) {
    
        GroupRepository.getInstance().getAllGroups(completionHandler: {
            groups in
            
            self.group = groups
            
            self.groupCollectioView.reloadData()
            
            
            
        })
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        GroupRepository.getInstance().getAllGroups(completionHandler: {
            groups in
            
            self.group = groups
            
            self.groupCollectioView.reloadData()
            
            
            
        })
        
    
        
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        if(segue.identifier == "MoveToAddGroup")
        {
            let destination = segue.destination as! AddGroupViewController
            destination.user = self.user

            
        }else if (segue.identifier == "MoveToDetailGroup" ){
            

            let group = sender as! Group
            let destination = segue.destination as! DetailGroupViewController
            destination.groupName = group.name
            destination.user = self.user
            
        }
        
        
    }
    

}
