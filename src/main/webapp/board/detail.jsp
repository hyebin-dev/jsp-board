<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 - 게시판</title>

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

        .breadcrumb {
            font-size: 13px;
            color: #9ca3af;
            margin-bottom: 14px;
        }

        .breadcrumb span {
            color: #6b7280;
        }

        .card {
            background: #ffffff;
            border-radius: 20px;
            padding: 24px 26px 22px;
            box-shadow: 0 14px 34px rgba(148, 163, 184, 0.4);
            border: 1px solid rgba(148, 163, 184, 0.16);
        }

        /* POST CARD --------------------------------------------------- */
        .post-card {
            margin-bottom: 18px;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 14px;
        }

        .post-meta-wrap {
            flex: 3;
        }

        .post-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 4px 10px;
            border-radius: 999px;
            background: #e0f2ff;
            color: #1d4ed8;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .post-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .post-meta {
            font-size: 12px;
            color: #9ca3af;
        }

        .post-meta span + span::before {
            content: "·";
            margin: 0 4px;
        }

        .post-image-wrap {
            flex: 2;
            max-width: 260px;
        }

        .post-image {
            width: 100%;
            border-radius: 14px;
            object-fit: cover;
            border: 1px solid #e5e7eb;
            background: #f3f4f6;
        }

        .post-content {
            margin-top: 14px;
            padding-top: 12px;
            border-top: 1px solid #e5e7eb;
            font-size: 14px;
            color: #4b5563;
            line-height: 1.7;
            white-space: pre-wrap; /* 줄바꿈 유지 */
        }

        .post-actions {
            margin-top: 18px;
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        /* COMMENT CARD ------------------------------------------------ */
        .comment-card {
            margin-top: 10px;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .comment-title {
            font-size: 15px;
            font-weight: 600;
        }

        .comment-form {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 12px;
        }

        .comment-form-top {
            display: flex;
            gap: 8px;
        }

        .comment-input,
        .comment-textarea {
            border-radius: 10px;
            border: 1px solid #d1e3ff;
            background: #f8fbff;
            font-size: 13px;
            padding: 8px 10px;
        }

        .comment-input {
            width: 180px;
        }

        .comment-textarea {
            resize: vertical;
            min-height: 70px;
        }

        .comment-input:focus,
        .comment-textarea:focus {
            outline: none;
            border-color: #5fa4ff;
            box-shadow: 0 0 0 2px rgba(95, 164, 255, 0.25);
            background: #ffffff;
        }

        .comment-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 4px;
        }

        .comment-list {
            border-top: 1px solid #e5e7eb;
            padding-top: 10px;
            font-size: 13px;
        }

        .comment-empty {
            font-size: 13px;
            color: #9ca3af;
            padding: 6px 0;
        }

        /* BUTTONS ----------------------------------------------------- */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 14px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 500;
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.16s ease-in-out;
        }

        .btn-primary {
            background: linear-gradient(135deg, #5fa4ff, #3b82f6);
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(96, 165, 250, 0.55);
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(59, 130, 246, 0.7);
        }

        .btn-outline {
            background: #ffffff;
            color: #2563eb;
            border-color: #bfdbfe;
        }

        .btn-outline:hover {
            background: #e5efff;
        }

        .btn-danger {
            background: #fee2e2;
            color: #b91c1c;
        }

        .btn-danger:hover {
            background: #fecaca;
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
        @media (max-width: 720px) {
            .post-header {
                flex-direction: column;
            }

            .post-image-wrap {
                max-width: 100%;
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
            <div class="title">게시판</div>
            <div class="subtitle">게시글 상세 보기</div>
        </div>

        <nav class="nav">
            <a href="/brd/main" class="nav-pill">게시판 홈</a>
            <a href="/brd/list" class="nav-pill">목록</a>
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
    <main class="content">

        <div class="breadcrumb">
            홈 &gt; 게시판 &gt; <span>글 상세</span>
        </div>

        <!-- 게시글 카드 -->
        <section class="card post-card">
            <div class="post-header">
                <div class="post-meta-wrap">
                    <div class="post-badge">no. ${b.bno}</div>
                    <h1 class="post-title">${b.title}</h1>
                    <div class="post-meta">
                        <span>작성자 ${b.writer}</span>
                        <span>등록일 ${b.regdate}</span>
                        <span>수정일 ${b.moddate}</span>
                    </div>
                </div>

                <c:if test="${not empty b.imagefile}">
                    <div class="post-image-wrap">
                        <img class="post-image"
                             alt="첨부 이미지"
                             src="${pageContext.request.contextPath}/_fileUpload/${b.imagefile}">
                    </div>
                </c:if>
            </div>

            <div class="post-content">
                ${b.content}
            </div>

            <div class="post-actions">
                <a href="/brd/list" class="btn btn-outline">목록</a>
                <a href="/brd/modify?bno=${b.bno}" class="btn btn-primary">수정</a>
                <a href="/brd/remove?bno=${b.bno}"
                   class="btn btn-danger"
                   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </div>
        </section>

        <!-- 댓글 카드 -->
        <section class="card comment-card">
            <div class="comment-header">
                <h2 class="comment-title">댓글</h2>
            </div>

            <div class="comment-form">
                <div class="comment-form-top">
                    <input type="text"
                           id="cmtWriter"
                           class="comment-input"
                           value="${ses.id}"
                           readonly="readonly"
                           placeholder="writer...">
                </div>
                <textarea id="cmtText"
                          class="comment-textarea"
                          placeholder="댓글을 입력해 주세요."></textarea>
                <div class="comment-actions">
                    <button type="button" id="cmtAddBtn" class="btn btn-primary">등록</button>
                </div>
            </div>

            <!-- JS에서 채워 넣는 영역 -->
            <div id="commentLine" class="comment-list">
                <p class="comment-empty">댓글이 없습니다. 첫 댓글을 남겨 보세요.</p>
            </div>
        </section>

    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 게시판. All rights reserved.
    </footer>
</div>

<!-- JS 변수 & 스크립트 -------------------------------------------- -->
<script type="text/javascript">
    const bnoValue = `<c:out value="${b.bno}" />`;
    const loginUser = `<c:out value="${ses.id}" />`;
</script>

<script type="text/javascript" src="/resources/boardDetail.js"></script>
<script type="text/javascript">
    // 댓글 목록 출력
    printCommentList(bnoValue);
</script>

</body>
</html>

