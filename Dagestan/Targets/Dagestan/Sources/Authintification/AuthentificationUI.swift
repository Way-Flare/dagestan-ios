import SwiftUI
import DagestanKit
import DagestanUI

struct AuthenticationUI<ViewModel: StateHolderable & AuthInteractionable>: View
where ViewModel.StateType == AuthState {
    @ObservedObject var viewModel: ViewModel
    @State var isRegistering = false {
        didSet {
            viewModel.onChangeAuthStateTap(isRegistering)
        }
    }

    var body: some View {
        let name = Binding<String>(
            get: { viewModel.state?.name ?? stateError },
            set: { viewModel.onChangeName($0) }
        )

        let email = Binding<String>(
            get: { viewModel.state?.email ?? stateError },
            set: { viewModel.onChangeEmail($0) }
        )

        let password = Binding<String>(
            get: { viewModel.state?.password ?? stateError },
            set: { viewModel.onChangePassword($0) }
        )

        let repeatedPassword = Binding<String>(
            get: { viewModel.state?.repeatedPassword ?? stateError },
            set: { viewModel.onChangeRepeatedPassword($0) }
        )

        HStack(alignment: .center, spacing: 20) {
            VStack {
                if isRegistering {
                    DGAuthTextField(
                        text: name,
                        placeholder: "auth.name.title"
                    )
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .transition(.scale)
                }

                DGAuthTextField(
                    text: email,
                    placeholder: "auth.email.title"
                )
                .ignoresSafeArea(.keyboard, edges: .bottom)

                DGAuthTextField(
                    text: password,
                    placeholder: "auth.password.title",
                    isSecure: true
                )
                .ignoresSafeArea(.keyboard, edges: .bottom)

                if isRegistering {
                    DGAuthTextField(
                        text: repeatedPassword,
                        placeholder: "auth.repeatedPassword.title",
                        isSecure: true
                    )
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .transition(.scale)
                }
                signInButton
                changeAuthStateButton
            }
            .padding([.leading, .trailing, .bottom], 28)
        }
        .onLifecycle(mviInteraction: viewModel)
    }
}

// MARK: - TextFields
extension AuthenticationUI {

    var signInButton: some View {
        Button {
            // TODO: Реализовать вход в аккаунт
            print("SIGN")
            viewModel.onSignUnTap()
        } label: {
            HStack {
                Text(isRegistering ? "auth.signUp" : "auth.signIn")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.text))
                    .bold()
                    .background(.mint)
                    .cornerRadius(8)

            }
        }
    }

    var changeAuthStateButton: some View {
        Button {
            withAnimation {
                isRegistering.toggle()
            }
        } label: {
            HStack {
                Text(isRegistering ? "auth.logging" : "auth.registering")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(.text))
                    .bold()

            }
        }
    }

}

private let stateError: String = "State doesn't exist"
