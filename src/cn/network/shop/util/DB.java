package cn.network.shop.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * 数据库的连接类
 */
public class DB {
    public static Connection getConnection(){
        Connection connection=null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?useSSL=false&serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8", "root", "root");
            System.out.println("数据库已连接...");
        }catch (Exception e){
            e.printStackTrace();
        }
        return connection;
    }
}
