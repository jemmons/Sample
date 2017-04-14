import Foundation
import Medea



public final class Library: ExpressibleByJSON {
  let name: String?
  public init(json: JSONObject) {
    name = json["name_"] as? String
  }
}
