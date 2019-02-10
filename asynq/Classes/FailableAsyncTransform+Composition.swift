import Foundation

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.FailableAsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            if let output = output {
                rhs(output, completion)
            } else {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.AsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            if let output = output {
                rhs(output, { result in completion(result, nil) })
            } else {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.AsyncTransform<U, V?>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            if let output = output {
                rhs(output, { result in completion(result, nil) })
            } else {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.Transform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            completion(output.flatMap(rhs), error)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.Transform<U, V?>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            completion(output.flatMap(rhs), error)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.FailableTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            do {
                completion(try output.flatMap(rhs), error)
            } catch {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.FailableAsyncTransform<T, U>,
    rhs: @escaping Pipeline.FailableTransform<U, V?>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output, error in
            do {
                completion(try output.flatMap(rhs), error)
            } catch {
                completion(nil, error)
            }
        }
    }
}
