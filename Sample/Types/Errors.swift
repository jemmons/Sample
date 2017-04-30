import Foundation


public enum NetworkSourceError: Error {
  case failureCode(Int)
  case unexpectedResponseFormat
}

