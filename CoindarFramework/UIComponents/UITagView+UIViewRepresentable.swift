// Copyright © lalacode.io All rights reserved.

import CoindarKit
import SwiftUI
import SnapKit

class _CKTagView : UIView {
    let label = UILabel()

    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 4
        layer.masksToBounds = true

        label.textColor = .white

        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(vertical: 4, horizontal: 8))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setup(with text: String, andBackgroundColor backgroundColor: UIColor) {
        label.text = text
        self.backgroundColor = backgroundColor
    }
}

struct CKTagViewRepresentation : UIViewRepresentable {
    typealias UIViewType = _CKTagView

    let text: String
    let color: CKColor

    func updateUIView(_ uiView: _CKTagView, context: UIViewRepresentableContext<CKTagViewRepresentation>) {
        uiView.backgroundColor = color.uiKit
        uiView.label.text = text
    }

    func makeUIView(context: UIViewRepresentableContext<CKTagViewRepresentation>) -> _CKTagView {
        let uiView = UIViewType()
        uiView.backgroundColor = color.uiKit
        uiView.label.text = text
        return uiView
    }
}
