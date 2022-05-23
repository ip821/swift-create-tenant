import Foundation
import CrsServerConnection

public extension HttpClient {

    func getTenantReadiness(
            authentication token: String,
            name: String,
            tenantKind: TenantKind
    ) async throws -> HttpResponseResult<TenantReadinessResult> {
        try await call(
                "/api/gateway/tenantDeployment/getTenantReadiness",
                GetTenantReadinessRequest(tenantKind: tenantKind, tenantName: name),
                authentication: token,
                responseType: TenantReadinessResult.self
        )
    }

}