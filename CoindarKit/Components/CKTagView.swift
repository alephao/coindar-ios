// Copyright © lalacode.io All rights reserved.

import SwiftUI

public struct CKTagView : View {

    public let text: String
    public let color: CKColor

    public var body: some View {
        Text(text)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(color.swiftUi)
    }
}

public extension CKTagView {
    init(text: String) {
        self.text = text
        self.color = CKColor.link
    }

    func color(_ ckColor: CKColor) -> CKTagView {
        return CKTagView(text: text, color: ckColor)
    }
}

#if DEBUG
struct CKTagView_Previews : PreviewProvider {
    static var previews: some View {
        CKTagView(text: "AMA")
    }
}
#endif
