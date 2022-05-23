import Foundation
import AsyncHTTPClient

public typealias HttpResponseResult<T: Decodable> = HttpResult<T>

public class HttpClient {

    let url: String
    let httpClient: AsyncHTTPClient.HTTPClient

    public init(url: String) {
        self.url = url
        httpClient = AsyncHTTPClient.HTTPClient(eventLoopGroupProvider: .createNew)
    }

    public func call<TRequest: Encodable, TResponse: Decodable>(
            _ apiUrlPart: String,
            _ request: TRequest,
            authentication token: String? = nil,
            responseType: TResponse.Type
    )
            async throws
            -> HttpResponseResult<TResponse> {
        let encodedBody = try JSONEncoder().encode(request)

        var httpRequest = HTTPClientRequest(url: url + apiUrlPart)
        httpRequest.method = .POST
        httpRequest.body = .bytes(encodedBody)
        httpRequest.headers.add(name: "Content-Type", value: "application/json")

        if let accessToken = token {
            httpRequest.headers.add(name: "Authorization", value: accessToken)
        }

        let httpResponse = try await httpClient.execute(httpRequest, timeout: .seconds(5))
        return try await HttpResponseResult<TResponse>(httpResponse: httpResponse)
    }

    public func shutdown() throws {
        try httpClient.syncShutdown()
    }

}
