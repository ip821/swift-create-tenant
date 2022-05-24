import Foundation
import CrsServerConnection

public extension HttpClient {

    func createTemplate(
            authentication token: String,
            name: String,
            with featureIds: [Int]
    ) async throws -> Response<Int> {
        try await call(
                "/api/appBuilder/template/createTemplate",
                CreateTemplateCommand(name, featureIds),
                authentication: token,
                responseType: Int.self
        )
    }

}