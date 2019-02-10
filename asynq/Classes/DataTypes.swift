import Foundation

public struct Pipeline {
    public typealias Transform<In, Out> = (In) -> Out
    
    public typealias FailableTransform<In, Out> = (In) throws -> Out
    
    public typealias AsyncTransform<In, Out> = (In, @escaping (Out) -> Void) -> Void
    
    public typealias FailableAsyncTransform<In, Out> = (In, @escaping (Out?, Error?) -> Void) -> Void
    
    public typealias AsyncSource<Out> = (@escaping (Out) -> Void) -> Void
    
    public typealias FailableAsyncSource<Out> = (@escaping (Out?, Error?) -> Void) -> Void
}

infix operator |>: LogicalConjunctionPrecedence
