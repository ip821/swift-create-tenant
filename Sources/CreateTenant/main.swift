import CrsServerConnection
import CrsSecurity
import CrsAppBuilder
import CrsGateway
import Rainbow
import Swinject

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

        let container = Container()
        registerHttp(in: container, withUrl: arguments.url)
        registerTypes(in: container)

        let program = container.resolve(Program.self)!
        await program.execute(arguments)
    }
}
