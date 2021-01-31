import SwiftUI
import Combine

extension View {
    func addHideKeyboardButton() -> some View {
        self.modifier(HideKeyboardButtonOverlay())
    }
}

struct HideKeyboardButtonOverlay: ViewModifier {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if horizontalSizeClass == .compact {
            content
                .overlay(HideKeyboardButton(),alignment: .bottomTrailing)
        } else {
            content
        }
    }
}



struct HideKeyboardButton: View {

    var body: some View {
        Button(action: {
            hideKeyboard()
        }, label: {
            Image(systemName: "keyboard.chevron.compact.down")
                .font(Font.system(size: 25, weight: .regular))
                .padding(8)
                .background(Color("buttonBackground"))
                .cornerRadius(8)
                .padding()
        })
        .modifier(AdaptOpacityWithKeyboard(hideOnShow: false))
        .animation(.default)
    }
}


struct AdaptOpacityWithKeyboard: ViewModifier {
    
    let hideOnShow: Bool
    @State var opacity: Double = 0

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear(perform: subscribeToKeyboardChanges)
    }

    private let keyboardHeightOnOpening = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { _ in true }

    
    private let keyboardHeightOnHiding = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in false }
        
    private func subscribeToKeyboardChanges() {
        
        _ = Publishers.Merge(keyboardHeightOnOpening, keyboardHeightOnHiding)
            .subscribe(on: RunLoop.main)
            .sink { show in
                if show {
                    self.opacity = hideOnShow ? 0:1
                } else {
                    self.opacity = hideOnShow ? 1:0
                }
                
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
