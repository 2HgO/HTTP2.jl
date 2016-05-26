type ContinuationFrame
    is_end_headers::Bool
    stream_identifier::UInt32
    fragment::Array{UInt8, 1}
end

function decode_continuation(header, payload)
    is_end_headers = header.flags & 0x4 == 0x4

    return ContinuationFrame(is_end_headers, header.stream_identifier, payload)
end

function encode_continuation(frame)
    flags = 0x0 | frame.is_end_headers ? 0x4 : 0x0

    return wrap_payload(frame.fragment, CONTINUATION, flags, frame.stream_identifier)
end
