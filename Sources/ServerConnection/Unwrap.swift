import Foundation
import AsyncHTTPClient
import NIOHTTP1

public struct HttpError: Error {
    let status: HTTPResponseStatus
}

public extension HttpResponseResult where T: Decodable {
    func unwrapHttpResponse() throws -> T {
        switch self {

        case .success(let result):
            return result

        case .error(let status):
            throw HttpError(status: status)
        }
    }
}

public struct CrsError: Error {
    let errorCode: Int
}

public extension Response where T: Decodable {

    func unwrapErrorOrValue() throws -> T {
        switch errorOrValue {

        case .success(value: let value):
            return value

        case .error(errorCode: let errorCode):
            throw CrsError(errorCode: errorCode)
        }
    }

}