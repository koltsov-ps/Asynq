import Foundation

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.FailableAsyncTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
    return { completion in
        lhs() { output, error in
            if let output = output {
                rhs(output, completion)
            } else {
                completion(nil, error)
            }
        }
    }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.AsyncTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output, error in
                if let output = output {
                    rhs(output) { result in completion(result, nil) }
                } else {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.AsyncTransform<T, U?>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output, error in
                if let output = output {
                    rhs(output) { result in completion(result, nil) }
                } else {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.Transform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output, error in
                if let output = output {
                    completion(rhs(output), nil)
                } else {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.Transform<T, U?>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output, error in
                if let output = output {
                    completion(rhs(output), nil)
                } else {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.FailableTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output, error in
                guard let output = output else {
                    completion(nil, error)
                    return
                }
                do {
                    completion(try rhs(output), nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.FailableAsyncSource<T>,
    rhs: @escaping Pipeline.FailableTransform<T, U?>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output, error in
                guard let output = output else {
                    completion(nil, error)
                    return
                }
                do {
                    completion(try rhs(output), nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
}
