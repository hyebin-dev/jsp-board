package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import domain.Comment;
import service.CommentService;
import service.CommentServiceImpl;

@WebServlet("/cmt/*")
public class CommentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger log = LoggerFactory.getLogger(CommentController.class);

    // 비동기 방식(ajax) 댓글 처리 컨트롤러
    // JSON / 텍스트 형태로만 응답하므로 JSP forward 없음

    private final CommentService csv;

    public CommentController() {
        csv = new CommentServiceImpl();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        // 숫자도 JSON 스펙 상 유효한 값이므로 통일해서 JSON 타입으로 응답
        response.setContentType("application/json; charset=UTF-8");

        String uri = request.getRequestURI();           // /cmt/post
        String path = uri.substring(uri.lastIndexOf("/") + 1); // post
        log.info(">>> CommentController path >> {}", path);

        switch (path) {

        // 댓글 등록
        case "post":
            try {
                log.info(">>> cmt post...");

                JSONParser parser = new JSONParser();
                JSONObject jsonobj = (JSONObject) parser.parse(request.getReader());
                log.info(">>> jsonobj >> {}", jsonobj);

                int bno = Integer.parseInt(jsonobj.get("bno").toString());
                String writer = jsonobj.get("writer").toString();
                String content = jsonobj.get("content").toString();

                Comment c = new Comment(bno, writer, content);
                int isOk = csv.insert(c);

                log.info(">> cmt insert >> {}", (isOk > 0) ? "성공" : "실패");

                PrintWriter out = response.getWriter();
                out.print(isOk);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 댓글 목록
        case "list":
            try {
                int bno = Integer.parseInt(request.getParameter("bno"));
                log.info(">>>> cmt list bno >> {}", bno);

                List<Comment> list = csv.getList(bno);
                log.info(">>> cmt list >> {}", list);

                // List<Comment> -> JSON 배열
                JSONArray jsonArray = new JSONArray();
                for (Comment c : list) {
                    JSONObject obj = new JSONObject();
                    obj.put("cno", c.getCno());
                    obj.put("bno", c.getBno());
                    obj.put("writer", c.getWriter());
                    obj.put("content", c.getContent());
                    obj.put("regdate", c.getRegdate());
                    jsonArray.add(obj);
                }
                log.info(">>> jsonArray >> {}", jsonArray);

                String jsonData = jsonArray.toJSONString();

                PrintWriter out = response.getWriter();
                out.print(jsonData);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 댓글 삭제
        case "remove":
            try {
                int cno = Integer.parseInt(request.getParameter("cno"));
                int isOk = csv.delete(cno);

                log.info(">> cmt remove >> {}", (isOk > 0) ? "성공" : "실패");

                PrintWriter out = response.getWriter();
                out.print(isOk);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 댓글 수정
        case "modify":
            try {
                BufferedReader br = request.getReader();

                JSONParser parser = new JSONParser();
                JSONObject jsonObj = (JSONObject) parser.parse(br);

                int cno = Integer.parseInt(jsonObj.get("cno").toString());
                String content = jsonObj.get("content").toString();

                Comment c = new Comment(cno, content);
                log.info(">>> modify cmt >> {}", c);

                int isOk = csv.update(c);
                log.info(">> cmt update >> {}", (isOk > 0) ? "성공" : "실패");

                PrintWriter out = response.getWriter();
                out.print(isOk);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;
        }
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

