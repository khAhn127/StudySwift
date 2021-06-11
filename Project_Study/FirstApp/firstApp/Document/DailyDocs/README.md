# Study
>20210602
## static 리마인더
- 단일 책임 원칙 : 클래스 내에 정적 메소드는 일반적으로이 특정 클래스에 속하지 않는 방법으로 사용 되기 때문에 위배 된다.
- 다형성 : 정적 메소드 재정의 하여 사용안되기 때문에 추상화 클래스에서 정적 메소드 사용이 불가하다. 정적클래스로 선언된 객체는 상속이 불가하다.
- 테스트 가능성 : 인스턴스화 하지 않고 사용하지 않고 무분별하게 사용이 되므로 추적이 불가하며 테스트가 어렵다.
- 글로벌 상태 : 정적 변수가 전역 상태를 나타내며 상태의 수정은 모든 곳에서 발생되며 예기치 않은 변형이 발생 된다.
- 메모리 누수 : Static 선언된 객체에 대한 메모리에 남아있으므로 메모리 leak 발생

> 20210603 
## CI/CD
### CI/CD란 무엇일까?
- 애플리케이션 개발 단계를 자동화하여 애플리케이션을 보다 짧은 주기로 고객에게 제공하는 방법
- 애플리케이션의 통합 및 테스트 단계에서부터 제공 및 배포에 이르는 애플리케이션의 라이프사이클 전체에 걸쳐 지속적인 자동화와 지속적인 모니터링을 제공
- 이러한 구축 사례를 일반적으로 "CI/CD 파이프라인"이라 부르며 개발 및 운영의 애자일 방식 협력을 통해 지원
- 지속적인 통합(Continuous Integration), 지속적인 서비스 제공(Continuous Delivery), 지속적인 배포(Continuous Deployment)으로 구성

1.  CI : 지속적 통합(Continuous Integration)
- 개발을 하면서 지속적으로 코드에 대한 통합을 진행함으로써 품질을 유지하자는 것
- 개발자를 위한 자동화 프로세스(개발자간의 코드 충돌을 방지하기 위한 목적)
- 정기적인 빌드 및 테스트(유닛테스트 및 통합테스트)를 거쳐 공유 레포지터리에 병합되는 과정
- 클래스와 기능에서부터 전체 애플리케이션을 구성하는 서로 다른 모듈에 이르기까지 모든 것에 대한 테스트를 수행
- 자동화된 테스트에서 기존 코드와 신규 코드 간의 충돌이 발견되면 CI를 통해 이러한 버그를 빠르게 수정 가능
 
2. CD: 지속적인 서비스제공( Continuous Delivery)
- CI 프로세스를 통해 개발중에 지속적으로 빌드와 유닛 및 통합 테스트를 진행하고, 이를 통과한 코드에 대하여 테스트서버와 운영서버에 자동으로 릴리즈
- 운영팀이 보다 빠르고 손쉽게 애플리케이션을 프로덕션으로 배포 가능
- 프로덕션 환경으로 배포할 준비가 되어 있는 코드베이스를 확보하는 것이 목표
 
3. CD : 지속적인 배포( Continuous Deployment)
- CI/CD 파이프라인의 마지막 단계
- 프로덕션 준비가 완료된 빌드를 코드 리포지토리에 자동으로 릴리스하는 지속적 제공의 확장된 형태
- 애플리케이션을 프로덕션으로 릴리스하는 작업을 자동화
- Continuous Delivery로 통칭하여 언급하기도 함
- 개발자가 애플리케이션에 변경 사항을 작성한 후 몇 분 이내에 애플리케이션을 자동으로 실행할 수 있는 것을 의미
- 테스트와 빌드가 ‘지속적’으로 이루어지기 때문에, 배포 또한 자연스럽게 ‘지속적’으로 이루어지게 됨
 

출처: https://devuna.tistory.com/56 [튜나 개발일기]

## 애자일
1. 애자일(agile) 이란?  agile : 1. 날렵한, 민첩한 2. (생각이) 재빠른, 기민한
- 날렵하고 민첩한이라는 의미는 알겠는데 그래서 정확히 의미하고자하는게 뭘까?
    -  짧은주기의 개발단위를 반복하여 하나의 큰 프로젝트를 완성해 나가는 방식이다.
    - 애자일의 핵심은 협력과 피드백이다.(협력과 피드백을 자주! 빨리!)
    - 애자일은 방법론은 아니다.
    => (검색을 해보면 방법론이라고 소개한곳도 있으나, 애자일은 사상 또는 철학일뿐이고 이러한 사상을 계승하여 나온 칸반, 스크럼 등이 방법론에 속한다고 생각하면 된다)
> 애자일의 핵심은 유연하게 일을 진행하자 + 변화에 잘 대응하자가 핵심
> 애자일은 정확히 말하자면 소프트웨어 개발에 필요한 작업을 알려주는 일련의 규정이 아니다.

2. 애자일을 계승한 방법론 또는 애자일 프레임워크
    - 애자일 프레임워크는 애자일 사상 또는 철학에 기반한 개발 접근방식으로 정의가 가능합니다.
    - 애자일 프레임워크를 방법론, proecess 로 규정하기도 한다.
    - 스크럼(scrum), 칸반(kanban), XP(eXtream Progrmming), LSD(Lean SW Development) 등이 있다.

출처 : https://velog.io/@katanazero86/%EC%95%A0%EC%9E%90%EC%9D%BCagile%EC%9D%B4%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80

## TDD
테스트로 개발을 시작(Test First Development) / 
- TO DO 정리 필요
https://medium.com/@jang.wangsu/tdd-tdd%EC%9D%98-%EC%9E%A5%EB%8B%A8%EC%A0%90%EC%97%90-%EB%8C%80%ED%95%B4-%EC%83%9D%EA%B0%81%ED%95%B4%EB%B3%B4%EA%B8%B0-dcf32a72b098



>20210604
개발 scope : 범위를 나타나며 scope 안에 선언된 변수는 scope가 끝날때 메모리 해제가 된다.  해당 scope 선언된 객체가 stack 영역에 쌓이고 scope 종료시 stack 영역에서 해제 된다. 하지만 scope 영역에 선언된 static 객체는 stack영역이 아닌 Heap 영역으로 들어가기 때문에 메모리 해제가 안된다.
디자인 패턴 : gof 23 가지 패턴 , 아키텍처 패턴 : mvc, mvp , mvvm 등의 설계 패턴
Higher Order Function 고차함수 : 함수안에 함수를 객체 처럼 사용하고 함수를 결과 값으로 받는다. 
swift의 map,filter, reduce
데이터흐름 방식 = 데이터 전달 방식
Broadcast = Notification = (observer)? : n개의 객체를 Broadcast 등록했을 때 일괄적으로 전달하여 변경처리 하는 방식
화면 간의 데이터전달 : intent = seque? 화면 전환 될때 객체를 통하여 데이터 전달 하는 방식
delegate : 프로토콜이란 인터페이스를 통하여 데이터를 위임하여 데이터 전달하는 방식

>20210607
## IOS 아키텍처
1.  IOS 아키텍처
- MVC, MVP, MVVM, VIPER, RIB’s, MVVM-C, ReatorKit, Flux, VIP 
- RIB’s , VIPER, MVVM , VIP : 여러 작업할때 효율
- MVC,MVP MVVM : 현재 많이 사용
- 보일러 플레이트에 대한 것을 생각
- 협업 프로젝트의 구성원에 따른 아키텍처 결정
- 아키텍처 쓰는 이유 : 생산성 높이고 효율적인 코드 작성
    - 각 객체들이 구체적이고 명확한 역할을 가지며, 그 역할이 적절하게 분배되어 있다.
    - 데이터의 흐름이 단순하다.
    - Testability 하다.
    - 코드의 위치가 명확하다.
2.  코드 커버리지 : 소프트웨어의 테스트 케이스가 얼마나 충족되었는지를 나타내는 지표 중 하나이다
3. 보일러 플레이트 : 컴퓨터 프로그래밍에서 보일러플레이트 또는 보일러플레이트 코드라고 부르는 것은 최소한의 변경으로 여러곳에서 재사용되며, 반복적으로 비슷한 형태를 띄는 코드를 말한다.

> 20210609
## 오류 처리 
1. 오류 처리 정리
    - 오류 표현 및 던지기
        > 오류 표현 : Error 프로토콜 과 열거형을 통해서 오류를 표현
    - 오류 던지기
        - Throw 던지기 처리
        - Init Throws 처리
        - Func Throws 처리
        - closure Throw 처리
            > Rethrow 형태 처리 : throws keyword 와 같은 의미이며 func a ( () -> throws void ) throws or rethrow => () or 매개 변수 있는 클로저의 throw 발생 처리
            > closure 내 throw 처리 : 클로저 scope 내에서 에러가 발생되는 부분을 throw 발생 처리
2. 오류 처리
    - do try catch 문 처리 : do scope 내에서 발생되는 try 부분을 catch 하여 오류 처리
    - Try ?  처리  : 해당 라인으로 선언된 에러가 발생 될때  옵셔널로 오류 처리
    - try  !  처리  : 오류가 없다고 판단 되어질때 강제 처리
3. 오류 정리
    - Defer 처리 : throws 처리 전에 메모리에 로드된 것을 defer문으로 안전하게 close 처리가 필요 발생

>20210611
## UIViewController 
1. 컨테이너 뷰 컨트롤러 : 컨텐츠 뷰들을 관리 해주는 
2. 컨텐츠 뷰 컨트롤러