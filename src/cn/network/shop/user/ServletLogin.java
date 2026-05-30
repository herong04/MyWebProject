package cn.network.shop.user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ServletLogin",value = "/login")
public class ServletLogin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1获得表单数据
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        //2调用业务层的方法
        User user = UserService.loginCheck(name, password);
        if(user!=null){
            //将登录成功的用户user存入session
            HttpSession session = request.getSession();
            session.setAttribute("user",user);

            //实现记住用户名和密码
            if(rememberMe!=null){
                Cookie nameCookie = new Cookie("name", name);
                Cookie passwordCookie = new Cookie("password", password);

                nameCookie.setMaxAge(365*24*60*60);
                passwordCookie.setMaxAge(365*24*60*60);

                response.addCookie(nameCookie);
                response.addCookie(passwordCookie);
            }else {
                Cookie nameCookie = new Cookie("name", name);
                Cookie passwordCookie = new Cookie("password", password);

                nameCookie.setMaxAge(0);
                passwordCookie.setMaxAge(0);

                response.addCookie(nameCookie);
                response.addCookie(passwordCookie);
            }

            response.sendRedirect("index.jsp");//重定向
        }else {
            request.setAttribute("loginErrorText","用户名或密码错误...");
            request.getRequestDispatcher("index.jsp").forward(request,response);//转发
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
