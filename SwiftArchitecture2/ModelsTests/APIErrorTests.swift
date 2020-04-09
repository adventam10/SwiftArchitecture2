//
//  APIErrorTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class APIErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_description_when_network() {
        let error = APIError.network
        XCTAssertEqual(error.localizedDescription, "ネットワークの接続状態を確認してください。")
    }

    func test_description_when_server() {
        let error = APIError.server
        XCTAssertEqual(error.localizedDescription, "サーバーと通信できません。")
    }

    func test_description_when_invalidJSON() {
        let error = APIError.invalidJSON
        XCTAssertEqual(error.localizedDescription, "JSONパース失敗。")
    }
}
