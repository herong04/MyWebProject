package cn.network.shop.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletGetProductsByName",value = "/search")
public class ServletGetProductsByName extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //设置request的字符编码为”utf-8”
        request.setCharacterEncoding("utf-8");
        //1获取搜索表单中的填写的商品名
        String productName = request.getParameter("productName");
        //2调用商品业务类的getProductsByName()方法
        List<Product> products = ProductService.getProductsByName(productName);
        //3将获得的商品列表数据存入request并转发至首页index.jsp
        request.setAttribute("products",products);
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
