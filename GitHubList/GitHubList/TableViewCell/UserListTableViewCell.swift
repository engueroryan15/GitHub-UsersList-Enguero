//
//  UserLisrTableViewCell.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    var avatarImg : UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.borderWidth = 2.0
        return imgView
        }()
    
    var lblUserName : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var lblHtmlUrl : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                var frame =  newFrame
                frame.origin.y += 4
                frame.origin.x += 4
                frame.size.height -= 2 * 5
                frame.size.width -= 2 * 5
                super.frame = frame
            }
        }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        avatarImg.frame = CGRect(x: self.contentView.frame.width/12, y: self.contentView.frame.height, width: self.contentView.frame.width/4, height: self.contentView.frame.width/4)
        
        avatarImg.layer.cornerRadius = (avatarImg.frame.size.width ) / 2
        avatarImg.clipsToBounds = true
        
        lblUserName.frame = CGRect(x: avatarImg.frame.origin.x + avatarImg.frame.width + 10, y: avatarImg.frame.origin.y + 10, width: self.contentView.frame.width - (avatarImg.frame.origin.x + avatarImg.frame.width), height: self.contentView.frame.height/4 + 10)
        lblUserName.numberOfLines = 2
        
        lblHtmlUrl.frame = CGRect(x: avatarImg.frame.origin.x + avatarImg.frame.width + 10, y: avatarImg.frame.origin.y + lblUserName.frame.height + 10, width: self.contentView.frame.width - (avatarImg.frame.origin.x + avatarImg.frame.width), height: self.contentView.frame.height/4 + 10)
        lblHtmlUrl.numberOfLines = 2
  
        self.accessoryType = .disclosureIndicator
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
           bounds = bounds.inset(by: padding)
        
        self.backgroundColor = UIColor.clear
     
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(avatarImg)
        self.addSubview(lblUserName)
        self.addSubview(lblHtmlUrl)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.avatarImg.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        self.avatarImg.backgroundColor = UIColor.blue
//        self.contentView.addSubview(self.avatarImg)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
