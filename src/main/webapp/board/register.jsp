<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 글 작성 - 게시판</title>

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

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* HEADER ------------------------------------------------------ */

        header {
            background: linear-gradient(90deg, #5b8def, #5fa4ff); /* 메인과 통일 */
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

        /* MAIN -------------------------------------------------------- */

        .content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px 48px;
        }

        .card {
            width: 100%;
            max-width: 720px;
            background: #ffffff;
            border-radius: 26px;
            padding: 28px 32px 26px;
            box-shadow: 0 18px 40px rgba(148, 163, 184, 0.4);
            border: 1px solid rgba(148, 163, 184, 0.2);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 12px;
            margin-bottom: 16px;
        }

        .card-title {
            font-size: 22px;
            font-weight: 600;
        }

        .card-desc {
            font-size: 13px;
            color: #6b7280;
            margin-top: 4px;
            line-height: 1.6;
        }

        .card-meta {
            font-size: 12px;
            color: #9ca3af;
            text-align: right;
        }

        .form {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .form-row {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-row label {
            font-size: 13px;
            font-weight: 500;
            color: #4b5563;
        }

        .form-row input[type="text"],
        .form-row textarea {
            padding: 10px 12px;
            border-radius: 12px;
            border: 1px solid #d1e3ff;
            font-size: 13px;
            background: #f8fbff;
        }

        .form-row textarea {
            min-height: 160px;
            resize: vertical;
            line-height: 1.5;
        }

        .form-row input:focus,
        .form-row textarea:focus {
            outline: none;
            border-color: #5fa4ff;
            box-shadow: 0 0 0 2px rgba(95, 164, 255, 0.25);
            background: #ffffff;
        }

        .form-row input[readonly] {
            background: #f3f4ff;
        }

        .file-row {
            display: flex;
            flex-direction: column;
            gap: 6px;
            font-size: 13px;
        }

        .file-help {
            font-size: 11px;
            color: #9ca3af;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            gap: 12px;
        }

        .form-actions .left {
            font-size: 12px;
            color: #9ca3af;
        }

        .form-actions .right {
            display: flex;
            gap: 8px;
        }

        /* BUTTONS ----------------------------------------------------- */

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 16px;
            border-radius: 999px;
            font-size: 14px;
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

        .btn-outline {
            background: #ffffff;
            color: #2563eb;
            border-color: #bfdbfe;
        }

        .btn-outline:hover {
            background: #e5efff;
        }

        /* FOOTER ------------------------------------------------------ */

        footer {
            border-top: 1px solid rgba(148, 163, 184, 0.25);
            padding: 12px 0 18px;
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

            .card {
                padding: 24px 20px 22px;
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
            <div class="subtitle">새 글 작성</div>
        </div>

        <nav class="nav">
            <a href="/brd/main" class="nav-pill">게시판 메인</a>
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
        <section class="card">
            <div class="card-header">
                <div>
                    <h1 class="card-title">새 글 작성</h1>
                    <p class="card-desc">
                        오늘의 생각이나 일상을 가볍게 남겨 보세요. 이미지를 첨부하면 목록/상세에서 함께 보여집니다.
                    </p>
                </div>
                <div class="card-meta">
                    <c:if test="${ses.id ne null}">
                        작성자: <strong>${ses.id}</strong>
                    </c:if>
                    <c:if test="${ses.id eq null}">
                        작성자: <strong>로그인 필요</strong>
                    </c:if>
                </div>
            </div>

            <!-- enctype="multipart/form-data" : 첨부파일 전송 -->
            <form action="/brd/insert" method="post" enctype="multipart/form-data" class="form">

                <div class="form-row">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요.">
                </div>

                <div class="form-row">
                    <label for="writer">작성자</label>
                    <input type="text"
                           id="writer"
                           name="writer"
                           value="${ses.id}"
                           readonly="readonly"
                           placeholder="writer...">
                </div>

                <div class="form-row">
                    <label for="content">내용</label>
                    <textarea id="content"
                              name="content"
                              placeholder="내용을 입력하세요. (줄바꿈도 그대로 저장됩니다.)"></textarea>
                </div>

                <div class="file-row">
                    <label for="imagefile">이미지 첨부 (선택)</label>
                    <input type="file" id="imagefile" name="imagefile">
                    <p class="file-help">JPG, PNG 등의 이미지를 올리면 목록과 상세 페이지에서 썸네일로 표시됩니다.</p>
                </div>

                <div class="form-actions">
                    <span class="left">작성한 내용은 나중에 수정할 수 있습니다.</span>
                    <div class="right">
                        <a href="/brd/list" class="btn btn-outline">목록으로</a>
                        <button type="submit" class="btn btn-primary">등록하기</button>
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
</body>
</html>

