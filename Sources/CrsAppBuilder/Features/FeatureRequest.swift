import Foundation

public struct EmptyRequest: Encodable {

}

public struct Feature: Decodable {
    public let declaredInService: String
    public let id: Int
    public let systemName: String
}