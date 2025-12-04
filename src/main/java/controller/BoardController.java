package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import domain.Board;
import domain.PagingVO;
import handler.FileRemoveHandler;
import handler.PagingHandler;
import net.coobird.thumbnailator.Thumbnails;
import service.BoardService;
import service.BoardServiceImpl;

@WebServlet("/brd/*")
public class BoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Logger log = LoggerFactory.getLogger(BoardController.class);

    private RequestDispatcher rdp;
    private String destPage;
    private int isOk;

    private BoardService bsv;

    public BoardController() {
        bsv = new BoardServiceImpl();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        log.info(">>> BoardController Service method in Test!!");

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String uri = request.getRequestURI();          // /jsp_project/brd/xxx
        log.info(">>> {}", uri);

        String path = uri.substring(uri.lastIndexOf("/") + 1);   // xxx
        log.info(">>> {}", path);

        switch (path) {

        // 게시판 메인 화면 (/brd/main)
        case "main":
            destPage = "/board/main.jsp";
            resForword(request, response);
            break;

        // 글쓰기 화면
        case "register":
            destPage = "/board/register.jsp";
            resForword(request, response);
            break;

        // 글 등록
        case "insert":
            try {
                String savePath = getServletContext().getRealPath("/_fileUpload");
                log.info(">>>> savePath>> {}", savePath);

                File fileDir = new File(savePath);
                log.info(">>>> fileDir>> {}", fileDir);

                DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
                fileItemFactory.setRepository(fileDir);
                fileItemFactory.setSizeThreshold(1024 * 1024 * 3);

                Board board = new Board();

                ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);
                List<FileItem> itemList = fileUpload.parseRequest(request);
                log.info(">>>> itemList>> {}", itemList);

                for (FileItem item : itemList) {
                    switch (item.getFieldName()) {
                    case "title":
                        board.setTitle(item.getString("UTF-8"));
                        break;
                    case "writer":
                        board.setWriter(item.getString("UTF-8"));
                        break;
                    case "content":
                        board.setContent(item.getString("UTF-8"));
                        break;
                    case "imagefile":
                        if (item.getSize() > 0) {
                            String fileName = item.getName();
                            fileName = System.currentTimeMillis() + "_" + fileName;

                            File uploadFile = new File(fileDir + File.separator + fileName);
                            log.info(">>>> uploadFile >> {}", uploadFile);

                            try {
                                item.write(uploadFile);
                                board.setImagefile(fileName);

                                Thumbnails.of(uploadFile)
                                        .size(75, 75)
                                        .toFile(new File(fileDir + File.separator + "th_" + fileName));

                            } catch (Exception e) {
                                e.printStackTrace();
                                log.info(">> file write on disk error");
                            }
                        }
                        break;
                    }
                }

                isOk = bsv.insert(board);
                log.info(">>> insert {}", (isOk > 0) ? "성공" : "실패");

                response.sendRedirect("list");

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 목록
        case "list":
            try {
                PagingVO pgvo = new PagingVO();

                if (request.getParameter("pageNo") != null) {
                    int pageNo = Integer.parseInt(request.getParameter("pageNo"));
                    int qty = Integer.parseInt(request.getParameter("qty"));
                    String type = request.getParameter("type");
                    String keyword = request.getParameter("keyword");
                    pgvo = new PagingVO(pageNo, qty, type, keyword);
                }

                List<Board> list = bsv.getPageList(pgvo);
                log.info(">>> list {}", list);

                int totalCount = bsv.getTotal(pgvo);

                PagingHandler ph = new PagingHandler(pgvo, totalCount);
                log.info(">>> ph >> {}", ph);

                request.setAttribute("list", list);
                request.setAttribute("ph", ph);
                destPage = "/board/list.jsp";
                resForword(request, response);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 상세 & 수정 화면 공통 처리
        case "detail":
        case "modify":
            try {
                int bno = Integer.parseInt(request.getParameter("bno"));

                Board board = bsv.getDetail(bno);
                log.info(">>> detail {}", board);
                request.setAttribute("b", board);
                destPage = "/board/" + path + ".jsp";
                resForword(request, response);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 수정 처리
        case "update":
            try {
                String savePath = getServletContext().getRealPath("/_fileUpload");
                File fileDir = new File(savePath);
                int size = 1024 * 1024 * 3;
                DiskFileItemFactory fileItemFactory = new DiskFileItemFactory(size, fileDir);

                Board board = new Board();
                ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);
                List<FileItem> itemList = fileUpload.parseRequest(request);

                String old_file = null;

                for (FileItem item : itemList) {
                    switch (item.getFieldName()) {
                    case "bno":
                        board.setBno(Integer.parseInt(item.getString("UTF-8")));
                        break;
                    case "title":
                        board.setTitle(item.getString("UTF-8"));
                        break;
                    case "content":
                        board.setContent(item.getString("UTF-8"));
                        break;
                    case "imagefile":
                        old_file = item.getString("UTF-8");
                        break;
                    case "newFile":
                        if (item.getSize() > 0) {
                            if (old_file != null) {
                                FileRemoveHandler fh = new FileRemoveHandler();
                                boolean isDel = fh.deleteFile(savePath, old_file);
                                log.info(">>> old file delete : {}", isDel ? "ok" : "fail");
                            }

                            String fileName = System.currentTimeMillis() + "_" + item.getName();
                            File uploadFile = new File(fileDir + File.separator + fileName);
                            try {
                                item.write(uploadFile);
                                board.setImagefile(fileName);

                                Thumbnails.of(uploadFile)
                                        .size(75, 75)
                                        .toFile(new File(fileDir + File.separator + "th_" + fileName));

                            } catch (Exception e) {
                                e.printStackTrace();
                                log.info("file write update error");
                            }
                        } else {
                            board.setImagefile(old_file);
                        }
                        break;
                    }
                }

                isOk = bsv.update(board);
                log.info(">>> update {}", (isOk > 0) ? "성공" : "실패");
                response.sendRedirect("detail?bno=" + board.getBno());

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 삭제
        case "remove":
            try {
                int bno = Integer.parseInt(request.getParameter("bno"));
                isOk = bsv.delete(bno);
                log.info(">>> delete {}", (isOk > 0) ? "성공" : "실패");
                response.sendRedirect("list");

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;
        }
    }

    private void resForword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        rdp = request.getRequestDispatcher(destPage);
        rdp.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        service(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        service(request, response);
    }
}


