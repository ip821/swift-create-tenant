import Foundation

public enum LoginResponse {
    case success(loginResult: LoginResult)
    case failed(resultCode: LoginResultCode)
}
