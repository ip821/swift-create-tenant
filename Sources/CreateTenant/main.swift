import CrsServerConnection
import CrsSecurity
import CrsAppBuilder
import CrsGateway
import Rainbow
import Swinject
import Foundation

let usage = """
                   Usage: CreateTenant tenant_name url user password
                   """

print("Program started with arguments: \(CommandLine.arguments)")

guard let arguments = CommandLine.parse() else {
    print(usage)
    exit(1)
}

let container = Container()
registerHttp(in: container, withUrl: arguments.url)
registerTypes(in: container)

let program = container.resolve(Program.self)!
await program.execute(arguments)
