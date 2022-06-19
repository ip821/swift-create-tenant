import Foundation
import Swinject
import CrsServerConnection

func registerHttp(in container: Container, withUrl url: String) {
    container
            .register(HttpClient.self) { _ in
                HttpClient(url: url)
            }
            .inObjectScope(.container)
}

func registerTypes(in container: Container) {

    container
            .register(LoginFacade.self) { it in
                LoginFacade(httpClient: it.resolve(HttpClient.self)!)
            }

    container
            .register(FeatureFacade.self) { it in
                FeatureFacade(httpClient: it.resolve(HttpClient.self)!)
            }

    container
            .register(TemplateFacade.self) { it in
                TemplateFacade(httpClient: it.resolve(HttpClient.self)!)
            }

    container
            .register(TenantFacade.self) { it in
                TenantFacade(httpClient: it.resolve(HttpClient.self)!)
            }

    container
            .register(Api.self) { it in
                Api(
                        loginFacade: it.resolve(LoginFacade.self)!,
                        templateFacade: it.resolve(TemplateFacade.self)!,
                        tenantFacade: it.resolve(TenantFacade.self)!,
                        featureFacade: it.resolve(FeatureFacade.self)!
                )
            }

    container
            .register(Program.self) { it in
                Program(api: it.resolve(Api.self)!)
            }
}