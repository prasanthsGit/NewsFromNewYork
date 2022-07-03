//
//  NewsFromNewYorkTests.swift
//  NewsFromNewYorkTests
//
//  Created by prasanth on 03/07/22.
//

import XCTest
@testable import NewsFromNewYork

class NewsFromNewYorkTests: XCTestCase {

    var newsListViewController: NewsListViewController?
    override func setUpWithError() throws {
        newsListViewController = NewsListViewController()
    }

    override func tearDownWithError() throws {
        newsListViewController = nil
    }
    
    func testIsValidApiKey() {
        // set
        let constants = Constants.shared.apiKey
        //asset
        XCTAssertEqual(constants, "yuq4UVNJUGDYd1hyDik83JM5iXjAKpa5")
    }
    
    func testWithInvalidKey() {
        let newsUrl = Constants.shared.url + "yuq4UVNJUGDYd1hyDik83JM5iXAAAAAA"
        var resultStatus = Bool()
        newsListViewController?.newsListAPICall(urL: newsUrl, completion: { status in
            resultStatus = status
        })
        XCTAssertEqual(resultStatus, false)
    }
    
    func testWithInvalidNewsUrl() {
        let newsUrl = Constants.shared.url + "error" + Constants.shared.apiKey
        var resultStatus = Bool()
        newsListViewController?.newsListAPICall(urL: newsUrl, completion: { status in
            resultStatus = status
        })
        XCTAssertEqual(resultStatus, false)
    }
    
    func testWithValidInput() {
        let newsUrl = Constants.shared.url + Constants.shared.apiKey
        var resultStatus = Bool()
        newsListViewController?.newsListAPICall(urL: newsUrl, completion: { status in
            resultStatus = status
            XCTAssertEqual(resultStatus, true)
        })
    }
}
