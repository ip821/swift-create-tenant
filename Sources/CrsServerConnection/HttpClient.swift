import Foundation
import HTTPClient

//public typealias HttpResponseResult<T: Decodable> = HttpResult<T>

public class HttpClient {

    let url: String
    let httpClient: HTTPClient

    public init(url: String) {
        self.url = url
        httpClient = HTTPClient(baseURLString: url)
    }

    deinit {
//        print("HTTP is shutting down...")
//        try! httpClient.syncShutdown()
//        print("HTTP shutdown completed.")
    }

    public func call<TRequest: Encodable, TResponse: Decodable>(
            _ apiUrlPart: String,
            _ request: TRequest,
            authentication token: String? = nil,
            responseType: TResponse.Type
    )
            async throws -> Response<TResponse> {
        let encodedBody = try JSONEncoder().encode(request)

        var httpHeaders: [HTTPHeaderField: String] = [.contentType: ContentType.applicationJson.rawValue]


        if let accessToken = token {
            httpHeaders.updateValue(accessToken, forKey: .authorization)
        }

        let httpRequest = HttpRequest(
                path: apiUrlPart,
                headers: httpHeaders,
                responseType: Response<TResponse>.self
        )

        let responseBody = try await httpClient.request(httpRequest, requestBody: request)
        return responseBody
    }

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
}
