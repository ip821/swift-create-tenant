import Foundation

public struct LoginRequest: Encodable {
    public let tenantDomainName: String
    public let userNameOrEMail: String
    public let password: String

    public init(tenantDomainName: String, userNameOrEMail: String, password: String) {
        self.tenantDomainName = tenantDomainName
        self.userNameOrEMail = userNameOrEMail
        self.password = password
    }
}
