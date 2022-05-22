import ServerConnection

let url = "http://10.120.153.103:9000"

struct App {
    static func main() async throws {

        let httpClient = HttpClient(url: url)

        defer {
            do {
                try httpClient.shutdown()
            } catch {
            }
        }

        do {
            let loginResponse = try await httpClient.login(
                    tenantDomainName: "kidscoolshop",
                    userNameOrEMail: "admin",
                    password: "123"
            )

            let accessToken: String

            switch loginResponse {
            case let .failed(errorCode):
                print("Login failed, error code: \(errorCode)")
                return

            case let .success(token, tokenId):
                print("Successful login. TokenId: \(tokenId)")
                accessToken = token
            }

            print(accessToken)
        } catch {
            print(error)
        }
    }
}

_runAsyncMain(App.main)