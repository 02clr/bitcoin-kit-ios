import Foundation
import Cuckoo
import RealmSwift
@testable import WalletKit

class MockWalletKit {

    let mockDifficultyEncoder: MockDifficultyEncoder
    let mockDifficultyCalculator: MockDifficultyCalculator

    let mockNetwork: MockNetworkProtocol
    let mockBlockValidator: MockBlockValidator

    let mockRealmFactory: MockRealmFactory

    let mockHdWallet: MockHDWallet

    let mockStateManager: MockStateManager
    let mockApiManager: MockApiManager
    let mockAddressManager: MockAddressManager

    let mockPeerGroup: MockPeerGroup
    let mockSyncer: MockSyncer
    let mockFactory: MockFactory

    let mockInitialSyncer: MockInitialSyncer
    let mockProgressSyncer: MockProgressSyncer
    let mockBlockSyncer: MockBlockSyncer

    let mockValidatedBlockFactory: MockValidatedBlockFactory

    let mockHeaderSyncer: MockHeaderSyncer
    let mockHeaderHandler: MockHeaderHandler

    let mockAddressConverter: MockAddressConverter
    let mockScriptConverter: MockScriptConverter
    let mockTransactionProcessor: MockTransactionProcessor
    let mockTransactionExtractor: MockTransactionExtractor
    let mockTransactionLinker: MockTransactionLinker
    let mockTransactionHandler: MockTransactionHandler
    let mockTransactionSender: MockTransactionSender
    let mockTransactionCreator: MockTransactionCreator
    let mockTransactionBuilder: MockTransactionBuilder

    let mockInputSigner: MockInputSigner
    let mockScriptBuilder: MockScriptBuilder
    let mockTransactionSizeCalculator: MockTransactionSizeCalculator
    let mockUnspentOutputSelector: MockUnspentOutputSelector
    let mockUnspentOutputProvider: MockUnspentOutputProvider

    let realm: Realm

    public init() {
        mockDifficultyEncoder = MockDifficultyEncoder()
        mockDifficultyCalculator = MockDifficultyCalculator(difficultyEncoder: mockDifficultyEncoder)

        mockNetwork = MockNetworkProtocol()
        mockBlockValidator = MockBlockValidator(calculator: mockDifficultyCalculator)

        stub(mockNetwork) { mock in
            when(mock.coinType.get).thenReturn(1)
            when(mock.dnsSeeds.get).thenReturn([""])
            when(mock.port.get).thenReturn(0)
        }

        mockRealmFactory = MockRealmFactory(configuration: Realm.Configuration())

        mockHdWallet = MockHDWallet(seed: Data(), network: mockNetwork)

        mockStateManager = MockStateManager(realmFactory: mockRealmFactory)
        mockApiManager = MockApiManager(apiUrl: "")

        mockPeerGroup = MockPeerGroup(realmFactory: mockRealmFactory, network: mockNetwork)
        mockSyncer = MockSyncer(realmFactory: mockRealmFactory)
        mockFactory = MockFactory()

        mockInitialSyncer = MockInitialSyncer(realmFactory: mockRealmFactory, hdWallet: mockHdWallet, stateManager: mockStateManager, apiManager: mockApiManager, factory: mockFactory, peerGroup: mockPeerGroup, network: mockNetwork)
        mockProgressSyncer = MockProgressSyncer(realmFactory: mockRealmFactory)
        mockAddressManager = MockAddressManager(realmFactory: mockRealmFactory, hdWallet: mockHdWallet, peerGroup: mockPeerGroup)
        mockBlockSyncer = MockBlockSyncer(realmFactory: mockRealmFactory, peerGroup: mockPeerGroup)

        mockValidatedBlockFactory = MockValidatedBlockFactory(realmFactory: mockRealmFactory, factory: mockFactory, validator: mockBlockValidator, network: mockNetwork)

        mockHeaderSyncer = MockHeaderSyncer(realmFactory: mockRealmFactory, peerGroup: mockPeerGroup, network: mockNetwork)
        mockHeaderHandler = MockHeaderHandler(realmFactory: mockRealmFactory, validateBlockFactory: mockValidatedBlockFactory, blockSyncer: mockBlockSyncer)

        mockInputSigner = MockInputSigner(hdWallet: mockHdWallet)
        mockScriptBuilder = MockScriptBuilder()

        mockTransactionSizeCalculator = MockTransactionSizeCalculator()
        mockUnspentOutputSelector = MockUnspentOutputSelector(calculator: mockTransactionSizeCalculator)
        mockUnspentOutputProvider = MockUnspentOutputProvider(realmFactory: mockRealmFactory)

        mockAddressConverter = MockAddressConverter(network: mockNetwork)
        mockScriptConverter = MockScriptConverter()
        mockTransactionExtractor = MockTransactionExtractor(scriptConverter: mockScriptConverter, addressConverter: mockAddressConverter)
        mockTransactionLinker = MockTransactionLinker()
        mockTransactionProcessor = MockTransactionProcessor(realmFactory: mockRealmFactory, extractor: mockTransactionExtractor, linker: mockTransactionLinker, addressManager: mockAddressManager)
        mockTransactionHandler = MockTransactionHandler(realmFactory: mockRealmFactory, processor: mockTransactionProcessor, progressSyncer: mockProgressSyncer, validateBlockFactory: mockValidatedBlockFactory)
        mockTransactionSender = MockTransactionSender(realmFactory: mockRealmFactory, peerGroup: mockPeerGroup)
        mockTransactionBuilder = MockTransactionBuilder(unspentOutputSelector: mockUnspentOutputSelector, unspentOutputProvider: mockUnspentOutputProvider, transactionSizeCalculator: mockTransactionSizeCalculator, addressConverter: mockAddressConverter, inputSigner: mockInputSigner, scriptBuilder: mockScriptBuilder, factory: mockFactory)
        mockTransactionCreator = MockTransactionCreator(realmFactory: mockRealmFactory, transactionBuilder: mockTransactionBuilder, transactionProcessor: mockTransactionProcessor, transactionSender: mockTransactionSender, addressManager: mockAddressManager)

//        mockPeerGroup.delegate = mockSyncer
//
//        mockSyncer.headerSyncer = mockHeaderSyncer
//        mockSyncer.headerHandler = mockHeaderHandler
//        mockSyncer.transactionHandler = mockTransactionHandler
//        mockSyncer.blockSyncer = mockBlockSyncer

        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TestRealm"))
        try! realm.write { realm.deleteAll() }

        stub(mockRealmFactory) { mock in
            when(mock.realm.get).thenReturn(realm)
        }
    }

}
