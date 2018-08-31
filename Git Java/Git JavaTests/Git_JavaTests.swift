//
//  Git_JavaTests.swift
//  Git JavaTests
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import XCTest
@testable import Git_Java

class Git_JavaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPullRequestCell(){
        let user = Owner.init(idOwner: 2048831,
                              login: "khatchad",
                              avatarUrl: "https://avatars2.githubusercontent.com/u/2048831?v=4")
        let pullRequest = PullRequest.init(idPullRequest: 209596294,
                                           title: "Apply Optimize Java 8 Streams refactoring",
                                           body: "String?",
                                           createdAt: "2018-08-20T17:52:11Z",
                                           updateAt: "2018-08-21T19:17:13Z",
                                           user: user)
        
        let viewModel =  PullRequestViewModel(pullRequest: pullRequest)
        
        XCTAssertEqual(viewModel.createdAt, "20/08/2018 17:52")
        XCTAssertEqual(viewModel.user.idOwner, 2048831)
    }
    
}
