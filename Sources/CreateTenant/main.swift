import CrsServerConnection
import CrsSecurity
import CrsAppBuilder
import CrsGateway
import Rainbow

_runAsyncMain(App.main)

let usage = """
            Usage: create-tenant tenant_name url user password
            """

struct App {
    static func main() async throws {

        let parsedArgs = CommandLine.parse()

        guard let arguments = parsedArgs else {
            print(usage)
            return
        }

        let httpClient = HttpClient(url: arguments.url)

        do {
            guard let accessToken = try await httpClient.loginToDefaultTenant(arguments.user, arguments.password) else {
                return
            }

            print("Retrieve features...");
            let features = try await httpClient
                    .getAllFeatures(authentication: accessToken)
                    .unwrapErrorOrValue()

            let featureIds = features.map { feature in
                feature.id
            }

            let templateName = arguments.tenant

            let createdTemplateId = try await httpClient.createTemplateAndWait(
                    authentication: accessToken,
                    templateName: templateName,
                    with: featureIds);

            guard let templateId = createdTemplateId else {
                return
            }

            let tenantName = templateName + "t"

            let tenantReady = try await httpClient.createTenantAndWait(
                    authentication: accessToken,
                    tenantName: tenantName,
                    templateId: templateId)

            print(tenantReady
                    ? "\("Tenant created!".green)"
                    : "\("Tenant is not created!".red))")
        } catch {
            print("\(error)".red)
        }
    }
}
