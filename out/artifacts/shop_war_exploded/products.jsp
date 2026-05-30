<%@ page import="cn.network.shop.util.DB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品列表</title>
    <style>
        img{
            width:50px;
            height:50px;
            object-fit: contain;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
</head>
<body>
    <table class="table table-hover table-bordered">
        <tr>
            <th>images</th>
            <th>name</th>
            <th>price</th>
        </tr>
        <%
            Connection connection = DB.getConnection();
            Statement statement = connection.createStatement();
            String sql="select image,name,price from product";
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()){
                String image = resultSet.getString("image");
                String name = resultSet.getString("name");
                String price = resultSet.getString("price");
                out.println("<tr>");

                out.println("<td>");
                out.println("<img src='" +image+" '>");
                out.println("</td>");

                out.println("<td>");
                out.println(name);
                out.println("</td>");

                out.println("<td>");
                out.println(price);
                out.println("</td>");

                out.println("</tr>");
            }
            resultSet.close();
            statement.close();
            connection.close();
        %>
    </table>
</body>
</html>
