//
//  MockPullRequestsViewModel.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 29/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

@testable import DesafioIOS

class MockPullRequestsViewModel : PullRequestsViewModel {
    
    var didRefreshPage : Bool? = nil
    
    override func refresh() {
        super.refresh()
        self.didRefreshPage = true
    }
}
