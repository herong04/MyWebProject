package cn.network.shop.product;

import cn.network.shop.category.Category;
import cn.network.shop.util.DB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品的业务模型
 */
public class ProductService {
    /**
     * 获得所有的商品数据
     * @return 商品对象的列表
     */
    public static List<Product> getProducts(){
        return getProductsByWhere("");
    }

    private static List<Product> getProductsByWhere(String where) {
        List<Product> products=null;
        try {
            //1.连接数据库
            Connection connection = DB.getConnection();
            //2.声明一个Statement
            Statement statement = connection.createStatement();
            //3.执行sql
            String sql="select p.id pid,p.name pname,price,image,categoryid cid,c.name cname from product p join category c  on p.categoryid = c.id "+where;
            ResultSet resultSet = statement.executeQuery(sql);
            //4.遍历
            while (resultSet.next()){
                //1)读出该条记录的每个字段
                int pid = resultSet.getInt("pid");
                String pname = resultSet.getString("pname");
                double price = resultSet.getDouble("price");
                String image = resultSet.getString("image");
                int cid = resultSet.getInt("cid");
                String cname = resultSet.getString("cname");

                //2)封装成Product对象
                Product product = new Product();
                product.setId(pid);
                product.setName(pname);
                product.setPrice(price);
                product.setImage(image);

                Category category = new Category();
                category.setId(cid);
                category.setName(cname);

                product.setCategory(category);

                //3)加入products列表
                if(products==null){
                    products=new ArrayList<Product>();
                }
                products.add(product);

            }
            //5.释放资源
            resultSet.close();
            statement.close();
            connection.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return products;
    }

    /**
     * 获得指定类别的商品
     * @param categoryId
     * @return
     */

    public static List<Product> getProductsByCategoryId(int categoryId) {
        return getProductsByWhere("where c.id="+categoryId);
    }

    public static List<Product> getProductsByName(String name){
        return getProductsByWhere("where p.name like '%"+name+"%'");
    }
}
