import Foundation
import CrsServerConnection
import CrsSecurity

extension HttpClient {
    func loginToDefaultTenant(
            _ userName: String,
            _ password: String
    ) async throws -> String? {

        print("Login...");
        let loginResponse = try await login(
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