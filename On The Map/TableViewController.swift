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
    
    var studentDataArray = StudentData.ArrayStudentData.sharedInstance
    var pageLoad = 0
    
    @IBAction func postPin(_ sender: Any) {
        addYourPost()
    }
    @IBAction func refreshData(_ sender: Any) {
        refreshStudentDataArray() {(success, error) in
            if success {
                performUIUpdatesOnMain {
                    self.studentDataArray = StudentData.ArrayStudentData.sharedInstance
                    self.tableView?.reloadData()
                    self.refreshDataAlert()
                }
            } else {
                performUIUpdatesOnMain {
                    self.failedAlert("Refresh Data Error!", error ?? "Error Refreshing Data")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self

    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        if AccessToken.current != nil {
            LoginManager().logOut()
            logOut()
        } else {
            logOut()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentDataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = studentDataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = object.firstName
        cell.detailTextLabel?.text = object.mediaURL
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = studentDataArray[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let toOpen = object.mediaURL
        if let url = URL(string: toOpen){
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                failedAlert("Invalid URL", "The URL can not be opened.")
            }
        }
    }

}
