//
//  desafioiOSTests.swift
//  desafioiOSTests
//
//  Created by Gustavo Melki Leal on 15/08/23.
//

import XCTest
@testable import desafioiOS

class ListRepoViewModelTests: XCTestCase {

    // Mock do serviço para simular respostas
    class MockListRepoService: ListRepoServiceProtocol {
        var shouldSucceed: Bool = true
        
        func fetchRepos(completion: @escaping (Result<[Repo], Error>) -> Void) {
            if shouldSucceed {
                let repos: [Repo] = [
                    Repo(name: "Repo 1"),
                    Repo(name: "Repo 2")
                ]
                completion(.success(repos))
            } else {
                let error = NSError(domain: "MockErrorDomain", code: 123, userInfo: nil)
                completion(.failure(error))
            }
        }
    }

    var viewModel: ListRepoViewModel!
    var mockService: MockListRepoService!

    override func setUp() {
        super.setUp()
        mockService = MockListRepoService()
        viewModel = ListRepoViewModel(service: mockService)
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
            case .success(let repos):
                XCTAssertEqual(repos.count, 2)
                XCTAssertEqual(repos[0].name, "Repo 1")
                XCTAssertEqual(repos[1].name, "Repo 2")
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
