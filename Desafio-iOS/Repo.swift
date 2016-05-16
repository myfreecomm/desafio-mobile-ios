//
//  Repo.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Gloss

struct Repo: Glossy {
    
    let repoId: Int
    let repoDesc: String
    let repoName: String
    let repoFullName: String
    let repoStars:Int?
    let repoForks:Int?
    let repoUrl: NSURL
    let repoIssues: Int?
    let repoOwner: RepoOwner
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard
            let repo_id: Int = "id" <~~ json,
            let repo_desc:String = "description" <~~ json,
            let repo_name: String = "name" <~~ json,
            let repo_fullName:String = "full_name" <~~ json,
            let repo_stars:Int = "stargazers_count" <~~ json,
            let repo_forks:Int = "forks_count" <~~ json,
            let repo_url: NSURL = "html_url" <~~ json,
            let repo_issues: Int = "open_issues_count" <~~ json,
            let repo_owner: RepoOwner = "owner" <~~ json
        else { return nil }
        
        repoId = repo_id
        repoName = repo_name
        repoDesc = repo_desc
        repoFullName = repo_fullName
        repoStars = repo_stars
        repoForks = repo_forks
        repoUrl = repo_url
        repoIssues = repo_issues
        repoOwner = repo_owner
    }
    
    //Não vai ser utilizado, mas fica como exemplo de serialização
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> repoId,
            "name" ~~> repoName,
            "description" ~~> repoDesc,
            "full_name" ~~> repoFullName,
            "stargazers_count" ~~> repoStars,
            "forks_count" ~~> repoForks,
            "html_url" ~~> repoUrl.absoluteString,
            "open_issues_count" ~~> repoIssues,
            "owner" ~~> repoOwner,
            ])
    }
}
