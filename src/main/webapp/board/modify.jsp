<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정 - 게시판</title>

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
            max-width: 1040px;
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
            padding: 24px 26px 24px;
            box-shadow: 0 14px 34px rgba(148, 163, 184, 0.4);
            border: 1px solid rgba(148, 163, 184, 0.16);
        }

        .card-header {
            margin-bottom: 18px;
        }

        .card-title {
            font-size: 19px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .card-desc {
            font-size: 13px;
            color: #6b7280;
            line-height: 1.6;
        }

        .meta-line {
            font-size: 12px;
            color: #9ca3af;
            margin-top: 8px;
        }

        .meta-line span + span::before {
            content: "·";
            margin: 0 4px;
        }

        /* FORM -------------------------------------------------------- */
        .form {
            display: flex;
            flex-direction: column;
            gap: 14px;
            margin-top: 6px;
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

        .form-input,
        .form-textarea {
            padding: 10px 12px;
            border-radius: 12px;
            border: 1px solid #d1e3ff;
            font-size: 13px;
            background: #f8fbff;
        }

        .form-textarea {
            min-height: 160px;
            resize: vertical;
            line-height: 1.6;
        }

        .form-input:focus,
        .form-textarea:focus {
            outline: none;
            border-color: #5fa4ff;
            box-shadow: 0 0 0 2px rgba(95, 164, 255, 0.25);
            background: #ffffff;
        }

        .readonly-text {
            font-size: 13px;
            color: #4b5563;
            padding: 8px 0;
        }

        .hint {
            font-size: 11px;
            color: #9ca3af;
            margin-top: 3px;
        }

        /* 이미지 영역 -------------------------------------------------- */
        .image-row {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .image-preview-wrap {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .image-preview {
            width: 140px;
            height: 140px;
            border-radius: 14px;
            border: 1px solid #e5e7eb;
            object-fit: cover;
            background: #f3f4f6;
        }

        .image-preview-info {
            font-size: 12px;
            color: #6b7280;
            line-height: 1.5;
        }

        input[type="file"] {
            font-size: 12px;
        }

        /* BUTTONS ----------------------------------------------------- */
        .actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        .btn-group {
            display: flex;
            gap: 8px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 16px;
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

        .btn-outline {
            background: #ffffff;
            color: #2563eb;
            border-color: #bfdbfe;
        }

        .btn-outline:hover {
            background: #e5efff;
        }

        .btn-ghost {
            background: #ffffff;
            color: #4b5563;
            border-color: #cbd5e1;
        }

        .btn-ghost:hover {
            background: #f1f5f9;
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
                padding: 20px 18px 20px;
            }

            .image-row {
                align-items: flex-start;
            }

            .image-preview-wrap {
                flex-direction: column;
                align-items: flex-start;
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
            <div class="subtitle">게시글 수정</div>
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

        <div class="breadcrumb">
            홈 &gt; 게시판 &gt; <span>글 수정</span>
        </div>

        <section class="card">
            <div class="card-header">
                <h1 class="card-title">게시글 수정</h1>
                <p class="card-desc">
                    작성한 글의 제목, 내용, 첨부 이미지를 다시 확인하고 필요한 부분만 수정해 주세요.
                </p>
                <div class="meta-line">
                    <span>no. ${b.bno}</span>
                    <span>작성자 ${b.writer}</span>
                    <span>등록일 ${b.regdate}</span>
                    <span>수정일 ${b.moddate}</span>
                </div>
            </div>

            <form class="form" action="/brd/update" method="post" enctype="multipart/form-data">
                <!-- 필수 hidden 값들 -->
                <input type="hidden" name="bno" value="${b.bno}">
                <input type="hidden" name="imagefile" value="${b.imagefile}">

                <div class="form-row">
                    <label for="mod-title">제목</label>
                    <input id="mod-title"
                           type="text"
                           name="title"
                           class="form-input"
                           value="${b.title}">
                </div>

                <div class="form-row">
                    <label>작성자</label>
                    <div class="readonly-text">${b.writer}</div>
                </div>

                <div class="form-row">
                    <label for="mod-content">내용</label>
                    <textarea id="mod-content"
                              name="content"
                              class="form-textarea">${b.content}</textarea>
                </div>

                <div class="form-row image-row">
                    <label>첨부 이미지</label>

                    <div class="image-preview-wrap">
                        <c:if test="${not empty b.imagefile}">
                            <img class="image-preview"
                                 alt="현재 첨부 이미지"
                                 src="${pageContext.request.contextPath}/_fileUpload/${b.imagefile}">
                        </c:if>
                        <div class="image-preview-info">
                            <c:if test="${not empty b.imagefile}">
                                현재 등록된 이미지가 있습니다.<br>
                            </c:if>
                            새 파일을 선택하면 기존 이미지는 교체됩니다.<br>
                            이미지를 변경하지 않으려면 파일을 선택하지 않고 저장해 주세요.
                        </div>
                    </div>

                    <input type="file" name="newFile">
                    <p class="hint">JPG, PNG 형식의 이미지를 업로드하는 것을 권장합니다.</p>
                </div>

                <div class="actions">
                    <span style="font-size:12px; color:#9ca3af;">
                        수정 후에는 다시 상세 페이지에서 변경 내용을 확인할 수 있습니다.
                    </span>
                    <div class="btn-group">
                        <button type="button"
                                class="btn btn-ghost"
                                onclick="location.href='/brd/detail?bno=${b.bno}'">
                            뒤로가기
                        </button>
                        <button type="button"
                                class="btn btn-outline"
                                onclick="location.href='/brd/list'">
                            목록으로
                        </button>
                        <button type="submit" class="btn btn-primary">
                            수정 내용 저장
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
</body>
</html>
