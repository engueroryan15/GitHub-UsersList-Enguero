//
//  UserDetails.swift
//  GitHubList
//
//  Created by Ryan Enguero on 4/21/21.
//

import Foundation

struct UserDetails: Codable
{
   var bio: String?
   var blog: String?
   var company: String?
   var created_at: String?
   var email: String?
   var followers: Int?
   var following: Int?
   var hireable: Bool?
   var id: Int?
   var location: String?
   var name: String?
   var public_gists: Int?
   var public_repos: Int?
   var twitter_username: String?
   var updated_at: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case bio = "bio"
        case blog = "blog"
        case company = "company"
        case created_at = "created_at"
        case email = "email"
        case followers
        case following
        case hireable
        case id
        case location = "location"
        case name = "name"
        case public_gists
        case public_repos
        case twitter_username = "twitter_username"
        case updated_at = "updated_at"
    }
    
   
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hireable = try container.decodeIfPresent(Bool.self, forKey: .hireable)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        blog = try container.decodeIfPresent(String.self, forKey: .blog)
        company = try container.decodeIfPresent(String.self, forKey: .company)
        created_at = try container.decodeIfPresent(String.self, forKey: .created_at)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        followers = try container.decodeIfPresent(Int.self, forKey: .followers)
        following = try container.decodeIfPresent(Int.self, forKey: .following)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        public_gists = try container.decodeIfPresent(Int.self, forKey: .public_gists)
        public_repos = try container.decodeIfPresent(Int.self, forKey: .public_repos)
        twitter_username = try container.decodeIfPresent(String.self, forKey: .twitter_username)
        updated_at = try container.decodeIfPresent(String.self, forKey: .updated_at)
        
             
        }
    
    
}

