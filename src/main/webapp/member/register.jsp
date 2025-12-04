<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 게시판</title>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: "Noto Sans KR", -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
        background: linear-gradient(180deg, #f3f7ff 0%, #f6f8ff 55%, #f1f5ff 100%);
        color: #334155;
    }

    a {
        text-decoration: none;
        color: inherit;
    }

    .page-wrapper {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    header {
        padding: 14px 32px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(90deg, #90c5ff, #6aa9ff); /* 로그인과 동일 */
        color: #ffffff;
        box-shadow: 0 8px 20px rgba(148, 163, 184, 0.35);
    }

    .title-wrap {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .title {
        font-size: 22px;
        font-weight: 700;
        letter-spacing: 0.03em;
    }

    .subtitle {
        font-size: 12px;
        opacity: 0.9;
    }

    .nav {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 13px;
    }

    .nav span {
        font-weight: 500;
    }

    .nav-pill {
        padding: 7px 14px;
        border-radius: 999px;
        border: 1px solid rgba(248, 250, 252, 0.7);
        background: rgba(248, 250, 252, 0.18);
        color: #ffffff;
        font-size: 13px;
        font-weight: 500;
        transition: all 0.18s ease-in-out;
    }

    .nav-pill:hover {
        background: rgba(248, 250, 252, 0.28);
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(15, 23, 42, 0.22);
    }

    .content {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 20px 48px;
    }

    .card {
        width: 100%;
        max-width: 640px;
        background: #ffffff;
        border-radius: 26px;
        padding: 32px 40px 30px;
        box-shadow: 0 18px 40px rgba(148, 163, 184, 0.4);
        border: 1px solid rgba(148, 163, 184, 0.2);
    }

    .card-title {
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 8px;
    }

    .card-desc {
        font-size: 13px;
        color: #6b7280;
        margin-bottom: 22px;
        line-height: 1.6;
    }

    .form {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .form-row {
        display: flex;
        flex-direction: column;
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

    .helper {
        font-size: 11px;
        color: #9ca3af;
        margin-top: 3px;
    }

    .actions {
        margin-top: 18px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
    }

    .left-links {
        font-size: 12px;
        color: #6b7280;
    }

    .left-links a {
        color: #2563eb;
        font-weight: 500;
    }

    .btn-area {
        display: flex;
        gap: 8px;
    }

    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px 16px;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 500;
        border: 1px solid transparent;
        cursor: pointer;
        transition: all 0.18s ease-in-out;
        white-space: nowrap;
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

    .btn-ghost {
        background: #ffffff;
        color: #4b5563;
        border-color: #cbd5e1;
    }

    .btn-ghost:hover {
        background: #f1f5f9;
    }

    footer {
        border-top: 1px solid rgba(148, 163, 184, 0.25);
        padding: 12px 0 18px;
        font-size: 12px;
        color: #9ca3af;
        text-align: center;
    }

    @media (max-width: 640px) {
        header {
            padding: 12px 18px;
        }

        .card {
            padding: 26px 20px 24px;
            max-width: 100%;
        }

        .actions {
            flex-direction: column-reverse;
            align-items: stretch;
        }

        .btn-area {
            justify-content: flex-end;
        }
    }
</style>
</head>
<body>
<div class="page-wrapper">

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

    <main class="content">
        <section class="card">
            <div class="card-title">회원가입</div>
            <div class="card-desc">
                간단한 정보만 입력하면 게시판에서 글을 쓰고 댓글을 남길 수 있습니다.
            </div>

            <form class="form" action="/user/insert" method="post">
                <div class="form-row">
                    <label for="reg-id">아이디</label>
                    <input id="reg-id" type="text" name="id"
                           placeholder="아이디를 입력하세요."
                           minlength="4" maxlength="12" required>
                    <p class="helper">영문/숫자 조합 4~12자를 권장합니다.</p>
                </div>

                <div class="form-row">
                    <label for="reg-pwd">비밀번호</label>
                    <input id="reg-pwd" type="password" name="pwd"
                           placeholder="비밀번호를 입력하세요."
                           minlength="8" required>
                    <p class="helper">안전한 사용을 위해 8자 이상으로 설정해 주세요.</p>
                </div>

                <div class="form-row">
                    <label for="reg-email">이메일</label>
                    <input id="reg-email" type="email" name="email"
                           placeholder="example@domain.com" required>
                </div>

                <div class="form-row">
                    <label for="reg-phone">연락처</label>
                    <input id="reg-phone" type="tel" name="phone"
                           placeholder="010-0000-0000"
                           pattern="010-[0-9]{4}-[0-9]{4}" required>
                    <p class="helper">예: 010-1234-5678 형식으로 입력해 주세요.</p>
                </div>

                <div class="actions">
                    <div class="left-links">
                        이미 계정이 있으신가요?
                        <a href="/login.jsp">로그인하기</a>
                    </div>
                    <div class="btn-area">
                        <button type="button" class="btn btn-ghost"
                                onclick="location.href='/login.jsp'">취소</button>
                        <button type="submit" class="btn btn-primary">회원가입 완료</button>
                    </div>
                </div>
            </form>
        </section>
    </main>

    <footer>
        © 2025 게시판. All rights reserved.
    </footer>
</div>
</body>
</html>


