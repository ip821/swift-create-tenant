import Foundation
import CrsServerConnection

public extension HttpClient {

    func createTenant(
            authentication token: String,
            name: String,
            templateId: Int
    ) async throws -> Response<Int> {
        let command = CreateTenantCommand(
                templateId: templateId,
                tenantDomainName: name,
                tenantName: name
        )
        return try await call(
                "/api/appBuilder/tenant/createTenant",
                command,
                authentication: token,
                responseType: Response<Int>.self
        )
    }

}