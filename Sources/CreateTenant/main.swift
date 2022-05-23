import CrsServerConnection
import CrsSecurity
import CrsAppBuilder
import CrsGateway
import Rainbow

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

        defer {
            do {
                print("HTTP is shutting down...")
                try httpClient.shutdown()
                print("HTTP shutdown completed.")
            } catch {
                print("HTTP shutdown failed: \(error)")
            }
        }

        do {
            print("Login...");
            let loginResponse = try await httpClient.login(
                            userNameOrEMail: arguments.user,
                            password: arguments.password
                    )
                    .unwrap()

            let accessToken: String

            switch loginResponse {
            case let .failed(errorCode):
                print("Login failed, error code: \(errorCode)")
                return

            case let .success(token, tokenId):
                print("Successful login. TokenId: \(tokenId)")
                accessToken = token
            }

            print("Retrieve features...");
            let features = try await httpClient.getAllFeatures(authentication: accessToken)
                    .unwrap()

            let featureIds = features.map { feature in
                feature.id
            }

            let templateName = arguments.tenant

            print("Create template \(templateName)...");
            let templateId = try await httpClient.createTemplate(
                            authentication: accessToken,
                            name: templateName,
                            with: featureIds
                    )
                    .unwrap()

            print("Waiting for template \(templateName)...");

            let templateReady = try await httpClient.wait(
                    authentication: accessToken,
                    forTenant: templateName,
                    andKind: .template)

            if !templateReady {
                return
            }

            let tenantName = templateName + "t"

            print("Create tenant \(tenantName)...");
            _ = try await httpClient.createTenant(
                            authentication: accessToken,
                            name: tenantName,
                            templateId: templateId)
                    .unwrap()

            print("Waiting for tenant \(tenantName)...");

            let tenantReady = try await httpClient.wait(
                    authentication: accessToken,
                    forTenant: tenantName,
                    andKind: .tenant)

            print(tenantReady
                    ? "\("Tenant created!".green)"
                    : "\("Tenant is not created!".red))")
        } catch {
            print(error)
        }
    }
}

_runAsyncMain(App.main)