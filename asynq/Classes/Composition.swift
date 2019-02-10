import Foundation

//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.Transform<T, U>,
//    rhs: @escaping Pipeline.Transform<U, V>) -> Pipeline.Transform<T, V> {
//    return { input in
//        rhs(lhs(input))
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.FailableTransform<T, U>,
//    rhs: @escaping Pipeline.Transform<U, V>) rethrows -> Pipeline.FailableTransform<T, V> {
//    return { input in
//        rhs(try lhs(input))
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.Transform<T, U>,
//    rhs: @escaping Pipeline.FailableTransform<U, V>) rethrows -> Pipeline.FailableTransform<T, V> {
//    return { input in
//        try rhs(lhs(input))
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.FailableTransform<T, U>,
//    rhs: @escaping Pipeline.FailableTransform<U, V>) rethrows -> Pipeline.FailableTransform<T, V> {
//    return { input in
//        try rhs(try lhs(input))
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.Transform<T, U>,
//    rhs: @escaping Pipeline.AsyncTransform<U, V>) -> Pipeline.AsyncTransform<T, V> {
//    return { input, completion in
//        rhs(lhs(input), completion)
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.FailableTransform<T, U>,
//    rhs: @escaping Pipeline.AsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
//    return { input, completion in
//        do {
//            rhs(try lhs(input)) { output in
//                completion(output, nil)
//            }
//        } catch {
//            completion(nil, error)
//        }
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.Transform<T, U>,
//    rhs: @escaping Pipeline.FailableAsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
//    return { input, completion in
//        rhs(lhs(input), completion)
//    }
//}
//
//public func |> <T, U, V>(
//    lhs: @escaping Pipeline.FailableTransform<T, U>,
//    rhs: @escaping Pipeline.FailableAsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
//    return { input, completion in
//        do {
//            rhs(try lhs(input), completion)
//        } catch {
//            completion(nil, error)
//        }
//    }
//}
