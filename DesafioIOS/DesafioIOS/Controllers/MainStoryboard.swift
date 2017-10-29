//
//  MainStoryboard.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import StoryboardContext

/**
 *  MainStoryboard
 *  @description    Main Storyboard's representation
 */
class MainStoryboard : StoryboardContext {
    
    // Existent segues in storyboard
    struct Segue {
        static let toPullRequest = "toPullRequests"
        static let toWebView = "toWebView"
    }
    
    convenience override init() {
        self.init(name: "Main")
    }
}

