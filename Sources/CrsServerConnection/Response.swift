import Foundation

public enum ErrorOrValue<T: Decodable>: Decodable {
    case success(value: T)
    case error(error: GenericError)

    enum CodingKeys: String, CodingKey {
        case success = "value"
        case error = "error"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let error = try container.decodeIfPresent(GenericError.self, forKey: CodingKeys.error)

        if let decodedError = error {
            self = .error(error: decodedError)
        } else {
            let value: T = try container.decode(T.self, forKey: CodingKeys.success)
            self = .success(value: value)
        }
    }
}

public protocol IResponse: Decodable {
    associatedtype T where T: Decodable
    var errorOrValue: ErrorOrValue<T> { get }

}

public struct Response<T: Decodable>: Decodable, IResponse {
    public let modelType: String
    public let errorOrValue: ErrorOrValue<T>
}

public struct UnitType: Decodable {

}