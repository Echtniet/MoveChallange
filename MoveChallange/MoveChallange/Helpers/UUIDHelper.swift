//
//  UUIDHelper.swift
//  MoveChallange
//
//  Created by Clinton on 23/02/2025.
//

import Foundation
import CryptoKit

extension UUID {
    static func fromHash(_ input: String) -> UUID {
        let inputData = input.data(using: .utf8)!
        let hash = SHA256.hash(data: inputData)

        let uuidBytes = Array(hash.prefix(16))
        let uuid = uuidBytes.withUnsafeBytes { buffer in
            UUID(uuid: buffer.load(as: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8).self))
        }
        return uuid
    }
}
