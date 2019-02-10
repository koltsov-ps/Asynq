import Foundation

public func |> <T, U>(
    transform: @escaping Pipeline.AsyncTransform<T, U>,
    queue: DispatchQueue)
    -> Pipeline.AsyncTransform<T, U> {
    return { input, completion in
        transform(input) { output in
            queue.async {
                completion(output)
            }
        }
    }
}

public func |> <T, U>(
    queue: DispatchQueue,
    transform: @escaping Pipeline.AsyncTransform<T, U>)
    -> Pipeline.AsyncTransform<T, U> {
    return { input, completion in
        queue.async {
            transform(input) { output in
                completion(output)
            }
        }
    }
}
