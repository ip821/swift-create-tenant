import Foundation

struct Arguments {
    let url: String
    let tenant: String
    let user: String
    let password: String
}

extension CommandLine {

    static func parse() -> Arguments? {
        if arguments.count < 5 {
            return nil
        }

        let tenant = arguments[1]
        let url = arguments[2]
        let user = arguments[3]
        let password = arguments[4]
        let arguments = Arguments(
                url: url,
                tenant: tenant,
                user: user,
                password: password
        )
        return arguments
    }

}