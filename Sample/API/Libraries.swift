import Foundation
import SessionArtist



extension API {
  static let library = try! APISession<LibraryEndpoint>(host: "https://data.cityofchicago.org")
}



enum LibraryEndpoint: Endpoint {
  case index
  func makeRequest(host: Host) -> URLRequest {
    switch self {
    case .index:
      return host.get("/resource/x8fc-8rcq.json")
    }
  }
}

