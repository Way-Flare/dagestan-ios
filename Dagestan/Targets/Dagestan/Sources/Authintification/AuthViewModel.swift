import DagestanKit

final class AuthViewModel: BaseMVIViewModel<AuthState> {
    override func createInitialState() -> AuthState {
        return AuthState(
            name: "",
            email: "",
            password: "",
            repeatedPassword: "",
            isRegistering: false,
            isLoggedIn: false
        )
    }
}

// MARK: - AuthInteractionable
extension AuthViewModel: AuthInteractionable {
    func onChangeName(_ newName: String) {
        guard let isRegistering = state?.isRegistering, isRegistering
        else {
            print("Cannton change name if user isn't registering")
            return
        }

        reduce { currentState in
            var newState = currentState
            newState.name = newName
            return newState
        }
    }

    func onChangeEmail(_ newEmail: String) {
        reduce { currentState in
            var newState = currentState
            newState.email = newEmail
            return newState
        }
    }

    func onChangePassword(_ newPassword: String) {
        reduce { currentState in
            var newState = currentState
            newState.password = newPassword
            return newState
        }
    }

    func onChangeRepeatedPassword(_ newRepeatedPassword: String) {
        guard let isRegistering = state?.isRegistering, isRegistering
        else {
            print("Cannton change repeatedPassword if user isn't registering")
            return
        }

        reduce { currentState in
            var newState = currentState
            newState.repeatedPassword = newRepeatedPassword
            return newState
        }
    }

    func onSignUnTap() {
        reduce { currentState in
            var newState = currentState
            newState.isLoggedIn = true
            return newState
        }
    }

    func onLoginTap() {
        reduce { currentState in
            var newState = currentState
            newState.isLoggedIn = true
            return newState
        }

    }

    func onChangeAuthStateTap(_ newValue: Bool) {
        reduce { currentState in
            var newState = currentState
            newState.isRegistering = newValue
            newState.repeatedPassword = ""
            newState.name = ""
            return newState
        }
    }

}
