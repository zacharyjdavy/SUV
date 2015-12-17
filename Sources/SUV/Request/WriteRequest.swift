import libUV

public class WriteRequest {
  public typealias Pointer = UnsafeMutablePointer<UVWrite>
  public let pointer: Pointer

  public init() {
    self.pointer = UnsafeMutablePointer.alloc(sizeof(UVWrite))
  }

  public init(_ pointer: Pointer) {
    self.pointer = pointer
  }

  public func write(stream: StreamHandle, _ buffer: Buffer, callback: (WriteRequest, Status) -> Void) -> Status {
    self.pointer.memory.data = Cast.toVoid(callback)

    return Status(uv_write(pointer, stream.pointer, buffer.pointer, 1) { request, status in
      let callback: (WriteRequest, Status) -> Void = Cast.fromVoid(request.memory.data)!
      callback(WriteRequest(request), Status(status))
    })
  }

  public func free() {
    self.pointer.dealloc(sizeofValue(self.pointer))
  }
}