//
//  TableViewController.swift
//  On The Map
//
//  Created by Tarik Stafford on 6/25/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class TableViewController: UITableViewController {
    
    var studentDataArray = [StudentData]()
    var loadingData = false
    var pageLoad = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        if AccessToken.current != nil {
            LoginManager().logOut()
            logOut()
        } else {
            logOut()
        }
    }

    func loadData() {
        ParseClient.sharedInstance().populateTable(pageLoad) { (success, arrayStudentData, error) in
            if success{
                if let tempArray = arrayStudentData {
                    self.studentDataArray = self.studentDataArray + tempArray
                    performUIUpdatesOnMain {
                        self.tableView?.reloadData()
                    }
                    self.loadingData = false
                    self.pageLoad = self.pageLoad + 40
                }
            }
        }
    }
    
    func logOut() {
        UdacityClient.sharedInstance().logOutFunc() { (success, results, error) in
            
            if success{
                print("DELETE METHOD SUCCESSFUL")
                Constants.SessionInfo.sessionID = ""
                if Constants.SessionInfo.isFacebookLogin {
                    
                }
                performUIUpdatesOnMain {
                    print("PERFORMING UI UPDATES")
                    self.dismiss(animated: true, completion: nil)
                    let loginViewController = LoginViewController()
                    self.present(loginViewController, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastElement = studentDataArray.count - 1
        if !loadingData && indexPath.row == lastElement {
            loadingData = true
            loadData()
        }
        
        let object = studentDataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = object.firstName
        cell.detailTextLabel?.text = object.mediaURL
        
        
        return cell
    }
    
}
