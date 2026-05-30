package cn.network.shop.product;

import cn.network.shop.category.Category;

/**
 * 商品实体模型
 */
public class Product {
    private int id;
    private String name;
    private double price;
    private String image;
    private Category category;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    //重写toString()方法，以便在控制台输出Product对象
    @Override
    public String toString() {
        return id+","+name+","+price+","+image+","+category.getId()+","+category.getName();
    }
}
