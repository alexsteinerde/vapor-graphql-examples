import Vapor
import GraphQLKit

struct AuthSession: SessionAuthenticatable {
    var sessionID: String
}

struct UserSessionAuthenticator: SessionAuthenticator {
    
    typealias User = App.AuthSession
    func authenticate(sessionID: String, for request: Request) -> EventLoopFuture<Void> {
        let user = AuthSession(sessionID: sessionID)
        request.auth.login(user)
        return request.eventLoop.makeSucceededFuture(())
    }
}

extension TodoResolver {
    func currentAuthSession(request: Request, _: NoArguments) throws -> String {
        try request.auth.require(AuthSession.self).sessionID
    }
    
    struct LoginArguments: Codable {
        let username: String
    }
    
    func login(request: Request, arguments: LoginArguments) throws -> Bool {
        request.auth.login(AuthSession(sessionID: arguments.username))
        return request.auth.has(AuthSession.self)
    }
    
    func logout(request: Request, _: NoArguments) throws -> Bool {
        request.auth.logout(AuthSession.self)
        return !request.auth.has(AuthSession.self)
    }
}
