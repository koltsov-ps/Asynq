import Foundation
import XCTest
import Asynq

class FailableAsyncTransformTests: XCTestCase {
    let defaultTimeout = 0.5
    
    func test_FailableAsync_FailableAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> asyncFailableIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_FailableAsync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFail |> unreachable(asyncFailableIncrement)
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(5))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_FailableAsync_Async() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> asyncIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_Async() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFail |> unreachable(asyncIncrement)
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(5))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_FailableAsync_AsyncOptional() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> asyncOptionalIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_AsyncOptional() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFail |> unreachable(asyncOptionalIncrement)
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(5))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_FailableAsync_Sync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> syncIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_Sync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFail |> unreachable(syncIncrement)
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(5))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_FailableAsync_FailableSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> syncFailableIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_FailableSync_1() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFail |> unreachable(syncFailableIncrement)
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(5))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_FailableSync_2() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> syncFail
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(6))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func test_FailableAsync_FailableOptionalSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> syncFailableOptionalIncrement
        job(5) { val, error in
            XCTAssertEqual(val, 7)
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testError_FailableAsync_FailableOptionalSync() {
        let exp = self.expectation(description: "Complete")
        let job = asyncFailableIncrement |> syncOptionalFail
        job(5) { val, error in
            XCTAssertNil(val)
            XCTAssertEqual(error as? TestError, TestError.testError(6))
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
    
    func testDispatch() {
        let exp = self.expectation(description: "Complete")
        
        let f: Pipeline.FailableAsyncTransform<Int, Int> = { val, completion in
            XCTAssertFalse(Thread.isMainThread)
            completion(val, nil)
        }
        
        let job = DispatchQueue.global() |> f |> DispatchQueue.main
        job(5) { val, error in
            XCTAssertEqual(val, 5)
            XCTAssertNil(error)
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }
        wait(for: [exp], timeout: defaultTimeout)
    }
}
