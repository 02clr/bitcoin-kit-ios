//
//  PongMessage.swift
//  BitcoinKit
//
//  Created by Kishikawa Katsumi on 2018/02/11.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import Foundation

/// The pong message is sent in response to a ping message.
/// In modern protocol versions, a pong response is generated using a nonce included in the ping.
struct PongMessage: IMessage{
    /// nonce from ping
    let nonce: UInt64

    init(nonce: UInt64) {
        self.nonce = nonce
    }

    init(_ data: Data) {
        let byteStream = ByteStream(data)
        nonce = byteStream.read(UInt64.self)
    }

    func serialized() -> Data {
        var data = Data()
        data += nonce
        return data
    }

}
