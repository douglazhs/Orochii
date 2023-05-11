//
//  AniListLogin.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 05/04/23.
//

import Combine
import AuthenticationServices

class AnilistLogin: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    var subscriptions = Set<AnyCancellable>()
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    /// SignIn to AniList account
    func signIn() {
        let signInPromise = Future<URL, Error> { completion in
            let apiData = AnilistAPIConfigurations(
                id: 11988,
                secret: "hqZ1CwAKXMqLYXy2n0cvP1Why8X5jlAc0V56PhuJ",
                name: "Orochii",
                redirectURL: URL(string: "orochiapp")!
            )
            let authUrl = AnilistAuthenticationURLBuilder(clientID: apiData.id)()
            
            let authSession  = ASWebAuthenticationSession(
                url: authUrl,
                callbackURLScheme: apiData.redirectURL.absoluteString
            ) { (url, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                }
            }
            authSession.presentationContextProvider = self
            authSession.prefersEphemeralWebBrowserSession = true
            authSession.start()
        }
        signInPromise.sink { (completion) in
            switch completion {
            case .failure: break
            default: break
            }
        } receiveValue: { (url) in
            self.processResponseURL(url: url)
        }
        .store(in: &subscriptions)
    }
    
    /// Process URL after get the authorization response
    /// - Parameter url: Received URL wiht the access `token`
    func processResponseURL(url: URL) {
        let anilistComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        if  let anilistFragment = anilistComponents?.fragment,
            let dummyURL = URL(string: "http://dummyurl.com?\(anilistFragment)"),
            let components = URLComponents(url: dummyURL, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems,
            let token = queryItems.filter ({ $0.name == "access_token" }).first?.value,
            let expirationDate = queryItems.filter ({ $0.name == "expires_in" }).first?.value
            {
        }
    }
}
