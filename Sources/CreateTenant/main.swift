import CrsServerConnection
import CrsSecurity
import CrsAppBuilder
import CrsGateway
import Rainbow

_runAsyncMain(App.main)

struct App {

    static let usage = """
                       Usage: CreateTenant tenant_name url user password
                       """

    static func main() async throws {

        print("Program started with arguments: \(CommandLine.arguments)")

        guard let arguments = CommandLine.parse() else {
            print(usage)
            return
        }

        let httpClient = HttpClient(url: arguments.url)

        do {
            guard let accessToken = try await httpClient.loginToDefaultTenant(
                    arguments.user,
                    arguments.password)
            else {
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

            guard let templateId = try await httpClient.createTemplateAndWait(
                    authentication: accessToken,
                    templateName: templateName,
                    with: featureIds)
            else {
                print("Template is not created!".red)
                return
            }

            let tenantName = templateName + "t"

            guard try await httpClient.createTenantAndWait(
                    authentication: accessToken,
                    tenantName: tenantName,
                    templateId: templateId)
            else {
                print("Tenant is not created!".red)
                return
            }

            print("Tenant created!".green)

        } catch {
            print("\(error)".red)
        }
    }
}
