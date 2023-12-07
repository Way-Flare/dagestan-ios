import Foundation

public protocol StateHolderable: ObservableObject {

    associatedtype StateType

    var state: StateType? { get }
}
