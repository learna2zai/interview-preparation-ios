import Foundation

// MARK: - Builder Pattern
// its a cdp that allows us to construct complex objects step by step by producing different types and representations of an object using the same construction code.

//protocol Document: CustomStringConvertible {
//    var title: String? {get}
//    var body: String? {get}
//    var footer: String? {get}
//    var image: String? {get}
//    
//    mutating func setTitle(_ title: String)
//    mutating func setBody(_ body: String)
//    mutating func setFooter(_ footer: String)
//    mutating func setImage(_ image: String)
//}

//struct ExcelDocument: CustomStringConvertible {
//    var title: String
//    var body: String
//    var footer: String
//    var image: String
//    
//    var description: String {
//        " Title: \(title ?? "")\n Body: \(body ?? "")\n Footer: \(footer ?? "")\n Image: \(image ?? "None")"
//    }
//    
////    mutating func setTitle(_ title: String)
////    mutating func setBody(_ body: String)
////    mutating func setFooter(_ footer: String)
////    mutating func setImage(_ image: String)
//}
//
//protocol DocumentBuilder {
//    func createTitle(_ title: String) -> Self
//    func createBody(_ body: String) -> Self
//    func createFooter(_ footer: String) -> Self
//    func addImage(_ image: String) -> Self
//    func build() -> Document
//}
//
////struct ExcelDocument: Document {
////    private(set) var title: String?
////    private(set) var body: String?
////    private(set) var footer: String?
////    private(set) var image: String?
////    
////    init(title: String? = nil, body: String? = nil, footer: String? = nil, image: String? = nil) {
////        self.title = title
////        self.body = body
////        self.footer = footer
////        self.image = image
////    }
////    
////    mutating func setTitle(_ title: String) {
////        self.title = title
////    }
////    
////    mutating func setBody(_ body: String) {
////        self.body = body
////    }
////    
////    mutating func setFooter(_ footer: String) {
////        self.footer = footer
////    }
////    
////    mutating func setImage(_ image: String) {
////        self.image = image
////    }
////
////    var description: String {
////        " Title: \(title ?? "")\n Body: \(body ?? "")\n Footer: \(footer ?? "")\n Image: \(image ?? "None")"
////    }
////}
//
//class ExcelDocumentBuilder: DocumentBuilder {
//    enum Steps {
//        case title(String)
//        case body(String)
//        case footer(String)
//        case image(String)
//    }
//    
//    private(set) var steps: [Steps] = []
//    
//    func createTitle(_ title: String) -> Self {
//        steps.append(.title(title))
//        return self
//    }
//    
//    func createBody(_ body: String) -> Self {
//        steps.append(.body(body))
//        return self
//    }
//    
//    func createFooter(_ footer: String) -> Self {
//        steps.append(.footer(footer))
//        return self
//    }
//    
//    func addImage(_ image: String) -> Self {
//        steps.append(.image(image))
//        return self
//    }
//    
//    func build() -> ExcelDocument {
//        ExcelDocument(title: <#T##String#>, body: <#T##String#>, footer: <#T##String#>, image: <#T##String#>)
//        DocumentProvider(document: ExcelDocument()).makeDocument(with: steps)
//    }
//}
//
////class DocumentProvider {
////
////    private var document: Document
////    
////    init(document: Document) {
////        self.document = document
////    }
////    
////    func makeDocument(with steps: [ExcelDocumentBuilder.Steps]) -> Document {
////        steps.forEach { step in
////            switch step {
////                case .title(let title):
////                    document.setTitle(title)
////                case .body(let body):
////                    document.setBody(body)
////                case .footer(let footer):
////                    document.setFooter(footer)
////                case .image(let image):
////                    document.setImage(image)
////            }
////        }
////        return document
////    }
////}
//
//let excelDocument = ExcelDocumentBuilder()
//    .createTitle("Excel Document")
//    .addImage("https://example.com/image.png")
//    .createBody("Excel Document Body")
//    .createFooter("Excel Document Footer")
//    .build()
//                    
//
//print(excelDocument.description)




//:  [Previous](@previous) | [Next](@next)
