//
// Created by Igor Palkin on 22.05.2022.
//

import Foundation
import AsyncHTTPClient

public extension HttpClient {

    func login(
            tenantDomainName: String,
            userNameOrEMail: String,
            password: String
    ) async throws -> LoginResponse {
        let result = try await self.call(
                        "/api/security/authentication/login",
                        LoginRequest(tenantDomainName: tenantDomainName, userNameOrEMail: userNameOrEMail, password: password),
                        responseType: LoginResult.self
                )
                .unwrapHttpResponse()
                .unwrapErrorOrValue()

        switch result.resultCode {
        case .success:
            return .success(loginResult: result)

        default:
            return .failed(resultCode: result.resultCode)
        }
    }
}
