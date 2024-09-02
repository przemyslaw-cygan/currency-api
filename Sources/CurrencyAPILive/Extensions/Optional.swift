import Foundation

extension Optional {
    @inlinable func ifSome(_ closure: (Wrapped) throws -> Void) rethrows {
        switch self {
        case .some(let wrapped):
            try closure(wrapped)
        case .none:
            break
        }
    }
}
