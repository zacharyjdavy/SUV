import libUV

public typealias UVWriteFn = (UnsafeMutablePointer<uv_write_t>, UnsafeMutablePointer<uv_stream_t>, UnsafePointer<uv_buf_t>, UInt32, UVWriteCallback) -> Int32
public let UVWrite: UVWriteFn = uv_write