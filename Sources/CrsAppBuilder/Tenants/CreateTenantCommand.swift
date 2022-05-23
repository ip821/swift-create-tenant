import Foundation

public struct CreateTenantCommand: Encodable {

    public let modelType = "CreateTenantCommand"

    public let templateId: Int;
    public let tenantDomainName: String;
    public let tenantName: String;

}