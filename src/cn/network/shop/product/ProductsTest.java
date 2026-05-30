package cn.network.shop.product;

import java.util.List;

public class ProductsTest {
    public static void main(String[] args) {
        List<Product> products = ProductService.getProducts();
        for (Product product : products) {
            System.out.println(product);
        }
    }
}
