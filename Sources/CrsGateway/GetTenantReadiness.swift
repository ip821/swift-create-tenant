import Foundation

public enum TenantKind: Int, Encodable {
    case tenant = 0
    case template = 1
}

public struct GetTenantReadinessRequest: Encodable {
    public let tenantKind: TenantKind
    public let tenantName: String
}

public struct TenantReadyResultKind: Decodable, OptionSet {
    public let rawValue: Int

    public static let ready = TenantReadyResultKind(rawValue: 0)
    public static let awaitingDatabases = TenantReadyResultKind(rawValue: 1)
    public static let awaitingModelInits = TenantReadyResultKind(rawValue: 2)
    public static let awaitingMetadata = TenantReadyResultKind(rawValue: 4)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct TenantReadinessResult: Decodable {
    public let resultKind: TenantReadyResultKind;
}

