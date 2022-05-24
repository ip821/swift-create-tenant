import Foundation
import HTTPClient

public class HttpClient {

    let url: String
    let httpClient: HTTPClient

    public init(url: String) {
        self.url = url
        httpClient = HTTPClient(baseURLString: url)
    }

    public func call<TRequest: Encodable, TResponse: IResponse>(
            _ apiUrlPart: String,
            _ request: TRequest,
            authentication token: String? = nil,
            responseType: TResponse.Type
    ) async throws -> TResponse {
        var httpHeaders: [HTTPHeaderField: String] = [:]

        httpHeaders[.contentType] = ContentType.applicationJson.rawValue

        if let accessToken = token {
            httpHeaders[.authorization] = accessToken
        }

        let httpRequest = HttpRequest(
                path: apiUrlPart,
                headers: httpHeaders,
                responseType: TResponse.self
        )

        let responseBody = try await httpClient.request(httpRequest, requestBody: request)
        return responseBody
    }
}
