package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import domain.User;
import service.UserService;
import service.UserServiceImpl;

@WebServlet("/user/*")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    // 요청에 대한 응답 데이터를 jsp 로 전달할 때 사용
    private RequestDispatcher rdp;
    private String destPage;

    private UserService usv; // interface

    public UserController() {
        usv = new UserServiceImpl();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String uri = request.getRequestURI();
        String path = uri.substring(uri.lastIndexOf("/") + 1);
        log.info(">>>> UserController path >> {}", path);

        switch (path) {

        // 회원가입 화면
        case "register":
            destPage = "/member/register.jsp";
            forwardMethod(request, response);
            break;

        // 회원가입 처리
        case "insert":
            try {
                String id = request.getParameter("id");
                String pwd = request.getParameter("pwd");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");

                User user = new User(id, pwd, email, phone);
                int isOk = usv.insert(user);

                log.info(">>>> insert user >> {}", (isOk > 0) ? "성공" : "실패");

                // 회원가입 후 로그인 페이지로 이동
                destPage = "/login.jsp";
                response.sendRedirect(destPage);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 로그인 처리
        case "login":
            try {
                String id = request.getParameter("id");
                String pwd = request.getParameter("pwd");

                // id와 pwd가 일치하는 User 객체 리턴
                User loginUser = usv.getUser(new User(id, pwd));
                log.info(" >>>> loginUser >> {}", loginUser);

                if (loginUser != null) {
                    // 세션에 로그인 정보 저장
                    HttpSession ses = request.getSession();
                    ses.setAttribute("ses", loginUser);
                    ses.setMaxInactiveInterval(60 * 10); // 로그인 유지 시간(초)
                    log.info(">>> ses >> {}", ses);

                    // 로그인 성공 시 게시판 메인으로 이동
                    destPage = "/brd/main";

                } else {
                    // 로그인 실패 시 login.jsp 에서 알림 띄우도록 쿼리스트링 전달
                    destPage = "/login.jsp?login_msg=notUser";
                }

                response.sendRedirect(destPage);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 로그아웃
        case "logout":
            try {
                HttpSession ses = request.getSession();
                User loginUser = (User) ses.getAttribute("ses");

                // 마지막 로그인 시간 기록
                int isOk = usv.lastLoginUpdate(loginUser.getId());
                log.info(">>> lastLogin update >> {}", (isOk > 0) ? "성공" : "실패");

                // 세션 종료
                ses.removeAttribute("ses");
                ses.invalidate();

                // 로그아웃 후 로그인 페이지로 이동
                destPage = "/login.jsp";
                response.sendRedirect(destPage);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 회원정보 수정 화면
        case "modify":
            destPage = "/member/modify.jsp";
            forwardMethod(request, response);
            break;

        // 회원정보 수정 처리
        case "update":
            try {
                String id = request.getParameter("id");
                String pwd = request.getParameter("pwd");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");

                User user = new User(id, pwd, email, phone);
                int isOk = usv.update(user);
                log.info(">>> update isOk >> {}", (isOk > 0) ? "성공" : "실패");

                // 수정 성공 시 세션 끊고 다시 로그인하게 유도
                if (isOk > 0) {
                    HttpSession ses = request.getSession();
                    ses.removeAttribute("ses");
                    ses.invalidate();
                    destPage = "/login.jsp?update_msg=OK";
                } else {
                    destPage = "modify?update_msg=Fail";
                }

                response.sendRedirect(destPage);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;

        // 회원 탈퇴
        case "remove":
            try {
                HttpSession ses = request.getSession();
                String id = ((User) ses.getAttribute("ses")).getId();

                int isOk = usv.delete(id);
                log.info(">>> delete user >> {}", (isOk > 0) ? "성공" : "실패");

                if (isOk > 0) {
                    ses.removeAttribute("ses");
                    ses.invalidate();
                    destPage = "/login.jsp?delete_msg=OK";
                } else {
                    destPage = "modify?delete_msg=Fail";
                }

                response.sendRedirect(destPage);

            } catch (Exception e) {
                e.printStackTrace();
            }
            break;
        }
    }

    // forward 공통 처리 메서드
    private void forwardMethod(HttpServletRequest request, HttpServletResponse response)
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
