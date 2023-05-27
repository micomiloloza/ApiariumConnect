import Fluent
import Vapor
import SwiftHtml


func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.routes.get("hello") { req -> Response in
        let document = Document(.html) {
            Head {
                Title("ApiariumConnect")
            }
            
            Body {
                H1("Welcome to beekeepers database.")
            }
        }
        
        let body = DocumentRenderer(minify: false, indent: 4).render(document)
        
        return Response(status: .ok, headers: ["Content-Type": "text/html; charset=utf-8"], body: .init(string: body))
    }
}
