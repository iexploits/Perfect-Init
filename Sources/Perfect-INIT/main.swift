import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation

let server = HTTPServer()

server.serverPort = 8080
server.documentRoot = "./src"

var routes = Routes()

routes.add(method: .get, uri: "/page", handler: { request, response in
    
    let pageToResponse: Int
    
    if let page = request.param(name: "page"), let pageNumber = Int(page) {
        pageToResponse = pageNumber
    } else {
        pageToResponse = 0
    }
    
    response.setBody(string: "페이지 핸들러 예제입니다 >> 현재 \(pageToResponse) 페이지")
    response.completed()
})

server.addRoutes(routes)

do {
    try server.start()
} catch PerfectError.networkError(let error, let message) {
    Log.error(message: "Error: \(error), \(message)")
}