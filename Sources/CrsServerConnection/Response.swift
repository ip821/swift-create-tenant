import Foundation

public enum ErrorOrValue<T: Decodable>: Decodable {
    case success(value: T)
    case error(errorCode: Int)
}

extension ErrorOrValue {

    enum CodingKeys: String, CodingKey {
        case success = "value"
        case error = "error"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value: T? = try container.decode(T?.self, forKey: CodingKeys.success)
        let errorCode: Int? = try container.decode(Int?.self, forKey: CodingKeys.error)

        if let value = value {
            self = .success(value: value)
        } else {
            self = .error(errorCode: errorCode!)
        }
    }
}

public struct Response<T: Decodable>: Decodable {
    public let modelType: String
    public let errorOrValue: ErrorOrValue<T>
}
