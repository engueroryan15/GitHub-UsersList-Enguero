//
//  UserListTableViewController.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import UIKit
import Network

class UserListTableViewController: UITableViewController, UISearchBarDelegate {

    var users : [UserList] = []
    
    let monitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "GITHUB USERS"
        
        self.tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: "UserListTableViewCell")
        self.tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                NetworkHandler().getUserList(url: gitHubUserListUrl, completionHandler: { (users) in
                    print(users)
                    self.users = users
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
            
                })
            }else{
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode([UserList].self, from: UserDefaults.standard.data(forKey: "jsonData")!)
                        print(response)
                        self.users = response
                    } catch let error  {
                        print("Parsing Failed \(error.localizedDescription)")
                        debugPrint(error)
                        
                    }
                    self.tableView.reloadData()
                }
            }
         
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.start(queue: queue)
       
        
          let refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    
    }
 

    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        
        print("Refresh")
        print(String(describing: self.users.last?.id))
        
        let id = self.users.last?.id
        
        
        NetworkHandler().getUserList(url: gitHubUserListUrl + "?since=\(id!)", completionHandler: { (users) in
            print(users)
            self.users = users
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
    
        })

        
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
        
        cell.avatarImg.downloadImageUsingAF(url: user.avatar_url ?? "")
        cell.lblUserName.text = "@" + user.login!
        cell.lblHtmlUrl.text = "@" + user.html_url!
        

        
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
        
        NetworkHandler().getUserDetails(url: "\(gitHubUserListUrl)/" + user.login!, completionHandler: { [self] (userDetails) in
            print(users)
            DispatchQueue.main.async {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController
                vc?.avatarUrl = user.avatar_url
                vc?.getUserDetails(userDetails: userDetails, accountType: user.type!)
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
