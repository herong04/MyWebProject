package cn.network.shop.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cn.network.shop.util.DB;

/**
 * 用户的业务类
 */
public class UserService {
    /**
     * 登录检查
     * @param name
     * @param password
     * @return
     */
    public static User loginCheck(String name,String password){
        User user=null;
        try {
            //1.连接数据库
            Connection connection = DB.getConnection();
            //2.创建预编译对象
            String sql = "select * from user where name=? and password=md5(?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,password);
            //3.执行sql
            ResultSet rs = ps.executeQuery();
            //4.读取数据
            if(rs.next()){
                user=new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getInt("role"));
                user.setRealName(rs.getString("realname"));
                user.setAddress(rs.getString("address"));
            }
            //5.释放资源
            rs.close();
            ps.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    /**
     * 注册
     * @param user
     */
    public static void add(User user){
        try {
            //1.连接数据库
            Connection connection = DB.getConnection();
            //2.建立预编译语句对象
            String sql="insert  into user(name,password,realname,address) values (?,md5(?),?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1,user.getName());
            ps.setString(2,user.getPassword());
            ps.setString(3,user.getRealName());
            ps.setString(4,user.getAddress());
            //3.执行sql
            ps.executeUpdate();
            //4.释放资源
            ps.close();
            connection.close();
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
