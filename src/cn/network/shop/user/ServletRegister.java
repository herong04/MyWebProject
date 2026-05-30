package cn.network.shop.user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ServletRegister",value = "/register")
public class ServletRegister extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.获得表单数据，封装成user对象
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String realName = request.getParameter("realName");
        String address = request.getParameter("address");

        User user = new User();
        user.setName(name);
        user.setPassword(password);
        user.setRealName(realName);
        user.setAddress(address);

        //2.调用add()方法
        UserService.add(user);

        //3.转发至首页
        request.setAttribute("registerSuccessText","恭喜，注册成功，现在可以登录了…");
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
