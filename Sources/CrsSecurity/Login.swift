//
// Created by Igor Palkin on 22.05.2022.
//

import Foundation
import CrsServerConnection

public extension HttpClient {

    func login(
            tenantDomainName: String,
            userNameOrEMail: String,
            password: String
    ) async throws -> LoginResult {
        try await self.call(
                        "/api/security/authentication/login",
                        LoginRequest(tenantDomainName: tenantDomainName, userNameOrEMail: userNameOrEMail, password: password),
                        responseType: LoginResult.self
                )
                .unwrap()
    }
}
