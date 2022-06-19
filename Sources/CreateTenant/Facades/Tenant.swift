import Foundation
import CrsServerConnection

class TenantFacade {

    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func createAndWaitReady(
            authentication token: String,
            tenantName: String,
            use templateId: Int
    ) async throws -> Bool {

        print("Create tenant \(tenantName)...");
        _ = try await httpClient.createTenant(
                authentication: token,
                name: tenantName,
                templateId: templateId)
                .unwrapErrorOrValue()

        print("Waiting for tenant \(tenantName)...");

        return try await httpClient.waitForReady(
                authentication: token,
                forTenant: tenantName,
                andKind: .tenant)

    }

}