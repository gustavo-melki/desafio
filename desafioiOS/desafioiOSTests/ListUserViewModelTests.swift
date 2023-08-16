//
//  ListUserViewModelTests.swift
//  desafioiOSTests
//
//  Created by Gustavo Melki Leal on 16/08/23.
//

import XCTest
@testable import desafioiOS

class ListUsersViewModelTests: XCTestCase {

    // Mock do serviço para simular respostas
    class MockListUserService: ListUserServiceProtocol {
        var shouldSucceed: Bool = true
        
        func fetchContacts(completion: @escaping (Result<[User], Error>) -> Void) {
            if shouldSucceed {
                let users: [User] = [
                  
                  User(login: "User 1", id: 1, avatar_url: "url_test1"),
                  User(login: "User 2", id: 2, avatar_url: "url_test2"),
                  User(login: "User 3", id: 1, avatar_url: "url_test3")
                   
                ]
                completion(.success(users))
            } else {
                let error = NSError(domain: "MockErrorDomain", code: 123, userInfo: nil)
                completion(.failure(error))
            }
        }
    }

    var viewModel: ListUsersViewModel!
    var mockService: MockListUserService!

    override func setUp() {
        super.setUp()
        mockService = MockListUserService()
        viewModel = ListUsersViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadContactsSuccess() {
        mockService.shouldSucceed = true

        let expectation = XCTestExpectation(description: "Load Contacts Success")
        
        viewModel.loadContacts { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 3)
                XCTAssertEqual(users[0].login, "User 1")
                XCTAssertEqual(users[1].avatar_url, "url_test2")
            case .failure(let error):
                XCTFail("Expected success, but got failure: \(error)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testLoadContactsFailure() {
        mockService.shouldSucceed = false

        let expectation = XCTestExpectation(description: "Load Contacts Failure")
        
        viewModel.loadContacts { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure:
                // Expected failure
                break
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
