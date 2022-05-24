import Foundation
import CrsServerConnection

public extension HttpClient {

    func createTemplate(
            authentication token: String,
            name: String,
            with featureIds: [Int]
    ) async throws -> Response<Int> {
        let command = CreateTemplateCommand(name, featureIds)
        return try await call(
                "/api/appBuilder/template/createTemplate",
                command,
                authentication: token,
                responseType: Response<Int>.self
        )
    }

}