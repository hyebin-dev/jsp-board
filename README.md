# jsp-board

본 프로젝트는  
**코리아IT아카데미 (디지털컨버전스) 「공공데이터 융합 풀스택 개발자 양성과정Ⅰ」 수업 진행 중**  
강사님과 함께 실습 형태로 진행하며, **JSP/Servlet 기반 전통적인 Java Web 구조**를 학습하기 위해 구현한 게시판 웹 애플리케이션입니다.

Servlet + JSP 구조에서 MVC 흐름, MyBatis(XML Mapper) 기반 데이터 접근, 파일 업로드(썸네일 생성), 댓글 AJAX(fetch) 통신을 경험하는 것을 목표로 제작되었습니다.

---

## Features

- 회원 기능
  - 회원가입 / 로그인 / 로그아웃
  - 회원정보 수정 / 탈퇴
  - 로그아웃 시 마지막 접속 시간(`lastlogin`) 갱신 로직 포함
- 게시판 기능
  - 게시글 CRUD
  - 페이징 처리
  - 이미지 업로드 및 썸네일 자동 생성(`th_` 접두어)
- 댓글 기능
  - 댓글 CRUD
  - fetch 기반 AJAX 통신

---

## Tech Stack

- Java 11
- JSP / Servlet
- Apache Tomcat 9
- MyBatis 3.5.10 (XML Mapper)
- MySQL 8.x (Connector/J 8.0.33)
- JavaScript (Fetch API)
- Log4j2 2.18.0
- File Upload & Thumbnail
  - commons-fileupload 1.4
  - commons-io 2.11.0
  - thumbnailator 0.4.17
- 기타
  - json-simple 1.1.1
  - JSTL 1.2

※ 라이브러리 관리는 Maven/Gradle이 아닌  
`WEB-INF/lib`에 JAR를 직접 포함하는 방식입니다.

---

## Project Structure

```text
jsp-board
├─ docs
│  └─ schema.sql
│
├─ src
│  └─ main
│     ├─ java
│     │  ├─ controller
│     │  │  ├─ BoardController.java      # @WebServlet("/brd/*")
│     │  │  ├─ CommentController.java    # @WebServlet("/cmt/*")
│     │  │  └─ UserController.java       # @WebServlet("/user/*")
│     │  ├─ service
│     │  │  ├─ BoardService.java / Impl
│     │  │  ├─ CommentService.java / Impl
│     │  │  └─ UserService.java / Impl
│     │  ├─ repository
│     │  │  ├─ BoardDAO.java / Impl
│     │  │  ├─ CommentDAO.java / Impl
│     │  │  └─ UserDAO.java / Impl
│     │  ├─ mapper
│     │  │  ├─ boardMapper.xml
│     │  │  ├─ commentMapper.xml
│     │  │  └─ userMapper.xml
│     │  ├─ domain
│     │  │  ├─ Board.java
│     │  │  ├─ Comment.java
│     │  │  ├─ User.java
│     │  │  └─ PagingVO.java
│     │  ├─ handler
│     │  │  ├─ FileRemoveHandler.java
│     │  │  └─ PagingHandler.java
│     │  └─ orm
│     │     ├─ DatabasesBuilder.java
│     │     └─ mybatisConfig.xml
│     │
│     └─ webapp
│        ├─ board
│        │  ├─ main.jsp
│        │  ├─ list.jsp
│        │  ├─ detail.jsp
│        │  ├─ register.jsp
│        │  └─ modify.jsp
│        ├─ member
│        │  ├─ register.jsp
│        │  └─ modify.jsp
│        ├─ resources
│        │  ├─ boardDetail.js            # 댓글 AJAX(fetch)
│        │  └─ sql.txt
│        ├─ _fileUpload                  # 업로드 파일 저장 폴더(썸네일 th_*)
│        ├─ login.jsp
│        ├─ META-INF
│        └─ WEB-INF
│           ├─ web.xml                   # welcome-file-list 설정
│           ├─ log4j2.xml
│           └─ lib                       # JAR 직접 포함 방식
````

---

## Database

### Tables

* `board`   : 게시글
* `comment` : 댓글 (게시글 삭제 시 댓글 자동 삭제: `ON DELETE CASCADE`)
* `user`    : 회원

스키마는 `docs/schema.sql`로 관리합니다.

> 참고: user 는 DB 예약어로 사용될 수 있어, 스키마에서는 아래와 같이 백틱으로 감싸서 생성합니다.
>
> ```sql
> CREATE TABLE `user`
> ```

---

## Database Setup (MySQL 8.x)

### 1) DB / 계정 생성 (root)

```sql
CREATE DATABASE IF NOT EXISTS jspdb
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE mysql;

CREATE USER IF NOT EXISTS 'jspuser'@'localhost' IDENTIFIED BY 'mysql';
GRANT ALL PRIVILEGES ON jspdb.* TO 'jspuser'@'localhost';
FLUSH PRIVILEGES;
```

### 2) 테이블 생성 (jspuser로 접속 후 실행)

```sql
USE jspdb;
-- docs/schema.sql 실행
```

### 3) 연결 정보 (코드 기준)

`mybatisConfig.xml`에 아래 값이 설정되어 있습니다.

* url: `jdbc:mysql://localhost:3306/jspdb`
* username: `jspuser`
* password: `mysql`

---

## How to Run (Tomcat 9)

1. MySQL 실행 및 DB 세팅 (`docs/schema.sql`)
2. Eclipse에서 프로젝트 Import
3. Tomcat 9 서버에 프로젝트 등록
4. 실행 후 접속

```text
http://localhost:8080/jsp-board
```

---

## URL Routing (@WebServlet Mapping)

### User (회원) — `/user/*`

* 회원가입 페이지: `/user/register` → `/member/register.jsp`
* 회원가입 처리: `/user/insert`
* 로그인 처리: `/user/login`
* 로그아웃 처리: `/user/logout` → `/login.jsp`로 이동
* 회원정보 수정 페이지: `/user/modify` → `/member/modify.jsp`
* 회원정보 수정 처리: `/user/update`
* 회원 탈퇴 처리: `/user/remove`

### Board (게시판) — `/brd/*`

* 메인: `/brd/main` → `/board/main.jsp`
* 글쓰기 페이지: `/brd/register` → `/board/register.jsp`
* 글 등록 처리(파일 업로드 포함): `/brd/insert`
* 목록: `/brd/list` → `/board/list.jsp`
* 상세: `/brd/detail?bno={bno}` → `/board/detail.jsp`
* 수정 페이지: `/brd/modify?bno={bno}` → `/board/modify.jsp`
* 수정 처리(파일 변경 포함): `/brd/update`
* 삭제 처리: `/brd/remove?bno={bno}`

### Comment (댓글) — `/cmt/*`

`/resources/boardDetail.js`에서 fetch(AJAX)로 호출합니다.

* 댓글 등록: `/cmt/post` (POST, JSON)
* 댓글 목록: `/cmt/list?bno={bno}`
* 댓글 수정: `/cmt/modify` (POST, JSON)
* 댓글 삭제: `/cmt/remove?cno={cno}`

---

## File Upload (게시글 이미지)

* 업로드 저장 위치: `src/main/webapp/_fileUpload`
* 업로드된 파일명 기반으로 썸네일이 생성되며, 접두어 `th_`가 붙습니다.

  * 예: `파일명.jpg` → `th_파일명.jpg`

---

## Notes

* 본 프로젝트는 **교육 과정 중 강사님과 함께 진행한 실습 기반 프로젝트**입니다.
* 전통적인 JSP/Servlet 구조에서 MVC 흐름 및 MyBatis(XML Mapper) 사용법을 학습하는 데 중점을 두었습니다.
* 라이브러리 관리가 `WEB-INF/lib` 방식이므로, 실행 시 Tomcat 프로젝트 설정/라이브러리 포함 상태를 확인해야 합니다.

