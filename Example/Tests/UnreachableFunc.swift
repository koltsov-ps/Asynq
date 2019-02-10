import Foundation
import XCTest
import Asynq

func unreachable<T, U>(_ f: @escaping Pipeline.FailableAsyncTransform<T, U>)
    -> Pipeline.FailableAsyncTransform<T, U> {
        return { input, completion in
            XCTFail()
            f(input, completion)
        }
}

func unreachable<T, U>(_ f: @escaping Pipeline.AsyncTransform<T, U>)
    -> Pipeline.AsyncTransform<T, U> {
        return { input, completion in
            XCTFail()
            f(input, completion)
        }
}

func unreachable<T, U>(_ f: @escaping Pipeline.Transform<T, U>)
    -> Pipeline.Transform<T, U> {
        return { input in
            XCTFail()
            return f(input)
        }
}

func unreachable<T, U>(_ f: @escaping Pipeline.FailableTransform<T, U>)
    -> Pipeline.FailableTransform<T, U> {
        return { input in
            XCTFail()
            return try f(input)
        }
}
