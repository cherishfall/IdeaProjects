-- 添加客户端静态文件资源表
CREATE TABLE `app_resource` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `CITY_CODE` int(10) NOT NULL COMMENT '城市编码',
   `APP_TYPE` int(1) NOT NULL COMMENT '应用类型（1：ANDROID版好停车APP；2：IOS版好停车APP）',
   `VERSION_CODE` varchar(16) NOT NULL COMMENT '版本号',
   `RESOURCE_NAME` varchar(64) NOT NULL COMMENT '资源名称',
   `RESOURCE_TYPE` int(2) DEFAULT '1' COMMENT '资源类型（1图片，2文字）',
   `RESOURCE_SIZE` varchar(10) DEFAULT NULL COMMENT '资源尺寸（大-large；中-middle；小-small）',
   `RESOURCE_FILENAME` varchar(64) NOT NULL COMMENT '资源文件名称',
   `RESOURCE_URL` varchar(225) DEFAULT NULL COMMENT '资源下载路径',
   `RESOURCE_DESC` varchar(128) NOT NULL COMMENT '版本描述',
   `FLAG` varchar(16) NOT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
   PRIMARY KEY (`ID`),
   KEY `APP_RESOURCE_CODE_FILENAME_INDEX` (`CITY_CODE`,`VERSION_CODE`,`RESOURCE_FILENAME`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='APP资源信息表'
 
 -- 每日支付报表
 CREATE TABLE `app_stat_daily` (
   `ID` varchar(36) NOT NULL COMMENT 'ID',
   `DAY_TIME` date DEFAULT NULL COMMENT '日期',
   `CITY_CODE` int(8) DEFAULT NULL COMMENT '城市编码',
   `AREA_CODE` int(8) DEFAULT NULL COMMENT '区域编码',
   `ALL_TRAN_COUNT` int(8) DEFAULT NULL COMMENT '交易总笔数',
   `PAYABLE_FEE` int(8) DEFAULT NULL COMMENT '交易应付金额',
   `TRAN_SUCCESS_AMOUNT` int(8) DEFAULT NULL COMMENT '交易成功金额',
   `TRAN_SUCCESS_COUNT` int(8) DEFAULT NULL COMMENT '交易成功笔数',
   `DISCOUNT_SUCCESS_AMOUNT` int(8) DEFAULT NULL COMMENT '折扣成功金额',
   `DISCOUNT_SUCCESS_COUNT` int(8) DEFAULT NULL COMMENT '折扣成功笔数',
   `SUBS_SUCCESS_COUNT` int(8) DEFAULT NULL COMMENT '预约成功笔数',
   `SUBS_SUCCESS_AMOUNT` int(8) DEFAULT NULL COMMENT '预约成功金额',
   `REFUND_SUCCESS_COUNT` int(8) DEFAULT NULL COMMENT '退费成功笔数',
   `REFUND_SUCCESS_AMOUNT` int(8) DEFAULT NULL COMMENT '退费成功金额',
   `ALIPAY_SUCCESS_COUNT` int(8) DEFAULT NULL COMMENT '支付宝支付成功笔数',
   `ALIPAY_SUCCESS_AMOUNT` int(8) DEFAULT NULL COMMENT '支付宝支付成功金额',
   `WXPAY_SUCCESS_COUNT` int(8) DEFAULT NULL COMMENT '微信支付成功笔数',
   `WXPAY_SUCCESS_AMOUNT` int(8) DEFAULT NULL COMMENT '微信支付成功金额',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
   `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8
 
 -- 流程扭转配置表
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8
 
 -- 流程处理日志表
CREATE TABLE `app_process_log` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `BUSI_ID` varchar(36) NOT NULL COMMENT '申诉记录ID',
   `AREA_CODE` int(10) NOT NULL COMMENT '区域编码',
   `BUSI_TYPE` int(2) DEFAULT NULL COMMENT '业务类型（1申诉）',
   `FROM_USER` varchar(255) NOT NULL COMMENT '来源用户名称',
   `FROM_ROLE` varchar(255) NOT NULL COMMENT '来源用户角色',
   `TO_USER` varchar(255) DEFAULT NULL COMMENT '处理用户名称',
   `TO_ROLE` varchar(255) NOT NULL COMMENT '处理用户角色',
   `FROM_RESULT` varchar(255) NOT NULL COMMENT '来源用户处理意见',
   `FROM_PROCESS_IMAGEURL` varchar(255) DEFAULT NULL COMMENT '来源用户处理意见图片',
   `FROM_TIME` datetime NOT NULL COMMENT '来源用户处理时间',
   `TO_RESULT` varchar(255) DEFAULT NULL COMMENT '处理用户处理意见',
   `TO_PROCESS_IMAGEURL` varchar(255) DEFAULT NULL COMMENT '处理用户处理意见图片',
   `TO_TIME` datetime DEFAULT NULL COMMENT '处理用户处理时间',
   `STATUS` varchar(16) NOT NULL COMMENT '流程处理状态',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8
 
 
 
-- 微信支付原始账单信息
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='微信支付原始账单信息'
 
-- 将base_department表中PARENT_ID字段类型修改为VARCHAR(36)
ALTER TABLE base_department MODIFY COLUMN PARENT_ID VARCHAR(36) COMMENT '上级部门代码';

-- base_role表添加角色等级字段
ALTER TABLE base_role ADD ROLE_LEVEL INT(4) COMMENT '角色等级'  

-- 将base_department表中CITY_CODE字段类型修改为INT(10)
ALTER TABLE base_department MODIFY COLUMN CITY_CODE INT(10) COMMENT 'CITY_CODE';

-- app_order_refund表添加city_code、area_code字段
ALTER TABLE app_order_refund ADD CITY_CODE INT(10) COMMENT '城市编码' AFTER ID,ADD AREA_CODE INT(10) COMMENT '区域编码' AFTER CITY_CODE;

-- app_user_login表添加weixpn_login_count字段
ALTER TABLE app_user_login ADD WEIXPN_LOGIN_COUNT INT(11) COMMENT '微信公众号登录次数' AFTER LOGIN_COUNT;