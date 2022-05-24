import Foundation
import HTTPClient

struct HttpRequest<TResponse: Decodable>: Request {

    init(
            path: String,
            headers: [HTTPHeaderField: String],
            responseType: TResponse.Type
    ) {
        self.path = path
        self.httpHeaders = headers
    }

    typealias ResponseBody = TResponse

    var path: String = ""

    var httpMethod: HTTPMethod {
        .post
    }

    var httpHeaders: [HTTPHeaderField: String]?
}