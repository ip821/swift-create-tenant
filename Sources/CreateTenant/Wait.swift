import Foundation
import CrsGateway
import CrsServerConnection

extension HttpClient {
    func wait(
            authentication token: String,
            forTenant tenantName: String,
            andKind tenantKind: TenantKind
    ) async throws -> Bool {

        let maxAttempts = 40
        var isReady = false

        for i in 1...maxAttempts {
            try await Task.sleep(nanoseconds: 1_000_000_000 * 5)

            let templateResponse = try await getTenantReadiness(
                    authentication: token,
                    name: tenantName,
                    tenantKind: tenantKind
            )
                    .unwrapHttpResponse()

            if case let .error(error) = templateResponse.errorOrValue {
                print("[\(i)/\(maxAttempts)] \(tenantKind) status: \(error)")
                continue
            }

            let templateResult = try templateResponse.unwrapErrorOrValue()
            let status = templateResult.resultKind == .ready
                    ? "\("ready".green)"
                    : "\("not ready".yellow)"
            print("[\(i)/\(maxAttempts)] \(tenantKind) status: \(status)")

            if templateResult.resultKind == .ready {
                isReady = true
                break
            }
        }

        return isReady
    }
}