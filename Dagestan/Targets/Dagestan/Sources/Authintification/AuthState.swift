import SwiftUI
import DagestanKit

struct AuthState: MVIStatable {
    var name: String
    var email: String
    var password: String
    var repeatedPassword: String
    var isRegistering: Bool
    var isLoggedIn: Bool
}
