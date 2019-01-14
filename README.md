# Perfect-INIT		( ver  0.1 )

Perfect-Swift 프로젝트를 진행하기 위한 기본 스켈레톤 프로젝트 입니다. 해당 git 은 iExpl0its 가 진행하는 Swift-Guide-KOR 프로젝트에 귀속되어 있으며 초보자가 하기에 복잡한 Perfect 프로젝트 환경 설정을 clone 만으로 간편하게 진행할 수 있도록 업로드 하였습니다. 



------

#### Swift Package Manager 활용해 직접 설정하기 ( Swift 4.2 )

```
> mkdir [프로젝트 명]	
> cd [프로젝트 명]				// 원하는 프로젝트 폴더를 생성 후 이동
> swift package init		  // Swift package manager 실행
```

해당 명령어는 터미널 환경에서 작동합니다. 위 init 명령어를 통해 swift 기본 패키지를 설치하게 되면 다음과 같은 디렉토리 구조가 생성될 것입니다. 먼저 src 폴더와  index.html 파일을 만들어 둡니다.

```
[프로젝트]
 └ Sources
  └ [프로젝트 명]
   └ main.swift
 └ Tests		// 해당 디렉토리는 테스트 디렉토리
 └ src				// 생성할 웹루트 디렉토리
  └ index.html	// 생성할 기본 인덱스 페이지
 Package.swift
 README.md
```



여기에서 Package.swift 를 먼저 열어 Perfect 의 패키지를 입력하여 dependency 를 추가해줍니다 ( 2018. 1. 2 기준 Perfect 3.0.0 버전 호환 )

```swift
[Package.swift]

...

    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
	// 아래 Perfect 패키지코드를 추가합니다.
    .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0")
    ],
    
...
```



그 후 main.swift 를 열어 다음과 같이 입력해줍니다 ( 프로젝트 명과 동일한 .swift 파일이 존재할 수도 있습니다. 굳이 변경하지 않아도 되나, 저 같은 경우 보통 swift 컴파일러의 EntryPoint를  공통적으로 main.swift 로 명시하여 사용합니다 )

```swift
[./Sources/[프로젝트 명]/main.swift]

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Foundation

// server 상수 선언 
let server = HTTPServer()

// server 속성 정의. serverPort : 포트 번호 , documentRoot : web 진입디렉토리
server.serverPort = 8080
server.documentRoot = "./src"

// 해당 git 에는 라우팅과 핸들러 예제 또한 정의되어있습니다.

// server 시작
do {
    try server.start()
} catch PerfectError.networkError(let error, let message) {
    Log.error(message: "Error: \(error), \(message)")
}
```



위와 같이 main.swift 까지 정의하였다면 기본적인 Perfect 웹서버의 설정을 마치셨습니다. 웹서버의 실행은 다음과 같이 진행하실 수 있습니다.



------

#### Perfect 프로젝트 빌드 및 실행

```
> swift build
> ./.build/debug/[프로젝트 명]
[INFO] Starting HTTP server  on 0.0.0.0:8080
```

위와 같이 빌드 명령어 실행 후, 빌드된 파일을 실행하면 main.swift 에서 정의한 8080 포트로 웹서버가 실행되었다는 INFO msg 가 출력됩니다. 그 후에 브라우저에서 "0.0.0.0/8080" 를 실행해보시면 index.html 이 실행되는 것을 확인할 수 있습니다.



