//
//  ViewController.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 21/03/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import UIKit

class DiscussionViewController: UIViewController {

    // MARK: - Attributes
    var user: User!
    var discussions: [Discussion] = [Discussion]()
    @IBOutlet weak var discussionsTable: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = user else {
            return
        }
        self.navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.done, target: self, action: #selector(DiscussionViewController.logout(sender:)))
        self.navigationItem.leftBarButtonItem = logoutButton
    }
    
    @objc func logout(sender: UIBarButtonItem) {
        let manager = UserInteractor.init(manager: UserDummy()).manager
        manager.logout(onSuccess: {
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            print(error)            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.initFetch()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showChat":
                
                let selectedIndex = self.discussionsTable.indexPathsForSelectedRows?.last?.item
                let discussion = discussions[selectedIndex!]
                let vc = segue.destination as! ChatViewController
                vc.actualDiscussion = discussion
                vc.user = user
            
            default:
                break
            }
        }
    }

}

