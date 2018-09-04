import Foundation

class BitcoinRegTest: NetworkProtocol {
    let name = "bitcoin-reg-test"
    let pubKeyHash: UInt8 = 0x6f
    let privateKey: UInt8 = 0xef
    let scriptHash: UInt8 = 0xc4
    let pubKeyPrefixPattern: String = "m|n"
    let scriptPrefixPattern: String = "2"
    let xPubKey: UInt32 = 0x043587cf
    let xPrivKey: UInt32 = 0x04358394
    let magic: UInt32 = 0xfabfb5da
    let port: UInt32 = 18444
    let coinType: UInt32 = 1

    let dnsSeeds = [
        "blocknode01.grouvi.org",
        "blocknode02.grouvi.org",
        "blocknode03.grouvi.org",
        "blocknode04.grouvi.org",
    ]

    let genesisBlock = Block(
            withHeader: BlockHeader(
                    version: 1,
                    previousBlockHeaderReversedHex: "0000000000000000000000000000000000000000000000000000000000000000",
                    merkleRootReversedHex: "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b",
                    timestamp: 1296688602,
                    bits: 545259519,
                    nonce: 2
            ),
            height: 0)

    let checkpointBlock = Block(
            withHeader: BlockHeader(
                    version: 1,
                    previousBlockHeaderReversedHex: "0000000000000000000000000000000000000000000000000000000000000000",
                    merkleRootReversedHex: "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b",
                    timestamp: 1296688602,
                    bits: 545259519,
                    nonce: 2
            ),
            height: 0)

}
