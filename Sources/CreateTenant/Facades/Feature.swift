import Foundation
import CrsServerConnection
import CrsAppBuilder

class FeatureFacade {

    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func getAll(authentication token: String) async throws -> [Feature] {
        print("Retrieve features...");
        return try await httpClient
                .getAllFeatures(authentication: token)
                .unwrapErrorOrValue()
    }
}
