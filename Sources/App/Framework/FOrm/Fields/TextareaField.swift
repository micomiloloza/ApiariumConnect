//
//  TextareaField.swift
//  
//
//  Created by Mico Miloloza on 30.07.2023..
//

import Vapor


public final class TextareaField: AbstractFormField<String, TextareaFieldTemplate> {
    public convenience init(_ key: String) {
        self.init(
            key: key,
            input: "",
            output: .init(
                .init(key: key)
            )
        )
    }
    
    public override func process(req: Request) async throws {
        try await super.process(req: req)
        output.context.value = input
    }
    
    public override func render(req: Request) -> TemplateRepresentable {
        output.context.error = error
        return super.render(req: req)
    }
}
