import Foundation
import Medea



public protocol ExpressibleByJSON {
  init(json: JSONObject)
}
