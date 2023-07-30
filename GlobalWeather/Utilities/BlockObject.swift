import UIKit

public class BlockObject<Value, ReturnValue> {
    private var block: ((_ arg: Value) -> ReturnValue)?
    public let identifier = UUID()
    private var subscribers: [UUID: BlockObject<Value, Void>] = [:]
    
    public init(block: ((_ arg: Value) -> ReturnValue)?) {
        self.block = block
    }
    
    public func execute(_ arg: Value) -> ReturnValue? {
        defer {
            subscribers.forEach { $1.execute(arg) }
        }
        return block?(arg)
    }
    
    public func add(_ subscriber: BlockObject<Value, Void>) {
        subscribers[subscriber.identifier] = subscriber
    }
    
    public func remove(_ subscriberId: UUID) {
        subscribers[subscriberId] = nil
    }
}

public typealias StringBlock = BlockObject<String?, Void>
public typealias EmptyBlock = BlockObject<Void, Void>
public typealias ErrorBlock = BlockObject<Error, Void>
public typealias ImageBlock = BlockObject<UIImage, Void>
public typealias ProgressBlock = BlockObject<Double, Void>
public typealias BoolBlock = BlockObject<Bool, Void>

