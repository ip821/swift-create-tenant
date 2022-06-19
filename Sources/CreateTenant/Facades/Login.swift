import Foundation
import CrsServerConnection
import CrsSecurity

class LoginFacade {

    private let httpClient: HttpClient

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    func toDefaultTenant(
            _ userName: String,
            _ password: String
    ) async throws -> String? {

        print("Login...");
        let loginResponse = try await httpClient
                .login(
                        userNameOrEMail: userName,
                        password: password)
                .unwrapErrorOrValue()

        switch loginResponse {
        case let .failed(errorCode):
            print("\("Login failed, error code: \(errorCode)".red)")
            return .none

        case let .success(token, tokenId):
            print("Successful login. TokenId: \(tokenId)")
            return token
        }
    }
}