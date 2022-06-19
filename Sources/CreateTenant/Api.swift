import Foundation
import CrsServerConnection

class Api {

    let login: LoginFacade
    let template: TemplateFacade
    let tenant: TenantFacade
    let features: FeatureFacade

    init(
            loginFacade: LoginFacade,
            templateFacade: TemplateFacade,
            tenantFacade: TenantFacade,
            featureFacade: FeatureFacade
    ) {
        login = loginFacade
        template = templateFacade
        tenant = tenantFacade
        features = featureFacade
    }
}
