import Foundation
import CrsServerConnection

public extension HttpClient {

    func createTenant(
            authentication token: String,
            name: String,
            templateId: Int
    ) async throws -> HttpResponseResult<Int> {
        try await call(
                "/api/appBuilder/tenant/createTenant",
                CreateTenantCommand(
                        templateId: templateId,
                        tenantDomainName: name,
                        tenantName: name
                ),
                authentication: token,
                responseType: Int.self
        )
    }

}