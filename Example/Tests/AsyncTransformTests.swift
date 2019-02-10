import XCTest
import UIKit
import Asynq

class AsyncTransformTests: XCTestCase {
    let defaultTimeout = 0.5
    
    func test_async_failableAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> asyncFailableIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_async_failableAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> asyncFail
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(6))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_failableAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> asyncFailableIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testNil_optionalAsync_failableAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncNil |> unreachable(asyncFailableIncrement)
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_async_async() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> asyncIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_async_optionalAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> asyncOptionalIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_async() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> asyncIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testNil_optionalAsync_async() {
        let exp = self.expectation(description: "Complete")
        let job = asyncNil |> unreachable(asyncIncrement)
        job(5) { val in
            XCTAssertNil(val)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_optionalAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> asyncOptionalIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testNil_optionalAsync_optionalAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncNil |> unreachable(asyncOptionalIncrement)
        job(5) { val in
            XCTAssertNil(val)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_async_sync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> syncIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_sync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> syncIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_optionalSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> syncOptionalIncrement
        job(5) { val in
            XCTAssertEqual(val, 7)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_async_failableSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> syncFailableIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_async_failableSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncIncrement |> syncFail
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(6))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_failableSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> syncFailableIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_optionalAsync_failableSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> syncFail
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(6))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_optionalAsync_failableOptionalSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> syncFailableOptionalIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_optionalAsync_failableOptionalSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncOptionalIncrement |> syncOptionalFail
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(6))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testAsync() {
        let downloader = FakeDownloader()
        let task = downloader.download
                |> { UIImage(data: $0) }
                |> DispatchQueue.main
        let exp = self.expectation(description: "donwload")
        let url = URL(string: "http://server.com/image")!
        task(url) { image, error in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertNil(error)
            XCTAssertNil(image)
            XCTAssertTrue(image is UIImage?)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }
    
    class FakeDownloader {
        var failure: Error?
        func download(url: URL, completion: @escaping (Data?, Error?) -> Void) {
            DispatchQueue.global().async {
                if let failure = self.failure {
                    completion(nil, failure)
                } else {
                    completion(Data(), nil)
                }
            }
        }
    }
}
