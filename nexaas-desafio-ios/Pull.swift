//
//  Pull.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import ObjectMapper

public class PullObject: NSObject, Mappable {
    
    public var url: String?
    public var id: Int?
    public var html_url: String?
    public var diff_url: String?
    public var patch_url: String?
    public var issue_url: String?
    public var number: Int?
    public var state: String?
    public var locked: Bool?
    public var title: String?
    public var user_login: String?
    public var user_avatar_url: String?
    public var body: String?
    public var created_at: Date?
    public var message: String?
    
    required public override init() {}

    required public init?(map: Map) {}
    
    public func mapping(map: Map) {
        self.url <- map["url"]
        self.id <- map["id"]
        self.html_url <- map["html_url"]
        self.diff_url <- map["diff_url"]
        self.patch_url <- map["patch_url"]
        self.issue_url <- map["issue_url"]
        self.number <- map["number"]
        self.state <- map["state"]
        self.locked <- map["locked"]
        self.title <- map["title"]
        self.user_login <- map["user.login"]
        self.user_avatar_url <- map["user.avatar_url"]
        self.body <- map["body"]
        self.created_at <- (map["created_at"], ISO8601DateTransform())
        self.message <- map["message"]
    }
}

/*
 {
 "url": "https://api.github.com/repos/ReactiveX/RxJava/pulls/4988",
 "id": 101360378,
 "html_url": "https://github.com/ReactiveX/RxJava/pull/4988",
 "diff_url": "https://github.com/ReactiveX/RxJava/pull/4988.diff",
 "patch_url": "https://github.com/ReactiveX/RxJava/pull/4988.patch",
 "issue_url": "https://api.github.com/repos/ReactiveX/RxJava/issues/4988",
 "number": 4988,
 "state": "open",
 "locked": false,
 "title": "1.x: Merging an observable of singles.",
 "user": {
 "login": "abersnaze",
 },
 "body": "The addition of a `Observable<Single<T>> -> Observable<T>` to round out the basic API of `rx.Single`. I need this for doing a flat scan of sorts.\r\n\r\n```\r\nSingle.merge(events.scan(Single.just(seed), (stateSingle, event) -> {\r\n    return stateSingle.flatMap((state) -> {\r\n        return state.write(event);\r\n    }).cache();\r\n}));\r\n```\r\n",
 "created_at": "2017-01-12T23:13:26Z",
 */

