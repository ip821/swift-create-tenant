import Foundation

class Program {

    private let api: Api

    init(api: Api) {
        self.api = api
    }

    func execute(_ arguments: Arguments) async {

        do {
            guard let accessToken = try await api.login.toDefaultTenant(
                    arguments.user,
                    arguments.password)
            else {
                return
            }

            let features = try await api.features.getAll(authentication: accessToken)

            let featureIds = features.map { feature in
                feature.id
            }

            let templateName = arguments.tenant

            guard let templateId = try await api.template.createAndWaitReady(
                    authentication: accessToken,
                    templateName: templateName,
                    with: featureIds)
            else {
                print("Template is not created!".red)
                return
            }

            let tenantName = templateName + "t"

            guard try await api.tenant.createAndWaitReady(
                    authentication: accessToken,
                    tenantName: tenantName,
                    use: templateId)
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