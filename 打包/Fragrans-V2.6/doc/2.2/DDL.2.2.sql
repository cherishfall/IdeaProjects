
-- 地图诱导停车点图标配置表
CREATE TABLE `app_park_mapicon` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `ZOOM_MIN` int(4) DEFAULT NULL COMMENT '缩放比例最小',
   `ZOOM_MAX` int(4) DEFAULT NULL COMMENT '缩放比例最大',
   `COUNT_MIN` int(4) DEFAULT NULL COMMENT '停车点个数最小',
   `COUNT_MAX` int(4) DEFAULT NULL COMMENT '停车点个数最大',
   `PARK_POINT_ICON` varchar(32) DEFAULT NULL COMMENT '空闲停车点图标',
   `PARK_LOT_ICON` varchar(32) DEFAULT NULL COMMENT '空闲停车场图标',
   `SUBS_PARK_LOT_ICON` varchar(32) DEFAULT NULL COMMENT '预约停车场图标',
   `BUSY_PARK_POINT_ICON` varchar(32) DEFAULT NULL COMMENT '繁忙停车点图标',
   `BUSY_PARK_LOT_ICON` varchar(32) DEFAULT NULL COMMENT '繁忙停车场图标',
   `BUSY_SUBS_PARK_LOT_ICON` varchar(32) DEFAULT NULL COMMENT '繁忙预约停车场图标',
   `STATIC_PARK_LOT_ICON` varchar(32) DEFAULT NULL COMMENT '静态停车场图标',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '记录创建时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='地图诱导停车点图标配置表';
 
 
-- 各地区停车发票申领地址
CREATE TABLE `app_area_invoice` (
   `ID` varchar(36) NOT NULL,
   `CITY_CODE` int(8) NOT NULL COMMENT '城市编号',
   `AREA_CODE` int(8) NOT NULL COMMENT '区域编号',
   `LONGITUDE` varchar(32) DEFAULT NULL COMMENT '精度',
   `LATITUDE` varchar(50) DEFAULT NULL COMMENT '纬度',
   `ADDRESS` varchar(225) DEFAULT NULL COMMENT '具体地址',
   `TITLE` varchar(32) DEFAULT NULL COMMENT '标题',
   `TELPHONE` varchar(32) DEFAULT NULL COMMENT '电话号码',
   `ORDER_NUM` int(2) DEFAULT '0' COMMENT '排序号',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) NOT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='各地区停车发票申领地址';
 
-- 接口访问日志表；重新创建。
CREATE TABLE `app_log` (
   `ID` varchar(40) NOT NULL COMMENT '主键ID',
   `APP_ID` varchar(20) DEFAULT NULL COMMENT '应用ID',
   `DEVICE_NO` varchar(40) DEFAULT NULL COMMENT '设备号',
   `NOTE` varchar(800) DEFAULT NULL COMMENT '操作记录描述',
   `REQUEST_MSG` varchar(600) DEFAULT NULL COMMENT '请求数据',
   `REPSONSE_MSG` text COMMENT '响应数据',
   `REQUEST_TIME` datetime DEFAULT NULL COMMENT '请求时间',
   `RESPONSE_TIME` datetime DEFAULT NULL COMMENT '响应时间',
   `FLAG` varchar(8) DEFAULT 'ADD' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   PRIMARY KEY (`ID`,`CREATE_TIME`),
   KEY `APP_LOG_INDEX` (`APP_ID`,`DEVICE_NO`,`CREATE_TIME`),
   KEY `APP_LOG_CREATETIME_INDEX` (`CREATE_TIME`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='应用操作日志表'
 /*!50100 PARTITION BY RANGE (EXTRACT(YEAR_MONTH FROM CREATE_TIME))
 (PARTITION p1 VALUES LESS THAN (201511) ENGINE = InnoDB,
  PARTITION p2 VALUES LESS THAN (201512) ENGINE = InnoDB,
  PARTITION p3 VALUES LESS THAN (201601) ENGINE = InnoDB,
  PARTITION p4 VALUES LESS THAN (201602) ENGINE = InnoDB,
  PARTITION p5 VALUES LESS THAN (201603) ENGINE = InnoDB,
  PARTITION p6 VALUES LESS THAN (201604) ENGINE = InnoDB,
  PARTITION p7 VALUES LESS THAN (201605) ENGINE = InnoDB,
  PARTITION p8 VALUES LESS THAN (201606) ENGINE = InnoDB,
  PARTITION p9 VALUES LESS THAN (201607) ENGINE = InnoDB,
  PARTITION p10 VALUES LESS THAN (201608) ENGINE = InnoDB,
  PARTITION p11 VALUES LESS THAN (201609) ENGINE = InnoDB,
  PARTITION p12 VALUES LESS THAN (201610) ENGINE = InnoDB,
  PARTITION p13 VALUES LESS THAN (201611) ENGINE = InnoDB,
  PARTITION p14 VALUES LESS THAN (201612) ENGINE = InnoDB,
  PARTITION p15 VALUES LESS THAN (201701) ENGINE = InnoDB,
  PARTITION p16 VALUES LESS THAN (201702) ENGINE = InnoDB,
  PARTITION p17 VALUES LESS THAN (201703) ENGINE = InnoDB,
  PARTITION p18 VALUES LESS THAN (201704) ENGINE = InnoDB,
  PARTITION p19 VALUES LESS THAN (201705) ENGINE = InnoDB,
  PARTITION p20 VALUES LESS THAN (201706) ENGINE = InnoDB,
  PARTITION p21 VALUES LESS THAN (201707) ENGINE = InnoDB,
  PARTITION p22 VALUES LESS THAN (201708) ENGINE = InnoDB,
  PARTITION p23 VALUES LESS THAN (201709) ENGINE = InnoDB,
  PARTITION p24 VALUES LESS THAN (201710) ENGINE = InnoDB,
  PARTITION p25 VALUES LESS THAN (201711) ENGINE = InnoDB,
  PARTITION p26 VALUES LESS THAN (201712) ENGINE = InnoDB,
  PARTITION p27 VALUES LESS THAN (201801) ENGINE = InnoDB,
  PARTITION p28 VALUES LESS THAN (201802) ENGINE = InnoDB,
  PARTITION p29 VALUES LESS THAN (201803) ENGINE = InnoDB,
  PARTITION p30 VALUES LESS THAN (201804) ENGINE = InnoDB,
  PARTITION p31 VALUES LESS THAN (201805) ENGINE = InnoDB,
  PARTITION p32 VALUES LESS THAN (201806) ENGINE = InnoDB,
  PARTITION p33 VALUES LESS THAN (201807) ENGINE = InnoDB,
  PARTITION p34 VALUES LESS THAN (201808) ENGINE = InnoDB,
  PARTITION p35 VALUES LESS THAN (201809) ENGINE = InnoDB,
  PARTITION p36 VALUES LESS THAN (201810) ENGINE = InnoDB,
  PARTITION p37 VALUES LESS THAN (201811) ENGINE = InnoDB,
  PARTITION p38 VALUES LESS THAN (201812) ENGINE = InnoDB,
  PARTITION p39 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */
 
 
 
-- 诱导服务数据权限配置表
CREATE TABLE `app_external_conf` (
   `ID` varchar(36) NOT NULL COMMENT 'id',
   `EXTERNAL_ID` varchar(36) NOT NULL COMMENT '应用ID（对应app_external的appid）',
   `AUTH_TYPE` int(1) NOT NULL COMMENT '授权类型 1.区域 2.停车点',
   `AREA_CODE` varchar(16) DEFAULT '1' COMMENT '数据权限区域编号',
   `PARK_ID` varchar(36) DEFAULT NULL COMMENT '停车点Id',
   `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   `CREATE_USER` varchar(32) DEFAULT NULL COMMENT '创建人',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='诱导服务数据权限配置表';
 
-- 客服处理流程配置表 
 CREATE TABLE `app_process_conf` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `ROLE_ID` varchar(36) NOT NULL COMMENT '来源角色ID',
   `PROCESS_ROLE_ID` varchar(36) NOT NULL COMMENT '处理角色ID（111111app用户）',
   `BUSI_TYPE` int(2) NOT NULL COMMENT '业务类型（1申诉）',
   `BUSI_PROCESS_ID` int(16) NOT NULL COMMENT '业务流程ID',
   `BUSI_PROCESS_NAME` varchar(32) NOT NULL COMMENT '业务流程名称',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='客服处理流程配置表';
 
 
-- 客服流程处理日志表
CREATE TABLE `app_process_log` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `BUSI_ID` varchar(36) NOT NULL COMMENT '申诉记录ID',
   `AREA_CODE` int(10) NOT NULL COMMENT '区域编码',
   `BUSI_TYPE` int(2) DEFAULT NULL COMMENT '业务类型（1申诉）',
   `FROM_USER` varchar(255) NOT NULL COMMENT '来源用户名称',
   `FROM_ROLE` varchar(255) NOT NULL COMMENT '来源用户角色',
   `TO_USER` varchar(255) DEFAULT NULL COMMENT '处理用户名称',
   `TO_ROLE` varchar(255) DEFAULT NULL COMMENT '处理用户角色',
   `FROM_RESULT` varchar(255) DEFAULT NULL COMMENT '来源用户处理意见',
   `FROM_PROCESS_IMAGEURL` varchar(255) DEFAULT NULL COMMENT '来源用户处理意见图片',
   `FROM_TIME` datetime NOT NULL COMMENT '来源用户处理时间',
   `TO_RESULT` varchar(255) DEFAULT NULL COMMENT '处理用户处理意见',
   `TO_PROCESS_IMAGEURL` varchar(255) DEFAULT NULL COMMENT '处理用户处理意见图片',
   `TO_TIME` datetime DEFAULT NULL COMMENT '处理用户处理时间',
   `STATUS` varchar(16) NOT NULL COMMENT '流程处理状态',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='客服流程处理日志表';
 
 -- 系统文件上传表 
 CREATE TABLE `app_upload_file` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `CITY_CODE` int(10) DEFAULT NULL COMMENT '城市编码',
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `FILE_NAME` varchar(255) NOT NULL COMMENT '文件名称',
   `NICK_NAME` varchar(36) NOT NULL COMMENT '昵称',
   `BUSI_ID` int(1) NOT NULL COMMENT '业务ID',
   `FILE_TYPE` varchar(20) NOT NULL COMMENT '文件类型',
   `FILE_SIZE` varchar(20) NOT NULL COMMENT '文件大小(单位kb)',
   `WIDTH` varchar(16) DEFAULT NULL COMMENT '宽度',
   `HEIGHT` varchar(16) DEFAULT NULL COMMENT '高度',
   `DOWN_URL` varchar(255) NOT NULL COMMENT '下载地址',
   `REMARK` varchar(2000) DEFAULT NULL COMMENT '备注',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   `DELETED` int(1) DEFAULT '1' COMMENT '1有效；0无效',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='文件上传表';
 
 -- 绑定车牌申诉表记录表
 CREATE TABLE `app_user_car_complain` (
   `ID` varchar(36) NOT NULL COMMENT '主键',
   `CITY_CODE` int(10) NOT NULL,
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `PLATE_NO` varchar(64) DEFAULT NULL COMMENT '车牌号',
   `PLATE_COLOR` int(1) DEFAULT NULL COMMENT '车牌颜色（单个）（默认蓝色0 ；黄1；白2；黑3）',
   `DRIVER_ID` varchar(36) NOT NULL COMMENT '车辆行驶证号',
   `REMARK` varchar(2000) DEFAULT NULL COMMENT '申诉备注',
   `DRIVING_IMAGE` varchar(36) NOT NULL COMMENT '车辆行驶证照片',
   `STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '处理状态（0未受理1受理中2已完成）',
   `PROCESS_USER` varchar(20) DEFAULT NULL COMMENT '处理人',
   `PROCESS_SUGGESTION` varchar(2000) DEFAULT NULL COMMENT '处理意见',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='绑定车牌申诉表'
 
 
 
-- 对账相关-异常账单表(中间件存在，第三方不存在账单)
CREATE TABLE `fanc_order_middleware` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `order_no` varchar(64) DEFAULT NULL COMMENT '交易订单编号',
   `city_code` int(10) DEFAULT NULL COMMENT '城市代码',
   `area_code` int(10) DEFAULT NULL COMMENT '区级代码',
   `pay_type` varchar(10) DEFAULT NULL COMMENT '支付方式(1支付宝;2微信APP支付;3余额支付)',
   `user_id` varchar(36) DEFAULT NULL COMMENT '用户ID',
   `user_account` varchar(32) DEFAULT NULL COMMENT '用户账号',
   `parkrecord_id` varchar(16) NOT NULL COMMENT '停车记录id',
   `price` int(8) DEFAULT '0' COMMENT '订单金额',
   `SUBJECT` varchar(64) DEFAULT NULL COMMENT '订单标题',
   `order_body` varchar(64) DEFAULT NULL COMMENT '订单描述',
   `order_status` varchar(10) DEFAULT NULL COMMENT '订单状态码(200支付成功;100未支付;500支付失败;400订单作废)',
   `order_time` datetime DEFAULT NULL COMMENT '订单时间',
   `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
   `buyer_account` varchar(64) DEFAULT NULL COMMENT '买家账号',
   `notify_status` int(1) DEFAULT '0' COMMENT '通知状态(0：未通知后台或通知未返回成功，1：通知成功返回)',
   `notify_time` varchar(32) DEFAULT NULL COMMENT '最后一次通知时间',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-异常账单表(中间件存在，第三方不存在账单)';
 
 
 
-- 对账相关-(正常账单表,中间件及第三方同时存在账单)
CREATE TABLE `fanc_order_nomal` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `order_no` varchar(64) DEFAULT NULL COMMENT '交易订单编号',
   `city_code` int(10) DEFAULT NULL COMMENT '城市代码',
   `area_code` int(10) DEFAULT NULL COMMENT '区级代码',
   `pay_type` varchar(10) DEFAULT NULL COMMENT '支付方式(1支付宝;2微信APP支付;3余额支付)',
   `user_account` varchar(32) DEFAULT NULL COMMENT '用户账号',
   `parkrecord_id` varchar(16) NOT NULL COMMENT '停车记录id',
   `SUBJECT` varchar(64) DEFAULT NULL COMMENT '订单标题',
   `order_body` varchar(64) DEFAULT NULL COMMENT '订单描述',
   `order_status` varchar(10) DEFAULT NULL COMMENT '订单状态码(200支付成功;100未支付;500支付失败;400订单作废)',
   `order_time` datetime DEFAULT NULL COMMENT '订单时间',
   `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
   `buyer_account` varchar(64) DEFAULT NULL COMMENT '买家账号',
   `notify_status` int(1) DEFAULT '0' COMMENT '通知状态(0：未通知后台或通知未返回成功，1：通知成功返回)',
   `order_fee` varchar(10) DEFAULT NULL COMMENT '订单金额',
   `order_fee_rate` varchar(10) DEFAULT NULL COMMENT '订单费率',
   `service_fee` varchar(10) DEFAULT NULL COMMENT '订单服务费',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-(正常账单表,中间件及第三方同时存在账单)';
 
 
 -- 对账相关-(异常账单表,中间件不存在，第三方存在账单)
 CREATE TABLE `fanc_order_other` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `order_type` int(2) DEFAULT NULL COMMENT '订单种类：1支付宝；2微信',
   `order_no` varchar(64) DEFAULT NULL COMMENT '交易订单编号',
   `transaction_no` varchar(50) DEFAULT NULL COMMENT '第三方订单号',
   `order_title` varchar(50) DEFAULT NULL COMMENT '订单标题',
   `order_fee` varchar(10) DEFAULT NULL COMMENT '订单金额',
   `order_fee_rate` varchar(10) DEFAULT NULL COMMENT '订单费率',
   `service_fee` varchar(10) DEFAULT NULL COMMENT '订单服务费',
   `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
   `buyer_account` varchar(64) DEFAULT NULL COMMENT '买家账号',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-(异常账单表,中间件不存在，第三方存在账单)'
 
 
 -- 对账相关-(支付宝支付原始账单信息)
 CREATE TABLE `rca_alipay_accountlog` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `balance` double(8,2) DEFAULT NULL COMMENT '余额',
   `income` double(8,2) DEFAULT NULL COMMENT '收入金额',
   `outcome` double(8,2) DEFAULT NULL COMMENT '支出金额',
   `trans_date` datetime DEFAULT NULL COMMENT '订单付款时间',
   `sub_trans_code_msg` varchar(20) DEFAULT NULL COMMENT '子业务类型',
   `trans_code_msg` varchar(20) DEFAULT NULL COMMENT '业务类型',
   `merchant_out_order_no` varchar(36) DEFAULT NULL COMMENT '商户订单号',
   `trans_out_order_no` varchar(30) DEFAULT NULL COMMENT '订单号',
   `bank_name` varchar(40) DEFAULT NULL COMMENT '银行名称',
   `bank_account_no` varchar(20) DEFAULT NULL COMMENT '银行账号',
   `bank_account_name` varchar(20) DEFAULT NULL COMMENT '银行账户名字',
   `memo` varchar(200) DEFAULT NULL COMMENT '备注',
   `buyer_account` varchar(20) DEFAULT NULL COMMENT '买家支付宝人民币资金账号',
   `seller_account` varchar(20) DEFAULT NULL COMMENT '卖家支付宝人民币资金账号',
   `seller_fullname` varchar(50) DEFAULT NULL COMMENT '卖家姓名',
   `currency` varchar(10) DEFAULT NULL COMMENT '货币代码',
   `deposit_bank_no` varchar(40) DEFAULT NULL COMMENT '充值流水号',
   `goods_title` varchar(50) DEFAULT NULL COMMENT '商品名称',
   `iw_account_log_id` varchar(20) DEFAULT NULL COMMENT '账务序列号',
   `trans_account` varchar(50) DEFAULT NULL COMMENT '账务本方支付宝人民币资金账号',
   `other_account_email` varchar(50) DEFAULT NULL COMMENT '账务对方邮箱',
   `other_account_fullname` varchar(50) DEFAULT NULL COMMENT '账务对方全称',
   `other_user_id` varchar(50) DEFAULT NULL COMMENT '账务对方支付宝用户号',
   `partner_id` varchar(50) DEFAULT NULL COMMENT '合作者身份ID',
   `service_fee` varchar(50) DEFAULT NULL COMMENT '交易服务费',
   `service_fee_ratio` varchar(50) DEFAULT NULL COMMENT '交易服务费率',
   `total_fee` varchar(50) DEFAULT NULL COMMENT '交易总金额',
   `trade_no` varchar(50) DEFAULT NULL COMMENT '支付宝交易号',
   `trade_refund_amount` varchar(50) DEFAULT NULL COMMENT '累积退款金额',
   `sign_product_name` varchar(50) DEFAULT NULL COMMENT '签约产品，如：高级即时到账',
   `rate` varchar(50) DEFAULT NULL COMMENT '费率',
   `Create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-(支付宝支付原始账单信息)'
 
 
 
-- 对账相关-(支付宝日交易汇总表)
CREATE TABLE `rca_alipay_count` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `total_order_count` int(4) DEFAULT NULL COMMENT '总交易单数，支付宝原始账单数量',
   `total_income_count` double(8,2) DEFAULT NULL COMMENT '总收入额',
   `total_outcome_count` double(8,2) DEFAULT NULL COMMENT '总支出额',
   `total_service_fee` double(8,2) DEFAULT NULL COMMENT '手续费总金额',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-(支付宝日交易汇总表)'
 
 
 
 -- 对账相关-(微信日交易汇总表)
 CREATE TABLE `rca_weixpay_count` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `total_order_count` int(4) DEFAULT NULL COMMENT '总交易单数，支付宝原始账单数量',
   `total_income_count` double(8,2) DEFAULT NULL COMMENT '总交易额',
   `total_outcome_count` double(8,2) DEFAULT NULL COMMENT '总退款金额',
   `total_trade_refund_bm_amount` double(8,2) DEFAULT NULL COMMENT '总企业红包退款金额',
   `total_service_fee` double(8,2) DEFAULT NULL COMMENT '手续费总金额',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-(微信日交易汇总表)'
 
 
 -- 对账相关-(微信支付原始账单信息)
CREATE TABLE `rca_weixpaylist_original` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID 活动编号',
   `STATDATE` date NOT NULL COMMENT '账单日期（yyyy-MM-dd）',
   `BODY` varchar(36) DEFAULT NULL COMMENT '商品名称    例如：中国好停车停车付费',
   `PAY_TIME` varchar(36) DEFAULT NULL COMMENT '交易时间    例如：2016-03-31 12:08:41',
   `SUBSCRIBE_ID` varchar(36) DEFAULT NULL COMMENT '公众账号ID    例如：WX245BE37D304CC60F',
   `MCH_ID` varchar(36) DEFAULT NULL COMMENT '商户号,例如：1308167401',
   `MCH_ID_CHILD` varchar(36) DEFAULT NULL COMMENT '子商户号    例如：0',
   `DEVICE_INFO` varchar(36) DEFAULT NULL COMMENT '设备号 ,例如：',
   `TRANSACTION_ID` varchar(36) DEFAULT NULL COMMENT '微信订单号    例如：4000002001201603314422617207',
   `OUT_TRADE_NO` varchar(36) DEFAULT NULL COMMENT '商户订单号    例如：P02330110160331120829179',
   `OPENID` varchar(36) DEFAULT NULL COMMENT '用户标识    例如：OJYZ8WCLCW6TOJIEBBIFZHUUJNY0',
   `TRADE_TYPE` varchar(36) DEFAULT NULL COMMENT '交易类型    例如：APP',
   `TRADE_STATE` varchar(36) DEFAULT NULL COMMENT '交易状态    例如：SUCCESS',
   `BANK_TYPE` varchar(36) DEFAULT NULL COMMENT '付款银行    例如：CFT',
   `FEE_TYPE` varchar(36) DEFAULT NULL COMMENT '货币种类    例如：CNY',
   `TOTAL_FEE` varchar(36) DEFAULT NULL COMMENT '总金额        例如：4.50',
   `TRADE_BM_AMOUNT` varchar(36) DEFAULT NULL COMMENT '企业红包金额    例如：0.00',
   `REFUND_ID` varchar(36) DEFAULT NULL COMMENT '微信退款单号    例如：0',
   `OUT_REFUND_NO` varchar(36) DEFAULT NULL COMMENT '商户退款单号    例如：0',
   `REFUND_AMOUNT` varchar(36) DEFAULT NULL COMMENT '退款金额    例如：0',
   `TRADE_REFUND_BM_AMOUNT` varchar(36) DEFAULT NULL COMMENT '企业红包退款金额    例如：0',
   `REFUND_TYPE` varchar(36) DEFAULT NULL COMMENT '退款类型    例如：',
   `REFUND_STATUS` varchar(36) DEFAULT NULL COMMENT '退款状态    例如：',
   `ATTACH` varchar(36) DEFAULT NULL COMMENT '商户数据包    例如：',
   `SERVICE_FEE` varchar(36) DEFAULT NULL COMMENT '手续费,例如：0.03000',
   `RATE` varchar(36) DEFAULT NULL COMMENT '费率;例如：0.60%',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='对账相关-(微信支付原始账单信息)'
 
 -- 退款记录表添加区域和城市编码
 ALTER TABLE app_order_refund MODIFY COLUMN CITY_CODE int(10) COMMENT '城市编码';
 ALTER TABLE app_order_refund MODIFY COLUMN AREA_CODE int(10) COMMENT '区域编码';
 -- 用户车牌表，添加车牌颜色
 ALTER TABLE app_user_car MODIFY COLUMN PLATE_COLOR int(1) COMMENT '车牌颜色（0蓝色；1黄色；2黑色；3白色）';
 
 -- app_external_conf表添加停车点类型字段
ALTER TABLE app_external_conf ADD AUTH_PARK_TYPE INT(4) DEFAULT 0 COMMENT '停车点类型(0全部;1停车点;2停车场)' AFTER AUTH_TYPE
 