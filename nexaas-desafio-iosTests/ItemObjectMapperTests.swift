//
//  ItemObjectMapperTests.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 29/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import XCTest
import Foundation
import ObjectMapper

@testable import nexaas_desafio_ios

class ItemObjectMapperTests: XCTestCase {
    
    var items: [ItemObject] = []
    
    override func setUp() {
        super.setUp()
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
        
        items = Mapper<ItemObject>().mapArray(JSONObject: json)!
    }
    
    func testItemMappingHasExpectedItemsCount() {
        
        XCTAssert(items.count == 1, "Collection didn't have expected number of items")
        
    }
    
    func testFirstItemHasExpectedValues(index: Int) {
        
        let item = items[0]
        
        XCTAssertEqual(item.id, 7508411)
        XCTAssertEqual(item.name, "RxJava")
        XCTAssertEqual(item.full_name, "ReactiveX/RxJava")
        XCTAssertEqual(item.owner_login, "ReactiveX")
        XCTAssertEqual(item.owner_id, 6407041)
        XCTAssertEqual(item.owner_avatar_url, "https://avatars1.githubusercontent.com/u/6407041?v=4")
        XCTAssertEqual(item.owner_type, "Organization")
        XCTAssertEqual(item.itemDescription, "RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.")
        XCTAssertEqual(item.stargazers_count, 28279)
        XCTAssertEqual(item.watchers_count, 28279)
        XCTAssertEqual(item.forks_count, 4991)
        XCTAssertEqual(item.open_issues_count, 34)
        XCTAssertEqual(item.forks, 4991)
        XCTAssertEqual(item.open_issues, 34)
        XCTAssertEqual(item.watchers, 28279)
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "item", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        return data
    }()
    
}
