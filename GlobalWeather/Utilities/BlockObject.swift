import UIKit

class BlockObject<Value, ReturnValue> {
    private var block: ((_ arg: Value) -> ReturnValue)?
    let identifier = UUID()
    private var subscribers: [UUID: BlockObject<Value, Void>] = [:]
    
    init(block: ((_ arg: Value) -> ReturnValue)?) {
        self.block = block
    }
    
    func execute(_ arg: Value) -> ReturnValue? {
        defer {
            subscribers.forEach { $1.execute(arg) }
        }
        return block?(arg)
    }
    
    func add(_ subscriber: BlockObject<Value, Void>) {
        subscribers[subscriber.identifier] = subscriber
    }
    
    func remove(_ subscriberId: UUID) {
        subscribers[subscriberId] = nil
    }
}

typealias StringBlock = BlockObject<String?, Void>
typealias EmptyBlock = BlockObject<Void, Void>
typealias ErrorBlock = BlockObject<Error, Void>
typealias ImageBlock = BlockObject<UIImage, Void>
typealias ProgressBlock = BlockObject<Double, Void>
typealias BoolBlock = BlockObject<Bool, Void>
