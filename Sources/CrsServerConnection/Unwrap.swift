import Foundation
import AsyncHTTPClient
import NIOHTTP1

public struct HttpError: Error {
    let status: HTTPResponseStatus
}

public struct CrsError: Error, CustomStringConvertible {

    let errorCode: ErrorCode
    let message: String

    init(error: GenericError) {
        errorCode = error.errorCode
        message = error.message
    }

    public var description: String {
        "\(errorCode): \(message)"
    }
}

public extension HttpResponseResult where T: Decodable {
    func unwrap() throws -> T {
        try unwrapHttpResponse().unwrapErrorOrValue()
    }
}

public extension HttpResponseResult where T: Decodable {
    func unwrapHttpResponse() throws -> Response<T> {
        switch self {

        case .success(let result):
            return result

        case .error(let status):
            throw HttpError(status: status)
        }
    }
}

public extension Response where T: Decodable {

    func unwrapErrorOrValue() throws -> T {
        switch errorOrValue {

        case let .success(value):
            return value

        case let .error(error):
            throw CrsError(error: error)
        }
    }

}