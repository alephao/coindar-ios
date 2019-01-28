// Copyright © lalacode.io All rights reserved.

// MARK: Apply
precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence
}
infix operator |>: ForwardApplication
public func |> <A, B>(_ a: A, _ f: (A) -> B) -> B {
    return f(a)
}

// MARK: Compose
precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}
infix operator >>>: ForwardComposition
public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in
        g(f(a))
    }
}
