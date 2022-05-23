import Foundation

struct CreateTemplateCommand: Encodable {
    let modelType = "CreateTemplateCommand"
    let templateName: String
    let modelUpdates: [ChangeTemplateFeaturesUpdate]

    init(_ name: String, _ featureIds: [Int]) {
        self.templateName = name
        modelUpdates = [ChangeTemplateFeaturesUpdate(featureIdsToAdd: featureIds)]
    }
}

struct ChangeTemplateFeaturesUpdate: Encodable {
    let featureIdsToAdd: [Int]
    let modelType = "ChangeTemplateFeaturesUpdate"
}