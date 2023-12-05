import DagestanKit

protocol AuthInteractionable: MVIInteractionable {
    func onChangeName(_ newName: String)
    func onChangeEmail(_ newEmail: String)
    func onChangePassword(_ newPassword: String)
    func onChangeRepeatedPassword(_ newRepeatedPassword: String)
    func onSignUnTap()
    func onLoginTap()
    func onChangeAuthStateTap(_ newValue: Bool)
}
