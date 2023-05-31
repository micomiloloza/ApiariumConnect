import Fluent
import Vapor
import SwiftHtml


struct TestTemplate: TemplateRepresentable {
    var title: String
    
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Title(title)
            }
            
            Body {
                H1(title)
            }
        }
    }
}

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.routes.get("hello") { req -> Response in
        req.templates.renderHtml(
            TestTemplate(title: "Testing TemplateRepresentable protocol")
        )
    }
}
