import Foundation

public enum LoginResult: Decodable {
    case success(token: String, tokenId: String)
    case failed(errorCode: LoginResultCode)
}

public extension LoginResult {
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case tokenId = "tokenId"
        case resultCode = "resultCode"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultCode = try container.decode(LoginResultCode.self, forKey: CodingKeys.resultCode)

        switch resultCode {
        case .success:
            self = .success(
                    token: try container.decode(String.self, forKey: CodingKeys.token),
                    tokenId: try container.decode(String.self, forKey: CodingKeys.tokenId)
            )

        default:
            self = .failed(errorCode: resultCode)
        }
    }

}