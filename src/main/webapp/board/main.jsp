<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 메인</title>

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

        /* 비회원 안내 바 */
        .notice-bar {
            font-size: 13px;
            background: #e4ebff;
            color: #1f2937;
            padding: 9px 16px;
            border-radius: 999px;
            border-left: 4px solid #5b8def;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 18px;
        }

        .notice-bar strong {
            font-weight: 600;
            color: #111827;
        }

        /* 레이아웃 */
        .main-layout {
            display: grid;
            grid-template-columns: 2.1fr 1.4fr;
            gap: 22px;
        }

        .card {
            background: #ffffff;
            border-radius: 20px;
            padding: 24px 26px 22px;
            box-shadow: 0 14px 34px rgba(148, 163, 184, 0.4);
            border: 1px solid rgba(148, 163, 184, 0.16);
        }

        /* 왼쪽 메인 카드 ---------------------------------------------- */
        .board-main-card .label {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            color: #60a5fa;
            margin-bottom: 6px;
        }

        .board-main-card .headline {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 6px;
            line-height: 1.4;
        }

        .board-main-card .subtext {
            font-size: 13px;
            color: #6b7280;
            margin-bottom: 18px;
            line-height: 1.7;
        }

        .btn-row {
            display: flex;
            gap: 10px;
            margin-bottom: 14px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
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

        .btn-outline {
            background: #ffffff;
            color: #2563eb;
            border-color: #c5d3ff;
        }

        .btn-outline:hover {
            background: #edf2ff;
        }

        .category-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            font-size: 11px;
            margin-bottom: 6px;
        }

        .tag {
            padding: 4px 10px;
            border-radius: 999px;
            background: #eff4ff;
            color: #4b5563;
        }

        .board-main-card .hint {
            font-size: 11px;
            color: #9ca3af;
        }

        /* 오른쪽 보조 카드 -------------------------------------------- */
        .side-card + .side-card {
            margin-top: 14px;
        }

        .side-title {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .side-body {
            font-size: 12px;
            color: #6b7280;
        }

        .side-body li + li {
            margin-top: 4px;
        }

        .side-dot::before {
            content: "•";
            color: #60a5fa;
            display: inline-block;
            width: 1em;
            margin-left: -0.8em;
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
        @media (max-width: 900px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
        }

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
        }
    </style>
</head>
<body>
<div class="page-wrapper">

    <!-- HEADER -->
    <header>
        <div class="title-wrap">
            <div class="title">Simple Board</div>
            <div class="subtitle">파스텔 톤 JSP 게시판 메인</div>
        </div>

        <nav class="nav">
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

        <!-- 비회원 안내 -->
        <c:if test="${ses.id eq null}">
            <div class="notice-bar">
                <strong>현재 비회원으로 이용 중입니다.</strong>
                작성한 글은 <strong>‘익명’</strong>으로 등록됩니다.
            </div>
        </c:if>

        <section class="main-layout">
            <!-- 왼쪽 메인 카드 -->
            <article class="card board-main-card">
                <div class="label">BOARD</div>
                <div class="headline">
                    오늘의 기록을 가볍게 남겨 보세요.
                </div>
                <p class="subtext">
                    공부 기록부터 일상, 개발 고민까지 편하게 남길 수 있는 공간입니다.
                    파스텔 톤의 게시판에서 내 글과 다른 사람들의 글을 차분히 읽어 보세요.
                </p>

                <div class="btn-row">
                    <a href="/brd/register" class="btn btn-primary">✏️ 새 글 작성하기</a>
                    <a href="/brd/list" class="btn btn-outline">📄 게시글 목록 보기</a>
                </div>

                <div class="category-tags">
                    <span class="tag">자유게시판</span>
                    <span class="tag">공부 · 개발 · 일상</span>
                    <span class="tag">소소한 잡담</span>
                </div>
                <p class="hint">
                    마이페이지 없이도, 로그인 상태에 따라 자동으로 작성자 정보가 채워집니다.
                </p>
            </article>

            <!-- 오른쪽 안내 / 활용 카드 -->
            <div>
                <article class="card side-card">
                    <div class="side-title">게시판 이용 안내</div>
                    <ul class="side-body">
                        <li class="side-dot">로그인 후에는 닉네임과 함께 글 · 댓글을 남길 수 있어요.</li>
                        <li class="side-dot">비회원으로는 간단히 글을 남길 수 있지만 작성자는 ‘익명’으로 표시됩니다.</li>
                        <li class="side-dot">중요 공지나 모임 안내는 제목에 [공지]를 붙여 주세요.</li>
                    </ul>
                </article>

                <article class="card side-card">
                    <div class="side-title">이렇게 활용해 보세요</div>
                    <ul class="side-body">
                        <li class="side-dot">하루 공부/개발 회고를 짧게 남기고, 나중에 목록에서 한 번에 확인하기.</li>
                        <li class="side-dot">프로젝트 진행 상황이나 이슈를 정리해서 팀원들과 공유하기.</li>
                        <li class="side-dot">일상 기록, 잡담, 추천 링크 등을 자유롭게 적어 두는 메모용 공간으로 활용하기.</li>
                    </ul>
                </article>
            </div>
        </section>
    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 Simple Board. All rights reserved.
    </footer>
</div>
</body>
</html>


