import Foundation

public func |> <T, U>(
    transform: @escaping Pipeline.FailableAsyncTransform<T, U>,
    queue: DispatchQueue) -> Pipeline.FailableAsyncTransform<T, U> {
    return { input, completion in
        transform(input) { output, error in
            queue.async {
                completion(output, error)
            }
        }
    }
}

public func |> <T, U>(
    queue: DispatchQueue,
    transform: @escaping Pipeline.FailableAsyncTransform<T, U>) -> Pipeline.FailableAsyncTransform<T, U> {
    return { input, completion in
        queue.async {
            transform(input) { output, error in
                completion(output, error)
            }
        }
    }
}
