import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation

// server 상수 선언 
let server = HTTPServer()

// server 속성 정의. serverPort : 포트 번호 , documentRoot : web 진입디렉토리
server.serverPort = 8080
server.documentRoot = "./src"

// 라우터 정의 및 페이징 핸들러 활용 예제
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


// server 시작
do {
    try server.start()
} catch PerfectError.networkError(let error, let message) {
    Log.error(message: "Error: \(error), \(message)")
}