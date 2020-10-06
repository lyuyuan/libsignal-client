import SignalFfi

public class SenderKeyRecord: ClonableHandleOwner {
    internal override class func destroyNativeHandle(_ handle: OpaquePointer) {
        signal_sender_key_record_destroy(handle)
    }

    internal override class func cloneNativeHandle(_ newHandle: inout OpaquePointer?, currentHandle: OpaquePointer?) -> SignalFfiErrorRef? {
        return signal_sender_key_record_clone(&newHandle, currentHandle)
    }

    private var handle: OpaquePointer?

    public init(bytes: [UInt8]) throws {
        var handle: OpaquePointer?
        try checkError(signal_sender_key_record_deserialize(&handle, bytes, bytes.count))
        super.init(owned: handle!)
    }

    internal override init(owned handle: OpaquePointer) {
        super.init(owned: handle)
    }

    internal override init(borrowing handle: OpaquePointer?) {
        super.init(borrowing: handle)
    }

    public init() throws {
        var handle: OpaquePointer?
        try checkError(signal_sender_key_record_new_fresh(&handle))
        super.init(owned: handle!)
    }

    public func serialize() throws -> [UInt8] {
        return try invokeFnReturningArray {
            signal_sender_key_record_serialize(handle, $0, $1)
        }
    }
}
