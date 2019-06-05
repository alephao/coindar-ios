// Copyright © lalacode.io All rights reserved.

import SwiftUI

public struct CKTagView : View {

    public let text: String
    public let backgroundColor: CKColor

    public var body: some View {
        Text(text)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(backgroundColor.swiftUi)
    }
}

public extension CKTagView {
    init(_ text: String, backgroundColor: CKColor) {
        self.text = text
        self.backgroundColor = backgroundColor
    }
}

#if DEBUG
struct CKTagView_Previews : PreviewProvider {
    static var previews: some View {
        CKTagView(text: "AMA", backgroundColor: .tagAma)
    }
}
#endif
