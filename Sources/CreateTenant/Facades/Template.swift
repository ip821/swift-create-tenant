import Foundation
import CrsServerConnection

class TemplateFacade {

    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func createAndWaitReady(
            authentication token: String,
            templateName: String,
            with featureIds: [Int]
    ) async throws -> Int? {

        print("Create template \(templateName)...");
        let templateId = try await httpClient
                .createTemplate(
                        authentication: token,
                        name: templateName,
                        with: featureIds
                )
                .unwrapErrorOrValue()

        print("Waiting for template \(templateName)...");

        let templateReady = try await httpClient
                .waitForReady(
                        authentication: token,
                        forTenant: templateName,
                        andKind: .template)

        return templateReady ? templateId : .none
    }
}