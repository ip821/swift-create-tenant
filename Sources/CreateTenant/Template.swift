import Foundation
import CrsServerConnection

extension HttpClient {

    func createTemplateAndWait(
            authentication token: String,
            templateName: String,
            with featureIds: [Int]
    ) async throws -> Int? {

        print("Create template \(templateName)...");
        let templateId = try await createTemplate(
                authentication: token,
                name: templateName,
                with: featureIds
        )
                .unwrapErrorOrValue()

        print("Waiting for template \(templateName)...");

        let templateReady = try await wait(
                authentication: token,
                forTenant: templateName,
                andKind: .template)

        return templateReady ? templateId : .none
    }
}