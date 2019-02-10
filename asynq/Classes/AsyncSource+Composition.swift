import Foundation

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T>,
    rhs: @escaping Pipeline.FailableAsyncTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output in
                rhs(output, completion)
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.FailableAsyncTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output in
                if let output = output {
                    rhs(output, completion)
                } else {
                    completion(nil, nil)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T>,
    rhs: @escaping Pipeline.AsyncTransform<T, U>)
    -> Pipeline.AsyncSource<U> {
        return { completion in
            lhs() { output in
                rhs(output, completion)
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.AsyncTransform<T, U>)
    -> Pipeline.AsyncSource<U?> {
        return { completion in
            lhs() { output in
                if let output = output {
                    rhs(output, completion)
                } else {
                    completion(nil)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.AsyncTransform<T, U?>)
    -> Pipeline.AsyncSource<U?> {
        return { completion in
            lhs() { output in
                if let output = output {
                    rhs(output, completion)
                } else {
                    completion(nil)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T>,
    rhs: @escaping Pipeline.Transform<T, U>)
    -> Pipeline.AsyncSource<U> {
        return { completion in
            lhs() { output in
                completion(rhs(output))
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.Transform<T, U>)
    -> Pipeline.AsyncSource<U?> {
        return { completion in
            lhs() { output in
                completion(output.flatMap(rhs))
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.Transform<T, U?>)
    -> Pipeline.AsyncSource<U?> {
        return { completion in
            lhs() { output in
                completion(output.flatMap(rhs))
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T>,
    rhs: @escaping Pipeline.FailableTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U> {
        return { completion in
            lhs() { output in
                do {
                    completion(try rhs(output), nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.FailableTransform<T, U>)
    -> Pipeline.FailableAsyncSource<U?> {
        return { completion in
            lhs() { output in
                do {
                    completion(try output.flatMap(rhs), nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
}

public func |> <T, U>(
    lhs: @escaping Pipeline.AsyncSource<T?>,
    rhs: @escaping Pipeline.FailableTransform<T, U?>)
    -> Pipeline.FailableAsyncSource<U?> {
        return { completion in
            lhs() { output in
                do {
                    completion(try output.flatMap(rhs), nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
}
