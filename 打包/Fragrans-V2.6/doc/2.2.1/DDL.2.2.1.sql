
/****
 * 中间件后台SPMS对账表
 */
CREATE TABLE `fanc_order_spms` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `stat_date` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `city_code` int(10) DEFAULT NULL COMMENT '城市代码',
   `order_no` varchar(64) DEFAULT NULL COMMENT '交易订单编号',
   `park_id` varchar(64) DEFAULT NULL COMMENT '停车点ID',
   `parkrecord_id` varchar(64) DEFAULT NULL COMMENT '停车记录id',
   `plate_no` varchar(32) DEFAULT NULL COMMENT '车牌号码',
   `pay_type` varchar(10) DEFAULT NULL COMMENT '支付方式：1支付宝支付；2微信APP支付；3微信公众号支付；4余额支付；',
   `order_type` varchar(10) DEFAULT NULL COMMENT '订单类型：1停车订单；2退费订单',
   `price` int(8) DEFAULT '0' COMMENT '仅限APP上支付的支付金额',
   `refund_no` varchar(36) DEFAULT NULL COMMENT '退款编码',
   `refund_fee` int(8) DEFAULT '0' COMMENT '退款费用',
   `berth_code` varchar(25) DEFAULT NULL COMMENT '泊位编号',
   `park_name` varchar(64) DEFAULT NULL COMMENT '停车点名称',
   `park_durations` varchar(64) DEFAULT NULL COMMENT '停车时长',
   `arrive_time` datetime DEFAULT NULL COMMENT '驶入时间',
   `departure_time` datetime DEFAULT NULL COMMENT '驶离时间',
   `exception_type` int(1) DEFAULT NULL COMMENT '异常类型：1.中间件不存在；2.spms不存在；3.平账',
   `park_type` int(1) DEFAULT NULL COMMENT '停车点类型,1:停车点 2:停车场',
   `error_type` int(1) DEFAULT NULL COMMENT '错误类型：1.中间件不存在账单；2.spms不存在账单；3.金额不匹配；......',
   `error_desc` varchar(400) DEFAULT NULL COMMENT '错误描述',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='中间件后台SPMS对账表';
 
/****
 * 活动,主题,停车券,支付折扣区域配置表
 */ 
CREATE TABLE `app_activity_area_conf` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `OBJ_ID` varchar(36) NOT NULL COMMENT '配置的活动券或活动主题ID',
   `OBJ_TYPE` int(1) NOT NULL COMMENT '配置类型（1主题;2活动;3停车券;4支付方式折扣）',
   `AREA_CODE` int(10) NOT NULL COMMENT '区域代码',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动,主题,停车券,支付折扣区域配置表';


/****
 * 活动代码字典表
 */
CREATE TABLE `app_activity_code` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `ACTIVITY_CODE` varchar(32) NOT NULL COMMENT '活动代码',
   `ACTIVITY_CODE_NAME` varchar(36) NOT NULL COMMENT '活动代码名称',
   `FLAG` varchar(16) NOT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `TYPE` varchar(16) NOT NULL COMMENT '代码类型',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`,`ACTIVITY_CODE`,`ACTIVITY_CODE_NAME`,`FLAG`,`TYPE`,`CREATED_BY`,`CREATE_TIME`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动代码字典表';

 
/****
 * 活动代码配置映射表
 */
CREATE TABLE `app_activity_code_conf` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `ACTIVITY_CODE_ID` varchar(36) NOT NULL COMMENT '活动代码ID',
   `ACTION_NAME` varchar(36) NOT NULL COMMENT '操作名称',
   `SERVICE_NAME` varchar(256) NOT NULL COMMENT '服务名称',
   `FLAG` varchar(16) NOT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动代码配置映射表';
 
 /***
  * 活动触发配置表
  */
 CREATE TABLE `app_activity_tiger_conf` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `ACTIVITY_ID` varchar(36) DEFAULT NULL COMMENT '活动ID',
   `TIGER_TYPE` varchar(16) DEFAULT NULL COMMENT '触发类型（1随机策略 2订单限制策略）',
   `TICKET_COUNT` int(4) DEFAULT '1' COMMENT '触发生成总张数',
   `FLAG` varchar(16) DEFAULT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) DEFAULT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动触发配置表';

/***
 * 下放停车券-订单触发条件限制表
 */
 CREATE TABLE `app_activity_tiger_order_limit` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `TIGER_CONF_ID` varchar(36) DEFAULT NULL COMMENT '触发配置ID',
   `LIMIT_TYPE` varchar(16) DEFAULT NULL COMMENT '限制条件类型(1限制支付金额；2、限制支付笔数；3、限制单笔支付金额）',
   `TICKET_COUNT` int(4) DEFAULT NULL COMMENT '券张数',
   `LIMIT_PAY_FEE_MIN` int(10) DEFAULT '0' COMMENT '限制支付金额区间下限',
   `LIMIT_PAY_FEE_MAX` int(10) DEFAULT '0' COMMENT '限制支付金额区间上限',
   `LIMIT_ONEPAY_FEE_MIN` int(10) DEFAULT '0' COMMENT '限制单笔支付金额区间下限',
   `LIMIT_ONEPAY_FEE_MAX` int(10) DEFAULT '0' COMMENT '限制单笔支付金额区间上限',
   `LIMIT_PAY_COUNT_MIN` int(10) DEFAULT '0' COMMENT '限制支付笔数下限',
   `LIMIT_PAY_COUNT_MAX` int(10) DEFAULT '0' COMMENT '限制支付笔数上限',
   `FLAG` varchar(16) DEFAULT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) DEFAULT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='下放停车券-订单触发条件限制表';


 /***
  * 触发配置停车券关联表
  */
CREATE TABLE `app_activity_tiger_ticket_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `TIGER_CONF_ID` varchar(36) DEFAULT NULL COMMENT '触发配置ID',
   `TIGER_CONF_LIMIT_ID` varchar(36) DEFAULT NULL COMMENT '触发限制配置ID',
   `TICKET_CONF_ID` varchar(36) DEFAULT NULL COMMENT '停车券配置ID',
   `WEIGHT` int(4) DEFAULT '100' COMMENT '权重（指定策略为100）',
   `FLAG` varchar(16) DEFAULT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) DEFAULT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='触发配置停车券关联表';

/**
 * 优惠券发放日志关联表
 */
CREATE TABLE `app_activity_ticket_putlog_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `CITY_CODE` int(10) DEFAULT NULL COMMENT '城市代码',
   `ACTIVITY_ID` varchar(36) NOT NULL COMMENT '关联活动编号',
   `PUTLOG_ID` varchar(36) NOT NULL COMMENT '关联优惠券发放日志ID',
   `TICKET_CONF_ID` varchar(36) NOT NULL COMMENT '活动触发配置关联ID',
   `USER_ID` varchar(36) NOT NULL COMMENT '归属用户ID',
   `PARKRECORD_ID` varchar(16) DEFAULT NULL COMMENT '来源停车记录',
   `ORDERNO` varchar(32) DEFAULT NULL COMMENT '来源订单编号',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`),
   KEY `FK_TICKET_PUTLOG_REL` (`ACTIVITY_ID`),
   KEY `FK_TICKET_PUTLOG_REL1` (`PUTLOG_ID`),
   KEY `FK_TICKET_CONF_REL` (`TICKET_CONF_ID`) USING BTREE,
   CONSTRAINT `FK_TICKET_CONF_REL` FOREIGN KEY (`TICKET_CONF_ID`) REFERENCES `app_activity_ticket_conf` (`ID`),
   CONSTRAINT `FK_TICKET_PUTLOG_REL` FOREIGN KEY (`ACTIVITY_ID`) REFERENCES `app_activity` (`ID`),
   CONSTRAINT `FK_TICKET_PUTLOG_REL1` FOREIGN KEY (`PUTLOG_ID`) REFERENCES `app_activity_ticket_putlog` (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='优惠券发放日志关联表'
 
 
 /****
  * 活动主题信息表
  */
CREATE TABLE `app_activity_topic` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID 活动编号',
   `TOPIC_NAME` varchar(64) NOT NULL COMMENT '活动主题名称',
   `TOPIC_ABSTRACT` varchar(36) DEFAULT NULL COMMENT '活动主题摘要',
   `START_TIME` date NOT NULL COMMENT '开始时间',
   `END_TIME` date NOT NULL COMMENT '结束时间',
   `STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '活动状态（1在线 0下线 ）,默认0',
   `DISPLAYCONF` int(1) NOT NULL COMMENT '显示策略 1在APP上显示',
   `TOPIC_IMAGEURL` varchar(225) DEFAULT NULL COMMENT '宣传图片',
   `TOPIC_URL` varchar(225) NOT NULL COMMENT '活动URL外连接',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) NOT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime NOT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动主题信息表';

 /***
  * 接口请求版本控制表
  */
 CREATE TABLE `app_intf_version` (
   `id` varchar(36) NOT NULL,
   `area_code` varchar(8) NOT NULL COMMENT '城市',
   `intf_type` int(2) DEFAULT NULL COMMENT '接口类型（1APP接口；2spms接口）',
   `intf_service_name` varchar(64) DEFAULT NULL COMMENT '接口服务名',
   `intf_version` varchar(16) DEFAULT NULL COMMENT '接口版本',
   `intf_version_name` varchar(64) DEFAULT NULL COMMENT '版本接口名称',
   `remark` varchar(128) DEFAULT NULL COMMENT '备注',
   `create_by` varchar(32) DEFAULT NULL,
   `update_by` varchar(32) DEFAULT NULL,
   `flag` varchar(8) DEFAULT 'ADD',
   `update_time` datetime DEFAULT NULL,
   `create_time` datetime DEFAULT NULL,
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='接口请求版本控制表';

/*****
CREATE TABLE `base_code` (
   `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
   `CODE_TYPE` varchar(20) NOT NULL COMMENT '编码类型',
   `PREFIX` varchar(2) DEFAULT NULL COMMENT '前缀',
   `MAX_CODE` bigint(20) DEFAULT '0' COMMENT '最大编号',
   `MAX_LEN` int(1) DEFAULT '0' COMMENT '最大长度',
   PRIMARY KEY (`ID`),
   UNIQUE KEY `PK_BASE_CODE` (`ID`)
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='编码表';
 
CREATE TABLE `p_subpartition` (
   `id` int(10) DEFAULT NULL,
   `title` char(255) NOT NULL,
   `createtime` date NOT NULL
 ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
*/ 
 
/****
 * 清分对账（后台账单）
 */
CREATE TABLE `rca_order_spms` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `stat_date` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `city_code` int(10) DEFAULT NULL COMMENT '城市代码',
   `order_no` varchar(64) DEFAULT NULL COMMENT '交易订单编号',
   `park_id` varchar(36) DEFAULT NULL COMMENT '停车点ID',
   `parkrecord_id` varchar(16) DEFAULT NULL COMMENT '停车记录id',
   `plate_no` varchar(32) DEFAULT NULL COMMENT '车牌号码',
   `pay_type` varchar(10) DEFAULT NULL COMMENT '支付方式：1支付宝支付；2微信APP支付；3微信公众号支付；4余额支付；',
   `order_type` varchar(10) DEFAULT NULL COMMENT '订单类型：1停车订单；2退费订单',
   `price` int(8) DEFAULT '0' COMMENT '仅限APP上支付的支付金额',
   `refund_no` varchar(32) DEFAULT NULL COMMENT '退款编码',
   `refund_fee` int(8) DEFAULT '0' COMMENT '退款费用',
   `berth_code` varchar(25) DEFAULT NULL COMMENT '泊位编号',
   `park_name` varchar(64) DEFAULT NULL COMMENT '停车点名称',
   `park_durations` varchar(64) DEFAULT NULL COMMENT '停车时长',
   `arrive_time` datetime DEFAULT NULL COMMENT '驶入时间',
   `departure_time` datetime DEFAULT NULL COMMENT '驶离时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='清分对账（后台账单）';
 
 /***
  * 微信公众号汇总表
  */
CREATE TABLE `rca_weixpnpay_count` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `statdate` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `total_order_count` int(4) DEFAULT NULL COMMENT '总交易单数，微信公众号原始账单数量',
   `total_income_count` double(8,2) DEFAULT NULL COMMENT '总交易额',
   `total_outcome_count` double(8,2) DEFAULT NULL COMMENT '总退款金额',
   `total_trade_refund_bm_amount` double(8,2) DEFAULT NULL COMMENT '总企业红包退款金额',
   `total_service_fee` double(8,2) DEFAULT NULL COMMENT '手续费总金额',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='微信公众号汇总表';
 
 
 /***
  * 微信公众号支付原始账单信息
  */
 CREATE TABLE `rca_weixpnpaylist_original` (
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
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='微信公众号支付原始账单信息';
 
 
 /****
  * 活动消息下发处理日志表
  */
 CREATE TABLE `sre_activity_msg_log` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `MSG_TYPE` varchar(16) DEFAULT NULL COMMENT 'S01表示活动消息；',
   `MSG_SERVICENAME` varchar(48) DEFAULT NULL COMMENT '消息服务名',
   `REQUEST_MSG` varchar(1024) NOT NULL COMMENT '请求内容',
   `RESPONSE_MSG` varchar(512) DEFAULT NULL COMMENT '响应内容',
   `REQUEST_NUMBER` int(2) DEFAULT NULL COMMENT '请求次数',
   `REQUEST_TIME` datetime NOT NULL COMMENT '请求时间',
   `RESPONSE_TIME` datetime DEFAULT NULL COMMENT '响应时间',
   `HANDLE_TIME` datetime DEFAULT NULL COMMENT '处理时间',
   `MSG_STATUS` int(1) NOT NULL COMMENT '消息状态（0已发送；1已接受；2已处理；）',
   `HANDLE_STATUS` int(4) DEFAULT NULL COMMENT '处理状态（200处理成功；100处理失败）',
   `HANDLE_RESULT` varchar(1024) DEFAULT NULL COMMENT '处理结果',
   `FLAG` varchar(8) NOT NULL DEFAULT 'ADD' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`,`CREATE_TIME`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动消息下发处理日志表';  
 
 
 /****
  * 更新活动表字段
  */
alter table app_activity add ACTIVITY_TOPIC_ID varchar(36) NOT NULL comment '活动主题ID' after CITY_CODE;  

alter table app_activity add ACTIVITY_CODE varchar(36) NOT NULL comment '活动代码' after ACTIVITY_URL;  

ALTER TABLE app_activity MODIFY `CITY_CODE` int(10) NULL;

ALTER TABLE app_activity MODIFY `ACTIVITY_URL` varchar(225) NULL;

ALTER TABLE app_activity MODIFY `UPDATED_BY` varchar(32) NULL;

ALTER TABLE app_activity MODIFY `UPDATE_TIME` datetime NULL;

/***
 * 更新支付方式折扣表字段
 */
ALTER TABLE app_activity_discount_conf MODIFY `CITY_CODE` int(10) NULL;

/***
 * 更新优惠券配置表字段
 */
ALTER TABLE app_activity_ticket_conf MODIFY `CITY_CODE` int(10) NULL;

alter table app_activity_ticket_conf add TICKET_VALIDITY int(4) NOT NULL comment '券有效期(单位：天)' after IS_OVERLY; 

alter table `app_activity_ticket_conf` drop column ticket_start_time;  /*未执行*/

alter table `app_activity_ticket_conf` drop column ticket_end_time; /*未执行*/


/***
 * 更新优惠券发放表字段
 */
alter table app_activity_ticket_putlog add PARKRECORD_ID varchar(16) DEFAULT NULL comment '来源停车记录' after USER_ID; 

alter table app_activity_ticket_putlog add ORDERNO varchar(32) DEFAULT NULL comment '来源订单编号' after PARKRECORD_ID; 

alter table app_activity_ticket_putlog add VALID_DATE date DEFAULT NULL COMMENT '停车券过期日期' after TICKET_NO; 

alter table app_activity_ticket_putlog add IS_OVERTIME int(1) DEFAULT '0' COMMENT '是否已过期（0：未过期；1已过期）' after IS_USED;

alter table app_activity_ticket_putlog alter column ENABLED set default '0'; 

alter table `app_activity_ticket_putlog` drop column ticket_type; /*未执行*/

alter table `app_activity_ticket_putlog` drop column ticket_money;/*未执行*/

alter table `app_activity_ticket_putlog` drop column discount;/*未执行*/

alter table `app_activity_ticket_putlog` drop column ticket_start_time;/*未执行*/

alter table `app_activity_ticket_putlog` drop column ticket_end_time;/*未执行*/



/***
 * 对外服务接口表添加字段
 */
ALTER TABLE app_external_conf ADD AUTH_PARK_TYPE INT(4) DEFAULT 0 COMMENT '停车点类型(0全部;1停车点;2停车场)' AFTER AUTH_TYPE;

/***
 * APP消息表添加字段
 */
ALTER TABLE app_message ADD user_id varchar(40) COMMENT 'PUSH_RANGE=100时，对应用户的ID' AFTER PUSH_RANGE;

/***
 * 用户订单投诉添加字段
 */
ALTER TABLE app_order_complain ADD refund_fee INT(10) DEFAULT 0 COMMENT '退款金额' AFTER REFUND_FLAG;


/***
 * 支付日志表添加字段
 */
ALTER TABLE	app_order_paylog ADD activity_id varchar(36) COMMENT '活动ID' AFTER ACTIVITY_TYPE;

ALTER TABLE	app_order_paylog ADD payment_discount INT(6) COMMENT '支付方式折扣比例' AFTER TICKET_DISCOUNT;

ALTER TABLE	app_order_paylog ADD is_paid varchar(10) DEFAULT 100 COMMENT '是否支付成功：100支付失败；200支付成功' AFTER PAY_FEE;

/***
 * APP退款表添加字段
 */
ALTER TABLE	app_order_refund ADD notify_status int(1) DEFAULT 0 NOT NULL COMMENT '通知状态（0：通知失败；1通知成功）' AFTER note;
/***
 *  停车点基础消息表添加字段
 */
ALTER TABLE	app_park ADD IS_INDOOR_PARK int(1);
/***
 *  定时任务添加字段
 */
ALTER TABLE	base_quartz ADD IF_START varchar(1) COMMENT '是否随系统启动(1是0否)' AFTER create_time;
ALTER TABLE	base_quartz ADD IP_LIMITED varchar(60) COMMENT '限制IP' AFTER IF_START;
 