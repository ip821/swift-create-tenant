import Foundation
import CrsServerConnection

extension HttpClient {

    func createTenantAndWait(
            authentication token: String,
            tenantName: String,
            templateId: Int
    ) async throws -> Bool {

        print("Create tenant \(tenantName)...");
        _ = try await createTenant(
                authentication: token,
                name: tenantName,
                templateId: templateId)
                .unwrapErrorOrValue()

        print("Waiting for tenant \(tenantName)...");

        return try await wait(
                authentication: token,
                forTenant: tenantName,
                andKind: .tenant)

    }

}