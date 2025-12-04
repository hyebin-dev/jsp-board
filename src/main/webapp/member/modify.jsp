<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정 - 게시판</title>

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
        }

        /* 가운데 한 카드만 보이게 */
        .content-single {
            display: flex;
            justify-content: center;
        }

        .card {
            background: #ffffff;
            border-radius: 20px;
            padding: 24px 26px 22px;
            box-shadow: 0 14px 34px rgba(148, 163, 184, 0.4);
            border: 1px solid rgba(148, 163, 184, 0.16);
        }

        .profile-card {
            width: 100%;
            max-width: 520px;   /* 세로로 길게 보이도록 폭을 줄임 */
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
            gap: 14px;   /* 한 줄에 하나씩, 항목 간 간격 */
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

        .form-row input[readonly] {
            background: #f9fafb;
            color: #9ca3af;
        }

        .hint {
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

        .danger-text {
            font-size: 12px;
            color: #ef4444;
            line-height: 1.4;
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
            transition: all 0.16s ease-in-out;
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

        .btn-danger {
            background: #f97373;
            color: #ffffff;
            border-color: #ef4444;
        }

        .btn-danger:hover {
            background: #ef4444;
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
                padding: 20px 18px 18px;
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

    <!-- HEADER -->
    <header>
        <div class="title-wrap">
            <div class="title">게시판</div>
            <div class="subtitle">회원 정보 수정</div>
        </div>

        <nav class="nav">
            <a href="/brd/main" class="nav-pill">게시판 홈</a>
            <c:if test="${ses.id ne null}">
                <span>${ses.id} 님</span>
                <a href="/user/logout" class="nav-pill">로그아웃</a>
            </c:if>
            <c:if test="${ses.id eq null}">
                <a href="/login.jsp" class="nav-pill">로그인</a>
                <a href="/user/register" class="nav-pill">회원가입</a>
            </c:if>
        </nav>
    </header>

    <!-- MAIN -->
    <main class="content content-single">
        <section class="card profile-card">
            <div class="card-title">회원 정보 수정</div>
            <div class="card-desc">
                가입하신 정보를 확인하고, 수정이 필요한 항목만 변경해 주세요.
                아이디와 가입일, 마지막 로그인 시간은 읽기 전용으로 표시됩니다.
            </div>

            <form class="form" action="/user/update" method="post">
                <div class="form-row">
                    <label for="mod-id">아이디</label>
                    <input id="mod-id" type="text" name="id"
                           value="${ses.id}" readonly="readonly">
                </div>

                <div class="form-row">
                    <label for="mod-pwd">비밀번호</label>
                    <input id="mod-pwd" type="password" name="pwd"
                           value="${ses.pwd}" placeholder="새 비밀번호를 입력하세요.">
                    <p class="hint">비밀번호를 바꾸지 않으려면 그대로 두셔도 됩니다.</p>
                </div>

                <div class="form-row">
                    <label for="mod-email">이메일</label>
                    <input id="mod-email" type="email" name="email"
                           value="${ses.email}" placeholder="example@domain.com">
                </div>

                <div class="form-row">
                    <label for="mod-phone">연락처</label>
                    <input id="mod-phone" type="tel" name="phone"
                           value="${ses.phone}" placeholder="010-0000-0000">
                </div>

                <div class="form-row">
                    <label for="mod-regdate">가입일</label>
                    <input id="mod-regdate" type="text" name="regdate"
                           value="${ses.regdate}" readonly="readonly">
                </div>

                <div class="form-row">
                    <label for="mod-lastlogin">마지막 로그인</label>
                    <input id="mod-lastlogin" type="text" name="lastlogin"
                           value="${ses.lastlogin}" readonly="readonly">
                </div>

                <div class="actions">
                    <div class="danger-text">
                        계정을 더 이상 사용하지 않으신다면<br>
                        회원탈퇴 버튼을 통해 탈퇴를 진행할 수 있습니다.
                    </div>
                    <div class="btn-area">
                        <button type="submit" class="btn btn-primary">정보 수정하기</button>
                        <button type="button" class="btn btn-ghost"
                                onclick="location.href='/brd/main'">취소</button>
                        <button type="button" class="btn btn-danger"
                                onclick="if (confirm('정말 탈퇴하시겠습니까?')) location.href='/user/remove';">
                            회원탈퇴
                        </button>
                    </div>
                </div>
            </form>
        </section>
    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 게시판. All rights reserved.
    </footer>
</div>

<script type="text/javascript">
    const update_msg = `<c:out value="${param.update_msg}" />`;
    if (update_msg === 'Fail') {
        alert('회원정보 수정 실패 > 다시 시도해 주세요.');
    }

    const delete_msg = `<c:out value="${param.delete_msg}" />`;
    if (delete_msg === 'Fail') {
        alert('회원탈퇴 실패 > 다시 시도해 주세요.');
    }
</script>
</body>
</html>


