//
//  AdminListController.swift
//
//
//  Created by Mico Miloloza on 11.10.2023..
//

import Vapor


protocol AdminListController: ModelController {
    func list(_ req: Request) async throws -> [DatabaseModel]
    func listView(_ req: Request) async throws -> Response
    
    func listColumns() -> [ColumnContext]
    func listCells(for model: DatabaseModel) -> [CellContext]
    func listNavigation(_ req: Request) -> [LinkContext]
    func listBreadcrumbs(_ req: Request) -> [LinkContext]
    
    func listContext(_ req: Request, _ list: [DatabaseModel]) -> AdminListPageContext
    func listTemplate(_ req: Request, _ list: [DatabaseModel]) -> TemplateRepresentable
}

extension AdminListController {
    func list(_ req: Request) async throws -> [DatabaseModel] {
        try await DatabaseModel.query(on: req.db).all()
    }
    
    func listView(_ req: Request) async throws -> Response {
        let list = try await list(req)
        let template = listTemplate(req, list)
        return req.templates.renderHtml(template)
    }
    
    func listNavigation(_ req: Request) -> [LinkContext] {
        [
            LinkContext(label: "create", path: "create")
        ]
    }
    
    func listBreadcrumbs(_ req: Request) -> [LinkContext] {
        [
            LinkContext(label: DatabaseModel.Module.identifier.capitalized, dropLast: 1)
        ]
    }
    
    func listContext(_ req: Request, _ list: [DatabaseModel]) -> AdminListPageContext {
        let rows = list.map {
            RowContext(id: $0.id!.uuidString, cells: listCells(for: $0))
        }
        
        let table = TableContext(columns: listColumns(), rows: rows, actions: [
            LinkContext(label: "Update", path: "update"),
            LinkContext(label: "Delete", path: "delete")
        ])
        
        return .init(title: "List", table: table, navigation: listNavigation(req), breadcrumbs: listBreadcrumbs(req))
    }
    
    func listTemplate(_ req: Request, _ list: [DatabaseModel]) -> TemplateRepresentable {
        AdminListPageTemplate(listContext(req, list))
    }
}
