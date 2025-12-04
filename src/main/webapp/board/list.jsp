<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 목록 - 게시판</title>

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

        /* 상단 영역 --------------------------------------------------- */
        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
        }

        .board-title-wrap {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .board-title {
            font-size: 18px;
            font-weight: 600;
        }

        .board-sub {
            font-size: 13px;
            color: #6b7280;
        }

        .search-info {
            font-size: 12px;
            color: #9ca3af;
        }

        .search-box {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .search-select,
        .search-input {
            border-radius: 999px;
            border: 1px solid #d1e3ff;
            background: #f8fbff;
            font-size: 13px;
            padding: 7px 10px;
        }

        .search-select {
            min-width: 90px;
        }

        .search-input {
            min-width: 180px;
        }

        .search-select:focus,
        .search-input:focus {
            outline: none;
            border-color: #5fa4ff;
            box-shadow: 0 0 0 2px rgba(95, 164, 255, 0.25);
            background: #ffffff;
        }

        /* BUTTONS ----------------------------------------------------- */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 16px;
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

        /* TABLE ------------------------------------------------------- */
        .board-table {
            margin-top: 14px;
            margin-bottom: 18px;
        }

        table.board-list {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .board-list thead {
            background: #e5efff;
        }

        .board-list th,
        .board-list td {
            padding: 10px 8px;
            text-align: left;
        }

        .board-list th {
            font-weight: 600;
            color: #1f2937;
            border-bottom: 1px solid #cbd5f5;
        }

        .board-list tbody tr {
            border-bottom: 1px solid #e5e7eb;
        }

        .board-list tbody tr:nth-child(even) {
            background: #f9fbff;
        }

        .board-list tbody tr:hover {
            background: #eef4ff;
        }

        .col-no {
            width: 70px;
            text-align: center;
        }

        .col-writer {
            width: 120px;
        }

        .col-date {
            width: 170px;
        }

        .post-link {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #1f2937;
        }

        .thumb {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #e5e7eb;
            background: #f3f4f6;
        }

        .post-title {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* PAGINATION -------------------------------------------------- */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 4px;
            margin-top: 6px;
            font-size: 13px;
        }

        .page-link {
            min-width: 28px;
            padding: 4px 8px;
            border-radius: 999px;
            text-align: center;
            border: 1px solid transparent;
            color: #4b5563;
        }

        .page-link:hover {
            background: #e5efff;
            border-color: #bfdbfe;
            color: #1d4ed8;
        }

        .page-link.current {
            background: #3b82f6;
            color: #ffffff;
            border-color: #2563eb;
            font-weight: 600;
        }

        .page-link.arrow {
            padding: 4px 10px;
        }

        .to-index {
            margin-top: 12px;
            text-align: center;
            font-size: 12px;
        }

        .to-index a {
            color: #2563eb;
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
            .board-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .search-box {
                justify-content: flex-start;
            }

            .col-date {
                display: none;
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
            <div class="subtitle">게시글 목록</div>
        </div>

        <nav class="nav">
            <a href="/brd/main" class="nav-pill">게시판 메인</a>
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

    <!-- MAIN CONTENT -->
    <main class="content">

        <div class="breadcrumb">
            홈 &gt; <span>게시판 목록</span>
        </div>

        <!-- 상단 제목 + 검색 -->
        <section class="card board-header">
            <div class="board-title-wrap">
                <h1 class="board-title">게시글 목록</h1>
                <p class="board-sub">
                    전체 게시글을 한눈에 살펴보고, 검색으로 원하는 글을 빠르게 찾아보세요.
                </p>
                <c:if test="${ph.totalCount gt 0}">
                    <p class="search-info">총 <strong>${ph.totalCount}</strong>개의 글이 있습니다.</p>
                </c:if>
            </div>

            <!-- search line -->
            <form action="/brd/list" method="get">
                <div class="search-box">
                    <select name="type" class="search-select">
                        <option ${ph.pgvo.type eq null ? 'selected' : ''} value="">전체</option>
                        <option ${ph.pgvo.type eq 't' ? 'selected' : ''} value="t">제목</option>
                        <option ${ph.pgvo.type eq 'w' ? 'selected' : ''} value="w">작성자</option>
                        <option ${ph.pgvo.type eq 'c' ? 'selected' : ''} value="c">내용</option>
                    </select>

                    <input type="text" name="keyword" class="search-input"
                           placeholder="검색어를 입력하세요."
                           value="${ph.pgvo.keyword}">

                    <input type="hidden" name="pageNo" value="1">
                    <input type="hidden" name="qty" value="${ph.pgvo.qty}">

                    <button type="submit" class="btn btn-outline">검색</button>

                    <c:if test="${ses.id ne null}">
                        <a href="/brd/register" class="btn btn-primary">✏️ 새 글 작성</a>
                    </c:if>
                    <c:if test="${ses.id eq null}">
                        <a href="/brd/register" class="btn btn-primary">✏️ 글 쓰기</a>
                    </c:if>
                </div>
            </form>
        </section>

        <!-- 게시판 테이블 -->
        <section class="card board-table">
            <table class="board-list">
                <thead>
                <tr>
                    <th class="col-no">no.</th>
                    <th>title</th>
                    <th class="col-writer">writer</th>
                    <th class="col-date">regdate</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="b">
                    <tr>
                        <td class="col-no">${b.bno}</td>
                        <td>
                            <a href="/brd/detail?bno=${b.bno}" class="post-link">
                                <c:if test="${not empty b.imagefile}">
                                    <img class="thumb" alt="thumbnail" src="/_fileUpload/th_${b.imagefile}">
                                </c:if>
                                <span class="post-title">${b.title}</span>
                            </a>
                        </td>
                        <td class="col-writer">${b.writer}</td>
                        <td class="col-date">${b.regdate}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="4" style="text-align:center; padding:14px 0; color:#9ca3af;">
                            아직 등록된 글이 없습니다. 첫 글을 남겨 보세요!
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </section>

        <!-- 페이지 네비게이션 -->
        <nav class="pagination">
            <!-- 이전 -->
            <c:if test="${ph.prev}">
                <a class="page-link arrow"
                   href="/brd/list?pageNo=${ph.startPage-1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">
                    &lt;
                </a>
            </c:if>

            <!-- 숫자 -->
            <c:forEach begin="${ph.startPage}" end="${ph.endPage}" var="i">
                <c:choose>
                    <c:when test="${i eq ph.pgvo.pageNo}">
                        <span class="page-link current">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a class="page-link"
                           href="/brd/list?pageNo=${i}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">
                            ${i}
                        </a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <!-- 다음 -->
            <c:if test="${ph.next}">
                <a class="page-link arrow"
                   href="/brd/list?pageNo=${ph.endPage+1}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">
                    &gt;
                </a>
            </c:if>
        </nav>

        <div class="to-index">
            <a href="/login.jsp">로그인 화면으로 돌아가기</a> ·
            <a href="/brd/main">게시판 메인으로</a>
        </div>

    </main>

    <!-- FOOTER -->
    <footer>
        © 2025 게시판. All rights reserved.
    </footer>
</div>
</body>
</html>
