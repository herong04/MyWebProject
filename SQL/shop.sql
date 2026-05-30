drop database if exists shop;

create database shop character set utf8;

use shop;

/*用户表(id:编号,name:用户名,password:密码,role:角色(0普通用户,1管理员),realname:姓名,address:收货地址)*/
create table user
(
    id       int primary key auto_increment,
    name     varchar(20),
    password varchar(100),
    role     int default 0,
    realname varchar(20),
    address varchar(100)
);

/*分类表(id:分类编号,name:分类名称)*/
create table category
(
    id   int primary key auto_increment,
    name varchar(20)
);

/*商品表(id:商品编号,name:商品名称,price:价格,image:图片地址,categoryid:分类编号)*/
create table product
(
    id         int primary key auto_increment,
    name       varchar(255),
    price      double,
    image      varchar(255),
    categoryid int,
    constraint FK_categoryid foreign key(categoryid) references category (id)
);

/*订单表(id:订单号,userid:用户编号,odate:下单时间,status:订单状态(0废单,1已发货,2待收货,3已完成))*/
create table saleorder
(
    id      int primary key auto_increment,
    userid  int,
    odate   datetime default current_timestamp,
    status  int,
    constraint FK_userid FOREIGN KEY(userid) references user(id)
);

/*订单项表(id:编号,productid:商品编号,count:商品数量,orderid:所属订单)*/
create table orderitem
(
    id        int primary key auto_increment,
    productid int,
    count     int,
    orderid   int ,
    constraint FK_productid foreign key(productid) references product(id),
    constraint FK_orderid foreign key(orderid) references saleorder(id) on delete cascade
);

/*录入用户数据*/
insert into user(name,password,realname,address) values('jack',md5('123456'),'杰克','芜湖职业技术学院南校区厚德楼1117室');
insert into user(name,password,role,realname,address) values('admin',md5('123456'),1,'马克','芜湖职业技术学院北校区2号楼110室');

/*录入分类数据*/
insert into category(name) values('男装');
insert into category(name) values('女装');
insert into category(name) values('童装');
insert into category(name) values('鞋帽');
insert into category(name) values('数码');
insert into category(name) values('家电');

/*录入商品数据*/
insert into product(name,price,image,categoryid) values ('罗蒙（ROMON）品牌轻奢男装',269.00,'https://img10.360buyimg.com/n7/jfs/t1/159883/31/14482/165951/6056b0cfEdc1b89c5/1604f5ef3ba61d5e.jpg',1);
insert into product(name,price,image,categoryid) values ('雅戈尔【免烫】衬衫男 纯色衬衫',379.00,'https://img14.360buyimg.com/n7/jfs/t1/191306/8/7840/212682/60c389a3E4d080f79/546034a1c6c28bf0.jpg',1);
insert into product(name,price,image,categoryid) values ('HCVIP轻奢品牌高端晚礼服女2021新款气',2580.00,'https://img13.360buyimg.com/n7/jfs/t1/188622/32/704/123685/608bb368Ea05b145f/9a5d576898472bef.jpg',2);
insert into product(name,price,image,categoryid) values ('麦斯贝思金色晚礼服女平时可穿气质高贵',218.00,'https://img10.360buyimg.com/n7/jfs/t1/109500/23/6039/135637/5e4409a4Ee7be1b01/4597b75151056635.jpg',2);
insert into product(name,price,image,categoryid) values ('男童衬衫2021款童装',65.00,'https://img10.360buyimg.com/n7/jfs/t1/171671/39/13772/212032/60c0c5b4E67783809/3e224c90283ab157.jpg',3);
insert into product(name,price,image,categoryid) values ('fila斐乐童装女童针织短袖衫',279.50,'https://img14.360buyimg.com/n7/jfs/t1/181620/22/8787/210827/60c4ecf0Ec3023621/3e182380bfffc9ad.jpg',3);
insert into product(name,price,image,categoryid) values ('稻草人风衣男秋冬季羊毛呢外套大衣',288.00,'https://img10.360buyimg.com/n7/jfs/t1/198199/19/12780/153411/6164f1e0Ebec3cc11/97cf748f40335e03.jpg',1);
insert into product(name,price,image,categoryid) values ('红都 中山装套装中山服立领国服民族风',980.00,'https://img11.360buyimg.com/n7/jfs/t13228/174/1478613891/68439/cf21db59/5a20bd15Ne73abd15.jpg',1);
insert into product(name,price,image,categoryid) values ('慕美意 高档轻奢真丝衬衫女桑蚕丝长袖上',248.00,'https://img10.360buyimg.com/n7/jfs/t1/96149/23/22333/210948/621d04efE536ba1d5/3d0a6d6bf67dba4c.jpg',2);
insert into product(name,price,image,categoryid) values ('VIAFRR香港潮牌轻熟风减龄2021秋冬新',1356.00,'https://img10.360buyimg.com/n7/jfs/t1/156358/9/24490/111404/61906ce8E26244c01/e897af33fc4d8ffa.jpg',2);
insert into product(name,price,image,categoryid) values ('凯得丽斯白雪公主裙加绒女童蓬蓬裙',138.00,'https://img12.360buyimg.com/n7/jfs/t1/149283/37/24707/180311/620f4b13E4083ded3/705ad3d95ba3b0b8.jpg',3);
insert into product(name,price,image,categoryid) values ('MQD童装男童2021冬季新款卫衣',299.00,'https://img10.360buyimg.com/n7/jfs/t1/214959/38/7739/752630/61b86ab0E1c02745e/759708f27d6e5efe.jpg',3);




