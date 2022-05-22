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
                    password: "1234"
            )

            let token: String
            switch loginResponse {
            case .failed(let errorCode):
                print("Login failed, error code: \(errorCode)")
                return

            case .success(let loginResult):
                print("Successful login. TokenId: \(loginResult.tokenId)")
                token = loginResult.token!
            }
        } catch {
            print(error)
        }
    }
}

_runAsyncMain(App.main)