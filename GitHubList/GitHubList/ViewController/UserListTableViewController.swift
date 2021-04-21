//
//  UserListTableViewController.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import UIKit

class UserListTableViewController: UITableViewController {

    var users : [UserList] = []
//    var userDetails = UserDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "GITHUB USERS"
        
        self.tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: "UserListTableViewCell")
        self.tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        NetworkHandler().getUserList(url: gitHubUserListUrl, completionHandler: { (users) in
            print(users)
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        let error = notification.userInfo
        
        print(error!["message"]!)
        
        self.alertView(title: "Error", message: error!["message"]! as! String)
    }
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // add an action (button)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

              // show the alert
              self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as! UserListTableViewCell

        // Configure the cell...
        let user = self.users[indexPath.row]
        
        cell.avatarImg.downloadImageUsingAF(url: user.avatar_url)
        cell.lblUserName.text = "@" + user.login
        cell.lblHtmlUrl.text = "@" + user.html_url
        

        
        if indexPath.row % 2 == 0 {
            
            cell.avatarImg.layer.borderColor = UIColor.blue.cgColor
        }else{
            cell.avatarImg.layer.borderColor = UIColor.green.cgColor
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let user = self.users[indexPath.row]
        
        NetworkHandler().getUserDetails(url: "\(gitHubUserListUrl)/" + user.login, completionHandler: { [self] (userDetails) in
            print(users)
            DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController
                vc?.avatarUrl = user.avatar_url
                vc?.getUserDetails(userDetails: userDetails, accountType: user.type)
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        })
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
