//
//  UserDetailsViewController.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var userDetails : UserDetails?
    var avatarUrl : String?
    
    var avatarImgView : UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.borderWidth = 2.0
        return imgView
        }()
    
    var lblFollowing : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    var lblFollowers : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    var lblName : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.black.cgColor
        label.numberOfLines = 2
        return label
    }()

    var lblAccountType : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.black.cgColor
        label.numberOfLines = 2
        return label
    }()
    
    
    var lblBlog : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.black.cgColor
        label.numberOfLines = 2
        return label
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.backBarButtonItem?.title = ""
//        self.navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.black
       

        // Do any additional setup after loading the view.
    }
    
    func setupView(userDetails: UserDetails, accountType: String){
        
        let app = UIApplication.shared
        let height = app.statusBarFrame.size.height
    
        avatarImgView.frame = CGRect(x: 10, y: height + 64, width: self.view.frame.width - 20, height: self.view.frame.height/4)
//        avatarImgView.backgroundColor = UIColor.blue
        avatarImgView.downloadImageUsingAF(url: avatarUrl!)
        
        lblFollowing.frame  = CGRect(x: 0, y: avatarImgView.frame.height + height + 60, width:self.view.frame.width/2, height: 50)
        lblFollowing.text = "FOLLOWING: \(userDetails.following )"
        
        lblFollowers.frame  = CGRect(x: lblFollowing.frame.width, y: avatarImgView.frame.height + height + 60, width:self.view.frame.width/2, height: 50)
        lblFollowers.text = "FOLLOWERS: \(userDetails.followers )"
        
        lblName.frame =  CGRect(x: 10, y: avatarImgView.frame.height + lblFollowing.frame.height + height + 60, width:self.view.frame.width-20, height: 100)
        lblName.text = "  NAME: \n  \(userDetails.name ?? "")"
        
        lblAccountType.frame =  CGRect(x: 10, y: avatarImgView.frame.height + lblFollowing.frame.height + height + lblName.frame.height + 80, width:self.view.frame.width-20, height: 100)
        lblAccountType.text = "  Account Type: \n  \(accountType)"
        
        self.view.addSubview(avatarImgView)
        self.view.addSubview(lblFollowing)
        self.view.addSubview(lblFollowers)
        self.view.addSubview(lblName)
        self.view.addSubview(lblAccountType)
        
        if userDetails.blog != nil{
            
            lblBlog.frame =  CGRect(x: 10, y: avatarImgView.frame.height + lblFollowing.frame.height + height + lblName.frame.height + lblAccountType.frame.height + 100, width:self.view.frame.width-20, height: 100)
            lblBlog.text = "  Blog: \n  \(userDetails.blog ?? "")"
            
            self.view.addSubview(lblBlog)
        }
        
       
        
    }
    
    func getUserDetails(userDetails: UserDetails, accountType: String) {
        print("userdetails \(userDetails)")
        let userDetails = userDetails
        self.title = userDetails.name
        
        setupView(userDetails: userDetails, accountType: accountType)
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
