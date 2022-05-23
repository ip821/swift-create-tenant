import Foundation
import CrsServerConnection

public extension HttpClient {

    func getAllFeatures(authentication token: String) async throws -> HttpResponseResult<[Feature]> {
        try await self.call(
                        "/api/appBuilder/feature/getAllFeatures",
                        EmptyRequest(),
                        authentication: token,
                        responseType: [Feature].self
                )
    }

}