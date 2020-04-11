//
//  ParentProfileViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 11/21/19.
//  Copyright © 2019 Akthem-Malek. All rights reserved.
//

import UIKit

class ParentProfileViewController: UIViewController {

    var user = User()
    
    @IBOutlet weak var containerView: UIView!
    private lazy var profileViewController: ProfileViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "profileviewcontroller") as! ProfileViewController
        
        viewController.user = self.user
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var settingsViewController: SettingsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "settingsviewcontroller") as! SettingsViewController
        viewController.user = user

        self.add(asChildViewController: viewController)

        return viewController
    }()
    	
    

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    
    @IBAction func segmentedValueChanged(_ sender: Any) {
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(user)
        setupView()
	
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()

    }

    private func setupSegmentedControl() {
       segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Profile", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Settings", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    	
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: settingsViewController)
            add(asChildViewController: profileViewController)
        } else {
            remove(asChildViewController: profileViewController)
            add(asChildViewController: settingsViewController)
        }
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)

        viewController.view.removeFromSuperview()

        viewController.removeFromParent()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)

       view.addSubview(viewController.view)

        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
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
