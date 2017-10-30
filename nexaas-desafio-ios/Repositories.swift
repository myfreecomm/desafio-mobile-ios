//
//  Repositories.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import ObjectMapper

public class Repositories: Mappable {
    
    public var total_count: Int?
    public var incomplete_results: Bool?
    public var items: [ItemObject]?
    
    required public init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        self.total_count <- map["total_count"]
        self.incomplete_results <- map["incomplete_results"]
        self.items <- map["items"]
    }
}

public class ItemObject: NSObject, Mappable {
    
    public var id: Int?
    public var name: String?
    public var full_name: String?
    public var owner_login: String?
    public var owner_id: Int?
    public var owner_avatar_url: String?
    public var owner_url: String?
    public var owner_type: String?
    public var itemDescription: String?
    public var stargazers_count: Int?
    public var watchers_count: Int?
    public var forks_count: Int?
    public var open_issues_count: Int?
    public var forks: Int?
    public var open_issues: Int?
    public var watchers: Int?
    
    required public override init() {}
    
    required public init?(map: Map) { }
    
    public func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.full_name <- map["full_name"]
        self.owner_login <- map["owner.login"]
        self.owner_id <- map["owner.id"]
        self.owner_avatar_url <- map["owner.avatar_url"]
        self.owner_url <- map["owner.url"]
        self.owner_type <- map["owner.type"]
        self.itemDescription <- map["description"]
        self.stargazers_count <- map["stargazers_count"]
        self.watchers_count <- map["watchers_count"]
        self.forks_count <- map["forks_count"]
        self.open_issues_count <- map["open_issues_count"]
        self.forks <- map["forks"]
        self.open_issues <- map["open_issues"]
        self.watchers <- map["watchers"]
    }
}

/*
 public class Owner: Mappable {
 
 public var login: String?
 public var id: Int?
 public var avatar_url: String?
 public var url: String?
 public var type: String?
 
 required public init() {}
 
 required public init?(map: Map) {}
 
 public func mapping(map: Map) {
 self.login <- map["login"]
 self.id <- map["id"]
 self.avatar_url <- map["avatar_url"]
 self.url <- map["url"]
 self.type <- map["type"]
 }
 }
 */
/*
 "items": [
 {
 "id": 7508411,
 "name": "RxJava",
 "full_name": "ReactiveX/RxJava",
 "owner": {
 "login": "ReactiveX",
 "id": 6407041,
 "avatar_url": "https://avatars.githubusercontent.com/u/6407041?v=3",
 "gravatar_id": "",
 "url": "https://api.github.com/users/ReactiveX",
 "html_url": "https://github.com/ReactiveX",
 "followers_url": "https://api.github.com/users/ReactiveX/followers",
 "following_url": "https://api.github.com/users/ReactiveX/following{/other_user}",
 "gists_url": "https://api.github.com/users/ReactiveX/gists{/gist_id}",
 "starred_url": "https://api.github.com/users/ReactiveX/starred{/owner}{/repo}",
 "subscriptions_url": "https://api.github.com/users/ReactiveX/subscriptions",
 "organizations_url": "https://api.github.com/users/ReactiveX/orgs",
 "repos_url": "https://api.github.com/users/ReactiveX/repos",
 "events_url": "https://api.github.com/users/ReactiveX/events{/privacy}",
 "received_events_url": "https://api.github.com/users/ReactiveX/received_events",
 "type": "Organization",
 "site_admin": false
 },
 "private": false,
 "html_url": "https://github.com/ReactiveX/RxJava",
 "description": "RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.",
 "fork": false,
 "url": "https://api.github.com/repos/ReactiveX/RxJava",
 "forks_url": "https://api.github.com/repos/ReactiveX/RxJava/forks",
 "keys_url": "https://api.github.com/repos/ReactiveX/RxJava/keys{/key_id}",
 "collaborators_url": "https://api.github.com/repos/ReactiveX/RxJava/collaborators{/collaborator}",
 "teams_url": "https://api.github.com/repos/ReactiveX/RxJava/teams",
 "hooks_url": "https://api.github.com/repos/ReactiveX/RxJava/hooks",
 "issue_events_url": "https://api.github.com/repos/ReactiveX/RxJava/issues/events{/number}",
 "events_url": "https://api.github.com/repos/ReactiveX/RxJava/events",
 "assignees_url": "https://api.github.com/repos/ReactiveX/RxJava/assignees{/user}",
 "branches_url": "https://api.github.com/repos/ReactiveX/RxJava/branches{/branch}",
 "tags_url": "https://api.github.com/repos/ReactiveX/RxJava/tags",
 "blobs_url": "https://api.github.com/repos/ReactiveX/RxJava/git/blobs{/sha}",
 "git_tags_url": "https://api.github.com/repos/ReactiveX/RxJava/git/tags{/sha}",
 "git_refs_url": "https://api.github.com/repos/ReactiveX/RxJava/git/refs{/sha}",
 "trees_url": "https://api.github.com/repos/ReactiveX/RxJava/git/trees{/sha}",
 "statuses_url": "https://api.github.com/repos/ReactiveX/RxJava/statuses/{sha}",
 "languages_url": "https://api.github.com/repos/ReactiveX/RxJava/languages",
 "stargazers_url": "https://api.github.com/repos/ReactiveX/RxJava/stargazers",
 "contributors_url": "https://api.github.com/repos/ReactiveX/RxJava/contributors",
 "subscribers_url": "https://api.github.com/repos/ReactiveX/RxJava/subscribers",
 "subscription_url": "https://api.github.com/repos/ReactiveX/RxJava/subscription",
 "commits_url": "https://api.github.com/repos/ReactiveX/RxJava/commits{/sha}",
 "git_commits_url": "https://api.github.com/repos/ReactiveX/RxJava/git/commits{/sha}",
 "comments_url": "https://api.github.com/repos/ReactiveX/RxJava/comments{/number}",
 "issue_comment_url": "https://api.github.com/repos/ReactiveX/RxJava/issues/comments{/number}",
 "contents_url": "https://api.github.com/repos/ReactiveX/RxJava/contents/{+path}",
 "compare_url": "https://api.github.com/repos/ReactiveX/RxJava/compare/{base}...{head}",
 "merges_url": "https://api.github.com/repos/ReactiveX/RxJava/merges",
 "archive_url": "https://api.github.com/repos/ReactiveX/RxJava/{archive_format}{/ref}",
 "downloads_url": "https://api.github.com/repos/ReactiveX/RxJava/downloads",
 "issues_url": "https://api.github.com/repos/ReactiveX/RxJava/issues{/number}",
 "pulls_url": "https://api.github.com/repos/ReactiveX/RxJava/pulls{/number}",
 "milestones_url": "https://api.github.com/repos/ReactiveX/RxJava/milestones{/number}",
 "notifications_url": "https://api.github.com/repos/ReactiveX/RxJava/notifications{?since,all,participating}",
 "labels_url": "https://api.github.com/repos/ReactiveX/RxJava/labels{/name}",
 "releases_url": "https://api.github.com/repos/ReactiveX/RxJava/releases{/id}",
 "deployments_url": "https://api.github.com/repos/ReactiveX/RxJava/deployments",
 "created_at": "2013-01-08T20:11:48Z",
 "updated_at": "2017-02-05T18:09:06Z",
 "pushed_at": "2017-02-04T16:36:11Z",
 "git_url": "git://github.com/ReactiveX/RxJava.git",
 "ssh_url": "git@github.com:ReactiveX/RxJava.git",
 "clone_url": "https://github.com/ReactiveX/RxJava.git",
 "svn_url": "https://github.com/ReactiveX/RxJava",
 "homepage": "",
 "size": 37234,
 "stargazers_count": 21045,
 "watchers_count": 21045,
 "language": "Java",
 "has_issues": true,
 "has_downloads": true,
 "has_wiki": true,
 "has_pages": true,
 "forks_count": 3712,
 "mirror_url": null,
 "open_issues_count": 38,
 "forks": 3712,
 "open_issues": 38,
 "watchers": 21045,
 "default_branch": "2.x",
 "score": 1
 },
 */

