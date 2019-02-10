import Foundation

func asyncIncrement(_ value: Int, completion: @escaping (Int) -> Void) {
    completion(value + 1)
}

func asyncOptionalIncrement(_ value: Int, completion: @escaping (Int?) -> Void) {
    completion(value + 1)
}

func asyncFailableIncrement(_ value: Int, completion: @escaping (Int?, Error?) -> Void) {
    completion(value + 1, nil)
}

func asyncNil(_ value: Int, completion: @escaping (Int?) -> Void) {
    completion(nil)
}

func asyncFail(_ value: Int, completion: @escaping (Int?, Error?) -> Void) {
    completion(nil, TestError.testError(value))
}

func syncIncrement(_ value: Int) -> Int {
    return value + 1
}

func syncOptionalIncrement(_ value: Int) -> Int? {
    return value + 1
}

func syncFailableIncrement(_ value: Int) throws -> Int {
    return value + 1
}

func syncFailableOptionalIncrement(_ value: Int) throws -> Int? {
    return value + 1
}

func syncFail(_ value: Int) throws -> Int {
    throw TestError.testError(value)
}

func syncOptionalFail(_ value: Int) throws -> Int? {
    throw TestError.testError(value)
}
