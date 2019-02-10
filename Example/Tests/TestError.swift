import Foundation

enum TestError: Error, Equatable {
    case testError(Int)
    
    static func == (lhs: TestError, rhs: TestError) -> Bool {
        switch (lhs, rhs) {
        case let (.testError(lVal), .testError(rVal)):
            return lVal == rVal
        }
    }
}
