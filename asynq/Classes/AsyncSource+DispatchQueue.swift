import Foundation

public func |> <T>(
    transform: @escaping Pipeline.AsyncSource<T>,
    queue: DispatchQueue)
    -> Pipeline.AsyncSource<T> {
        return { completion in
            transform() { output in
                queue.async {
                    completion(output)
                }
            }
        }
}

public func |> <T>(
    queue: DispatchQueue,
    transform: @escaping Pipeline.AsyncSource<T>)
    -> Pipeline.AsyncSource<T> {
        return { completion in
            queue.async {
                transform(completion)
            }
        }
}
