import Foundation
import AsyncHTTPClient
import NIOHTTP1

public enum HttpResult<T: Decodable> {
    case success(_ payload: Response<T>)
    case error(_ status: HTTPResponseStatus)

    init(httpResponse: HTTPClientResponse) async throws {
        switch httpResponse.status {

        case .ok:
            let body = try await httpResponse.body.collect(upTo: 1024 * 1024)

//            let stringBody = String(buffer: body)
//            print("HTTP Response: \(stringBody)")

            let result = try JSONDecoder().decode(Response<T>.self, from: body)
            self = .success(result)

        default:
            self = .error(httpResponse.status)

        }
    }
}