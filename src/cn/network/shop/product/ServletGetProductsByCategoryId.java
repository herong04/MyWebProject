package cn.network.shop.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletGetProductsByCategoryId", value = "/getProductsByCategoryId")
public class ServletGetProductsByCategoryId extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1获得分类编号
        String categoryId = request.getParameter("categoryId");
        int cid = Integer.parseInt(categoryId);
        //2调用业务
        List<Product> products = ProductService.getProductsByCategoryId(cid);
        //3转发
        request.setAttribute("products", products);
        request.getRequestDispatcher("index.jsp").forward(request, response);

    }
}
