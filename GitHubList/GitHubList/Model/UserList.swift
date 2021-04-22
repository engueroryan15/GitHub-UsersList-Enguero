//
//  UserList.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import Foundation

struct UserList: Codable
{
    var login : String?
    var id : Int?
    var node_id : String?
    var avatar_url : String?
    var gravatar_id : String?
    var url : String?
    var html_url : String?
    var followers_url : String?
    var following_url : String?
    var gists_url : String?
    var starred_url : String?
    var subscriptions_url : String?
    var organizations_url : String?
    var repos_url : String?
    var events_url : String?
    var received_events_url : String?
    var type : String?
    var site_admin : Bool?
    
    enum CodingKeys: String, CodingKey {
            
        case login = "login"
        case id
        case node_id = "node_id"
        case avatar_url = "avatar_url"
        case gravatar_id = "gravatar_id"
        case url = "url"
        case html_url = "html_url"
        case followers_url = "followers_url"
        case following_url = "following_url"
        case gists_url = "gists_url"
        case starred_url = "starred_url"
        case subscriptions_url = "subscriptions_url"
        case organizations_url = "organizations_url"
        case repos_url = "repos_url"
        case events_url = "events_url"
        case received_events_url = "received_events_url"
        case type = "type"
        case site_admin
    }

    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        login = try container.decodeIfPresent(String.self, forKey: .login)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        node_id = try container.decodeIfPresent(String.self, forKey: .node_id)
        avatar_url = try container.decodeIfPresent(String.self, forKey: .avatar_url)
        gravatar_id = try container.decodeIfPresent(String.self, forKey: .gravatar_id)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        html_url = try container.decodeIfPresent(String.self, forKey: .html_url)
        followers_url = try container.decodeIfPresent(String.self, forKey: .followers_url)
        following_url = try container.decodeIfPresent(String.self, forKey: .following_url)
        gists_url = try container.decodeIfPresent(String.self, forKey: .gists_url)
        starred_url = try container.decodeIfPresent(String.self, forKey: .starred_url)
        subscriptions_url = try container.decodeIfPresent(String.self, forKey: .subscriptions_url)
        organizations_url = try container.decodeIfPresent(String.self, forKey: .organizations_url)
        repos_url = try container.decodeIfPresent(String.self, forKey: .repos_url)
        events_url = try container.decodeIfPresent(String.self, forKey: .events_url)
        received_events_url = try container.decodeIfPresent(String.self, forKey: .received_events_url)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        site_admin = try container.decodeIfPresent(Bool.self, forKey: .site_admin)
    
    }
}
