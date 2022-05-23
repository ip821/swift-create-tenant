import Foundation

public struct GenericError: Decodable {
    let errorCode: ErrorCode
    let message: String
}

public enum ErrorCode: Int, Decodable {
    case InternalError = 0
    case Validation = 1
    case AccessDenied = 2
    case AuthenticationRequired = 3
    case MethodNotFound = 4

    case NotExists = 5
    case AlreadyExists = 6
    case TenantNotReady = 7

    case CannotDeleteEntityInUse = 8
    case ConcurrencyConflict = 9
    case NoTenant = 10

    case FeatureAccessDenied = 11
    case AppAccessDenied = 12
}