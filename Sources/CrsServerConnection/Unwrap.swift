import Foundation

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