// Copyright © lalacode.io All rights reserved.

import SwiftUI
import Combine

public struct CKSpinner: UIViewRepresentable {
    public let style: UIActivityIndicatorView.Style
    public let hidesWhenStopped: Bool

    @Binding
    public var isAnimating: Bool

    public func makeUIView(context: UIViewRepresentableContext<CKSpinner>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.hidesWhenStopped = hidesWhenStopped
        return activityIndicator
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<CKSpinner>) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

extension CKSpinner {
    public init(isAnimating: Binding<Bool>) {
        self.style = .medium
        self.$isAnimating = isAnimating
        self.hidesWhenStopped = true
    }

    private func instanceWith(style: UIActivityIndicatorView.Style? = nil, hidesWhenStopped: Bool? = nil, isAnimating: Binding<Bool>? = nil) -> CKSpinner {
        return CKSpinner(
            style: style ?? self.style,
            hidesWhenStopped: hidesWhenStopped ?? self.hidesWhenStopped,
            isAnimating: isAnimating ?? self.$isAnimating)
    }

    public func style(_ value: UIActivityIndicatorView.Style) -> CKSpinner {
        return instanceWith(style: value)
    }

    public func hidesWhenStopped(_ value: Bool) -> CKSpinner {
        return instanceWith(hidesWhenStopped: value)
    }
}

#if DEBUG
struct CKSpinner_PreviewContent: View {
    @State var loading: Bool = false

    var body: some View {
        CKSpinner(isAnimating: $loading)
            .style(.medium)
            .hidesWhenStopped(true)
            .tapAction {
                self.loading.toggle()
        }
    }
}

struct CKSpinner_Previews: PreviewProvider {
    @State var loading: Bool = false

    static var previews: some View {
        CKSpinner_PreviewContent()
    }
}
#endif
