import SwiftUI

struct ViewLifeCycle: ViewModifier {
    let mviInteraction: MVIInteractionable

    func body(content: Content) -> some View {
        content
            .onAppear { mviInteraction.performInstall() }
            .onDisappear { mviInteraction.performUninstall() }
    }
}

public extension View {
    func onLifecycle(mviInteraction: MVIInteractionable) -> some View {
        modifier(ViewLifeCycle(mviInteraction: mviInteraction))
    }
}
