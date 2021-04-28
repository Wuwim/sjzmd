SET NAMES UTF8;
DROP DATABASE IF EXISTS sj;
CREATE DATABASE sj CHARSET=UTF8;
USE sj;


/**手机型号家族**/
CREATE TABLE sj_sj_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname VARCHAR(32)
);

/**手机**/
CREATE TABLE sj_sj(
  lid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属型号家族编号
  project_id INT,
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #副标题
  price DECIMAL(10,2),        #价格
  promise VARCHAR(64),        #服务承诺
  spec VARCHAR(64),           #规格/颜色
  lname VARCHAR(32),          #商品名称
  os VARCHAR(32),             #操作系统
  memory VARCHAR(32),         #内存容量
  resolution VARCHAR(32),     #分辨率
  cpu VARCHAR(32),            #处理器
  video_memory VARCHAR(32),   #显存容量
  disk VARCHAR(32),           #内存容量及类型
  details VARCHAR(1024),      #产品详细说明
  shelf_time BIGINT,          #上架时间
  sold_count INT,             #已售出的数量
  is_onsale BOOLEAN           #是否促销中
);

/**手机图片**/
CREATE TABLE sj_sj_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  sj_id INT,              #手机编号
  sm VARCHAR(128),            #小图片路径
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);

/**用户信息**/
CREATE TABLE sj_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),

  avatar VARCHAR(128),        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小明
  gender INT                  #性别  0-女  1-男
);

/**收货地址信息**/
CREATE TABLE sj_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名

  is_default BOOLEAN          #是否为当前用户的默认收货地址
);

/**购物车条目**/
CREATE TABLE sj_shopping_cart(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  product_id INT,   #商品编号
  count INT,        #购买数量
  is_checked BOOLEAN #是否已勾选，确定购买
);

/**首页轮播图表**/
CREATE TABLE sj_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),          #图片路径
  title VARCHAR(64),         #图片描述
  href VARCHAR(128)          #图片链接
);

/**首页商品栏目表**/
CREATE TABLE sj_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),            #商品标题
  details VARCHAR(128),         #详细描述
  pic VARCHAR(128),             #图片
  price DECIMAL(10,2),          #商品价格
  href VARCHAR(128),         
  seq_recommended TINYINT,          
  seq_new_arrival TINYINT,       
  seq_top_sale    TINYINT         
);

/*******************/
/******数据导入******/
/*******************/
/**手机型号家族**/
INSERT INTO sj_sj_family VALUES
(NULL,'Apple'),
(NULL,'小米'),
(NULL,'华为'),
(NULL,'SAMSUNG');

/**手机**/
INSERT INTO sj_sj VALUES
(1,1,1,'iphone 12 pro max 石墨色(新一代A14仿生芯片/512GB内存/)','新款上新',11899,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','新一代A14仿生芯片/512GB内存/ ','iphone 12 pro max','ios','6G','2532 x 1170 ','新一代A14仿生芯片','6G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(2,1,2,'iphone SE 白色(第三代A13仿生芯片/256GB内存/)','新款上新',4599,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','第三代A13仿生芯片/256GB内存/ ','iphone SE','ios','6G','1334 x 750  ','第三代A13仿生芯片','6G','256GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(3,1,3,'iphone 11 绿色(第三代A13仿生芯片/512GB内存/)','新款上新',6099,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','第三代A13仿生芯片/256GB内存/','iphone 11','ios','6G','1792 x 828 ','第三代A13仿生芯片','6G','256GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(4,2,4,'MIX FOLD 陶瓷特别版(高通骁龙™888/512GB内存/)','新款上新',12999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','高通骁龙™888/512GB内存/','MIX FOLD','MIUI 12','16G','2480 x 1860 ','高通骁龙™888','16G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(5,2,5,'小米11 Ultra 大理石纹特别版(高通骁龙™888/512GB内存/)','新款上新',6999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','高通骁龙™888/512GB内存/','小米11 Ultra','MIUI 12','12G','3200 x 1440 ','高通骁龙™888','12G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(6,2,6,'小米11 Pro 石墨色((高通骁龙™888/512GB内存/)','新款上新',5699,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','(高通骁龙™888/256GB内存/','小米11 Pro','MIUI 12','12G','3200 x 1440 ','(高通骁龙™888','12G','256GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(7,3,7,'HUAWEI Mate 40 Pro  秋日胡杨(麒麟9000/512GB内存/)','新款上新',7999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','麒麟9000/512GB内存/','HUAWEI Mate 40 Pro ','EMUI 11.0','8G','2772 x 1344  ','麒麟9000','8G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(8,3,8,'HUAWEI Mate 40 RS 保时捷设计 陶瓷白(麒麟9000/512GB内存/)','新款上新',13999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','麒麟9000/512GB内存/','HUAWEI Mate 40 RS 保时捷设计','EMUI 11.0','12G','2772 x 1344 ','麒麟9000','12G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(9,4,9,'Galaxy S21 Ultra 5G 幽夜黑(高通骁龙888/512GB内存/)','新款上新',10699,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','高通骁龙888/512GB内存/','Galaxy S21 Ultra 5G','Android 10','16G','3200 x 1440 ','高通骁龙888','16G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true),
(10,4,10,'Galaxy Z Fold2 Thom Browne 限量版 松烟墨(高通骁龙888/512GB内存/)','新款上新',14999,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','高通骁龙888/512GB内存/','Galaxy Z Fold2 Thom Browne 限量版','Android 10','12G','2532 x 1170 ','高通骁龙888','12G','512GB','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>',150123456789,2968,true);



/**手机图片**/
INSERT INTO sj_sj_pic VALUES
(NULL, 1, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 1, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 1, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 2, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 2, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 2, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 3, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 3, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 4, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 4, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg');

/**用户信息**/
INSERT INTO sj_user VALUES
(NULL, 'huhu', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '胡邵俊', '1'),
(NULL, 'lele', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '乐子哥', '1'),
(NULL, 'cheche', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '机车哥', '1'),
(NULL, 'niuniu', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '牛子哥', '0');

/****首页轮播广告商品****/
INSERT INTO sj_index_carousel VALUES
(NULL, 'img/index/banner1.png','轮播广告商品1','product_details.html?lid=28'),
(NULL, 'img/index/banner2.png','轮播广告商品2','product_details.html?lid=19'),
(NULL, 'img/index/banner3.png','轮播广告商品3','lookforward.html'),
(NULL, 'img/index/banner4.png','轮播广告商品4','lookforward.html');

/****首页商品****/
INSERT INTO sj_index_product VALUES
(NULL, 'iphone 12 pro max 石墨色', '新一代A14仿生芯片|512GB内存|6G运行内存', 'img/index/study_phone_img1.png', 11899, 'product_details.html?lid=1', 1, 1, 1),
(NULL, 'iphone SE 白色', '第三代A13仿生芯片|256GB内存|6G运行内存', 'img/index/study_phone_img2.png', 4599, 'product_details.html?lid=5', 2, 2, 2),
(NULL, 'iphone 11 绿色', '第三代A13仿生芯片|512GB内存|6G运行内存', 'img/index/study_phone_img3.png', 6099, 'product_details.html?lid=9', 3, 3, 3),
(NULL, 'MIX FOLD 陶瓷特别版', '高通骁龙™888|512GB内存|16G运行内存', 'img/index/study_phone_img4.png', 12999, 'product_details.html?lid=13', 4, 4, 4),
(NULL, '小米11 Ultra 大理石纹特别版', '高通骁龙™888|512GB内存|12G运行内存', 'img/index/study_phone_img5.png', 6999, 'product_details.html?lid=17', 5, 5, 5),
(NULL, '小米11 Pro 石墨色', '酷睿双核i5处理器|512GB内存|12G运行内存', 'img/index/study_phone_img3.png', 5699, 'product_details.html?lid=19', 6, 6, 6),
(NULL, 'HUAWEI Mate 40 Pro  秋日胡杨', '麒麟9000|512GB内存|8G运行内存', 'img/index/study_phone_img4.png', 7999, 'product_details.html?lid=38', 0, 0, 0),
(NULL, 'HUAWEI Mate 40 RS 保时捷设计 陶瓷白', '麒麟9000512GB内存|12G运行内存', 'img/index/study_phone_img4.png', 13999, 'product_details.html?lid=38', 0, 0, 0),
(NULL, 'Galaxy S21 Ultra 5G 幽夜黑', '高通骁龙888|512GB内存|16G运行内存', 'img/index/study_phone_img4.png', 10699, 'product_details.html?lid=38', 0, 0, 0),
(NULL, 'Galaxy Z Fold2 Thom Browne 限量版 松烟墨', '高通骁龙888|512GB内存|12G运行内存', 'img/index/study_phone_img4.png', 14999, 'product_details.html?lid=38', 0, 0, 0);


/****用户地址****/
INSERT INTO sj_receiver_address VALUES
(1,1,'王守义','浙江','宁波','镇海区','毓秀路488','12312355','0123456','332020','秀儿你来了','1'),
(2,1,'机车哥','浙江','宁波','海曙区','毓秀路489','12312355','0123456','332020','秀儿你来了','0'),
(3,2,'牛子哥','浙江','宁波','鄞州区','毓秀路478','12312355','0123456','332020','秀儿你来了','1'),
(4,2,'阿炫','浙江','宁波','北仑区','毓秀路498','12312355','0123456','332020','秀儿你来了','0'),
(5,2,'阿兵','浙江','宁波','江北区','毓秀路428','12312355','0123456','332020','秀儿你来了','1'),
(6,2,'老干妈','浙江','宁波','奉化区','毓秀路438','12312355','0123456','332020','秀儿你来了','0'),
(7,3,'杰尼龟','浙江','宁波','镇海区','毓秀路408','12312355','0123456','332020','秀儿你来了','1'),
(8,3,'星之卡比','浙江','宁波','镇海区','毓秀路888','12312355','0123456','332020','秀儿你来了','1'),
(9,4,'黄皮耗子','浙江','宁波','镇海区','毓秀路688','12312355','0123456','332020','秀儿你来了','1');

/****购物车****/
INSERT INTO sj_shopping_cart VALUES
(1,1,2,3,1),
(2,1,1,5,0);
