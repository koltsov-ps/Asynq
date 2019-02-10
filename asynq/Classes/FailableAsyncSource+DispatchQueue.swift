import Foundation

public func |> <T>(
    transform: @escaping Pipeline.FailableAsyncSource<T>,
    queue: DispatchQueue)
    -> Pipeline.FailableAsyncSource<T> {
        return { completion in
            transform() { output, error in
                queue.async {
                    completion(output, error)
                }
            }
        }
}

public func |> <T>(
    queue: DispatchQueue,
    transform: @escaping Pipeline.FailableAsyncSource<T>)
    -> Pipeline.FailableAsyncSource<T> {
        return { completion in
            queue.async {
                transform(completion)
            }
        }
}
