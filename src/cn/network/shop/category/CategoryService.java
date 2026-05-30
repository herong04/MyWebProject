package cn.network.shop.category;

import cn.network.shop.util.DB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * 分类的业务模型
 */
public class CategoryService {
    /**
     * 从分类表查询所有分类数据
     *
     * @return 分类列表
     */
    public static List<Category> getCategories() {
        List<Category> categories = null;
        try {
            //1.建立连接Connection
            Connection connection = DB.getConnection();
            //2.声明语句对象Statement
            Statement statement = connection.createStatement();
            //3.执行sql
            String sql = "select * from category";
            ResultSet resultSet = statement.executeQuery(sql);
            //4.遍历结果
            while (resultSet.next()) {
                //读每一条记录，封装成Category对象，并加入分类列表categories
                if (categories == null) {
                    categories = new ArrayList<Category>();
                }
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");

                Category category = new Category();
                category.setId(id);
                category.setName(name);

                categories.add(category);

            }
            //5.释放资源
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
