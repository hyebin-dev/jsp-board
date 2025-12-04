<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 로그인</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Noto Sans KR", -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
            background: linear-gradient(180deg, #f3f7ff 0%, #f6f8ff 55%, #f1f5ff 100%);
            color: #1f2937;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* HEADER ------------------------------------------------------ */
        header {
            background: linear-gradient(90deg, #5b8def, #5fa4ff);
            color: #ffffff;
            padding: 14px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 8px 20px rgba(15, 23, 42, 0.28);
        }

        .title-wrap {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .title {
            font-size: 22px;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .subtitle {
            font-size: 12px;
            opacity: 0.9;
        }

        .nav {
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav span {
            font-weight: 500;
        }

        .nav-pill {
            padding: 7px 14px;
            border-radius: 999px;
            background: rgba(248, 250, 252, 0.12);
            border: 1px solid rgba(226, 232, 240, 0.7);
            color: #f9fafb;
            font-weight: 500;
            transition: all 0.16s ease-in-out;
        }

        .nav-pill:hover {
            background: rgba(248, 250, 252, 0.26);
            box-shadow: 0 6px 14px rgba(15, 23, 42, 0.22);
            transform: translateY(-1px);
        }

        /* MAIN -------------------------------------------------------- */
        .content {
            flex: 1;
            max-width: 1080px;
            margin: 34px auto 30px;
            padding: 0 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            background: #ffffff;
            border-radius: 20px;
            padding: 28px 30px 26px;
            box-shadow: 0 14px 34px rgba(148, 163, 184, 0.4);
            border: 1px solid rgba(148, 163, 184, 0.16);
        }

        /* LOGIN PAGE -------------------------------------------------- */
        .login-card {
            width: 100%;
            max-width: 480px;
        }

        .card-eyebrow {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.16em;
            /* text-transform 제거해서 'log in' 그대로 보이게 */
            color: #64748b;
            margin-bottom: 4px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .card-desc {
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 22px;
            line-height: 1.6;
        }

        .login-form {
            margin-top: 6px;
        }

        .form-row {
            display: flex;
            flex-direction: column;
            margin-bottom: 14px;
        }

        /* 비밀번호 필드는 살짝 더 아래에서 시작 */
        .form-row--password {
            margin-top: 4px;
        }

        .form-row label {
            font-size: 13px;
            color: #4b5563;
            margin-bottom: 4px;
        }

        .form-row input {
            padding: 11px 13px;
            border-radius: 12px;
            border: 1px solid #d1e3ff;
            font-size: 13px;
            background: #f8fbff;
        }

        .form-row input:focus {
            outline: none;
            border-color: #5fa4ff;
            box-shadow: 0 0 0 2px rgba(95, 164, 255, 0.25);
            background: #ffffff;
        }

        .login-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 8px;
        }

        .login-actions .link-small {
            font-size: 12px;
            color: #6b7280;
            text-align: right;
        }

        .login-actions .link-small a {
            color: #2563eb;
            font-weight: 500;
        }

        /* 비회원 안내 한 줄 ------------------------------------------- */
        .guest-area {
            margin-top: 18px;
            font-size: 13px;
            color: #6b7280;
            text-align: center;
        }

        .guest-line {
            display: inline-block;
            white-space: nowrap;
        }

        .guest-link {
            margin-left: 4px;
            color: #2563eb;
            font-weight: 600;
        }

        .guest-link:hover {
            text-decoration: underline;
        }

        /* BUTTONS ----------------------------------------------------- */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 11px 16px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 500;
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.16s ease-in-out;
        }

        .btn-primary {
            background: linear-gradient(135deg, #5fa4ff, #3b82f6);
            color: #ffffff;
            box-shadow: 0 10px 22px rgba(96, 165, 250, 0.55);
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 12px 26px rgba(59, 130, 246, 0.7);
        }

        /* FOOTER ------------------------------------------------------ */
        footer {
            border-top: 1px solid rgba(148, 163, 184, 0.25);
            padding: 10px 0 16px;
            font-size: 12px;
            color: #9ca3af;
            text-align: center;
        }

        /* 반응형 ------------------------------------------------------ */
        @media (max-width: 640px) {
            header {
                padding: 12px 18px;
            }

            .title {
                font-size: 18px;
            }

            .content {
                margin-top: 24px;
            }

            .card {
                padding: 24px 20px 20px;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">

    <!-- 이미 로그인 상태면 바로 메인으로 -->
    <c:if test="${ses.id ne null}">
        <c:redirect url="/brd/main"/>
    </c:if>

    <!-- HEADER -->
    <header>
        <div class="title-wrap">
            <div class="title">게시판</div>
            <div class="subtitle">파스텔 톤으로 정리된 작은 커뮤니티 공간</div>
        </div>

        <nav class="nav">
            <a href="/brd/main" class="nav-pill">게시판 홈</a>
            <c:if test="${ses.id ne null}">
                <span>${ses.id} 님</span>
                <a href="/user/logout" class="nav-pill">로그아웃</a>
                <a href="/user/modify" class="nav-pill">회원정보 수정</a>
            </c:if>
            <c:if test="${ses.id eq null}">
                <a href="/login.jsp" class="nav-pill">로그인</a>
                <a href="/user/register" class="nav-pill">회원가입</a>
            </c:if>
        </nav>
    </header>

    <!-- MAIN -->
    <main class="content">
        <section class="card login-card">
            <div class="card-eyebrow">log in</div>
            <div class="card-title">로그인</div>
            <div class="card-desc">
                아이디와 비밀번호를 입력하고, 나만의 게시판 공간을 이용해 보세요.
                작성한 글과 댓글을 한 곳에서 관리할 수 있습니다.
            </div>

            <form class="login-form" action="/user/login" method="post">
                <div class="form-row">
                    <label for="login-id">아이디</label>
                    <input id="login-id" type="text" name="id" placeholder="아이디를 입력하세요.">
                </div>
                <div class="form-row form-row--password">
                    <label for="login-pwd">비밀번호</label>
                    <input id="login-pwd" type="password" name="pwd" placeholder="비밀번호를 입력하세요.">
                </div>

                <div class="login-actions">
                    <button type="submit" class="btn btn-primary">로그인</button>
                    <div class="link-small">
                        아직 회원이 아니신가요?
                        <a href="/user/register">지금 회원가입하기</a>
                    </div>
                </div>
            </form>

            <!-- 비회원용 안내 (한 줄) -->
            <div class="guest-area">
                <span class="guest-line">
                    로그인 없이 둘러보고 싶다면
                    <a href="/brd/main" class="guest-link">비회원으로 게시판 보기</a>
                </span>
            </div>
        </section>
    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 게시판. All rights reserved.
    </footer>
</div>

<script type="text/javascript">
    const login_msg = `<c:out value="${param.login_msg}" />`;
    if (login_msg === 'notUser') {
        alert('로그인 정보가 일치하지 않습니다.');
        window.location.href = "/login.jsp";
    }

    const update_msg = `<c:out value="${param.update_msg}" />`;
    if (update_msg === 'OK') {
        alert('회원정보가 수정되었습니다. 다시 로그인해주세요.');
        window.location.href = "/login.jsp";
    }

    const delete_msg = `<c:out value="${param.delete_msg}" />`;
    if (delete_msg === 'OK') {
        alert('회원탈퇴되었습니다.');
        window.location.href = "/login.jsp";
    }
</script>
</body>
</html>
