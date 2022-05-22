import Foundation

public enum LoginResultCode: Int, Decodable {
    case success = 1
    case invalidCredentials = 2
    case userDisabled = 3
    case ipBlocked = 4
    case oneTimePasswordIsRequired = 5
    case invalidOneTimePassword = 6
    case waitBeforeNextAttempt = 7
}

public struct LoginResult: Decodable {
    public let resultCode: LoginResultCode
    public let token: String?
    public let tokenId: String?
}
