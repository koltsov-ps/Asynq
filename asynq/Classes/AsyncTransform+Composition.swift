import Foundation

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U>,
    rhs: @escaping Pipeline.AsyncTransform<U, V>) -> Pipeline.AsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            rhs(output, completion)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.AsyncTransform<U, V>) -> Pipeline.AsyncTransform<T, V?> {
    return { input, completion in
        lhs(input) { output in
            guard let output = output else {
                completion(nil)
                return
            }
            rhs(output, completion)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.AsyncTransform<U, V?>) -> Pipeline.AsyncTransform<T, V?> {
    return { input, completion in
        lhs(input) { output in
            guard let output = output else {
                completion(nil)
                return
            }
            rhs(output, completion)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U>,
    rhs: @escaping Pipeline.FailableAsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            rhs(output, completion)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.FailableAsyncTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            guard let output = output else {
                completion(nil, nil)
                return
            }
            rhs(output, completion)
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U>,
    rhs: @escaping Pipeline.Transform<U, V>) -> Pipeline.AsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            completion(rhs(output))
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.Transform<U, V>) -> Pipeline.AsyncTransform<T, V?> {
    return { input, completion in
        lhs(input) { output in
            completion(output.flatMap(rhs))
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.Transform<U, V?>) -> Pipeline.AsyncTransform<T, V?> {
    return { input, completion in
        lhs(input) { output in
            completion(output.flatMap(rhs))
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U>,
    rhs: @escaping Pipeline.FailableTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            do {
                completion(try rhs(output), nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.FailableTransform<U, V>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            do {
                completion(try output.flatMap(rhs), nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U, V>(
    lhs: @escaping Pipeline.AsyncTransform<T, U?>,
    rhs: @escaping Pipeline.FailableTransform<U, V?>) -> Pipeline.FailableAsyncTransform<T, V> {
    return { input, completion in
        lhs(input) { output in
            do {
                completion(try output.flatMap(rhs), nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
