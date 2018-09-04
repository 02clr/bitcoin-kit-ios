//
//  InventoryMessage.swift
//  BitcoinKit
//
//  Created by Kishikawa Katsumi on 2018/02/11.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import Foundation

/// Allows a node to advertise its knowledge of one or more objects. It can be received unsolicited, or in reply to getblocks.
struct InventoryMessage: IMessage{
    /// Number of inventory entries
    let count: VarInt
    /// Inventory vectors
    let inventoryItems: [InventoryItem]

    init(count: VarInt, inventoryItems: [InventoryItem]) {
        self.count = count
        self.inventoryItems = inventoryItems
    }

    init(_ data: Data) {
        let byteStream = ByteStream(data)

        count = byteStream.read(VarInt.self)

        var items = [InventoryItem]()
        for _ in 0..<Int(count.underlyingValue) {
            items.append(InventoryItem(byteStream))
        }

        inventoryItems = items
    }

    func serialized() -> Data {
        var data = Data()
        data += count.serialized()
        data += inventoryItems.flatMap { $0.serialized() }
        return data
    }

}
