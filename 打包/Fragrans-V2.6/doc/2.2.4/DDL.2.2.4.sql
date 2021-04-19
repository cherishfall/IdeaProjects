CREATE TABLE `app_activity_mark` (
   `ID` varchar(36) NOT NULL COMMENT '主键id',
   `ACTIVITY_ID` varchar(36) NOT NULL COMMENT '活动id',
   `MARK` varchar(8) NOT NULL COMMENT '活动标识',
   `ACTIVITY_TYPE` int(4) NOT NULL COMMENT '活动类型，1：指定随机；2：指定定额',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   `day_getcount` int(4) DEFAULT '1' COMMENT '每个用户每日最多领取张数',
   `all_getcount` int(6) DEFAULT '1' COMMENT '每个用户总共可领取张数',
   PRIMARY KEY (`ID`,`ACTIVITY_ID`,`MARK`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动标识表';

CREATE TABLE `app_area_config` (
   `ID` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
   `AREA_CODE` int(10) NOT NULL COMMENT '区域编码',
   `PARA_NAME` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '参数关键字',
   `PARA_VALUE` varchar(512) COLLATE utf8_unicode_ci NOT NULL COMMENT '参数值',
   `PARA_TYPE` int(1) NOT NULL DEFAULT '0' COMMENT '是否通用（1通用；0不通用）',
   `PARA_DESC` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '参数描述',
   `STATE` int(1) NOT NULL DEFAULT '0' COMMENT '参数状态（1.停用；0.正常）',
   `CREATED_BY` varchar(36) COLLATE utf8_unicode_ci NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) COLLATE utf8_unicode_ci DEFAULT '' COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='APP区域参数配置表';

--app_message表增加的字段
ALTER TABLE app_message ADD MESSAGE_REMARK VARCHAR(1024) COMMENT '消息摘要' AFTER MESSAGE_NAME;
ALTER TABLE app_message ADD MESSAGE_IMAGE VARCHAR(128) COMMENT '消息列表图片地址' AFTER MESSAGE_REMARK;
ALTER TABLE app_message ADD MESSAGE_URL VARCHAR(128) COMMENT '消息跳转h5页面地址（配置了连接地址必须支持点击，点击跳转跳转到目标地址，不会打开消息详细）' AFTER MESSAGE_IMAGE;
ALTER TABLE app_message ADD ISCLICK INT(1) NOT NULL COMMENT '是否可点击（1是0否；不可点击的消息，消息摘要不可空，消息内容可空）' AFTER MESSAGE_URL;

--app_order表增加的字段
ALTER TABLE app_order ADD BILL_NO VARCHAR(16) COMMENT '招行订单编号' AFTER ORDER_NO;
ALTER TABLE app_order ADD EXTERNAL_NO VARCHAR(36) COMMENT '对外订单编号；旋极对接返回' AFTER BILL_NO;

--修改app_stat_activity_effect表字段名
ALTER TABLE app_stat_activity_effect CHANGE CUMULATIV_UNUSED_USER_COUNT UNUSED_USER_COUNT INT(8);
ALTER TABLE app_stat_activity_effect CHANGE CUMULATIVE_PARTICIPATE_USER_COUNT PART_USER_COUNT INT(8);
ALTER TABLE app_stat_activity_effect CHANGE CUMULATIVE_PAYFEE_ORDER_COUNT PAYFEE_ORDER_COUNT INT(8);
ALTER TABLE app_stat_activity_effect CHANGE TICKETPAY_USER_COUNT TP_USER_COUNT INT(8);
ALTER TABLE app_stat_activity_effect CHANGE ACTUAL_DISCOUNT_AMOUNT ACT_DISCOUNT_AMOUNT INT(8);

--修改app_stat_daily表字段名
ALTER TABLE app_stat_daily CHANGE TICKETPAY_SUCCESS_USER_COUNT TICKET_SUCCESS_USER_COUNT INT(8);

--app_user_ext表增加的字段
ALTER TABLE app_user_ext ADD PAY_PASSWORD VARCHAR(64) COMMENT '钱包支付密码' AFTER USER_ID;

--app_user_pay_account表增加的字段
ALTER TABLE app_user_pay_account ADD BANK_NAME VARCHAR(32) COMMENT '绑定银行卡名称' AFTER PAY_ACCOUNT_TYPE;
ALTER TABLE app_user_pay_account ADD BANK_CARD VARCHAR(32) COMMENT '银行卡号' AFTER BANK_NAME;

CREATE TABLE `app_user_use_path` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `USER_ID` varchar(36) DEFAULT NULL COMMENT '用户ID',
   `PROCESS_ID` varchar(36) NOT NULL COMMENT '流程ID,标识一次app操作,一次操作内流程ID相同',
   `HANDLE_ID` varchar(16) NOT NULL COMMENT '操作ID,即页面/按钮 ID',
   `ARRIVE_TIME` datetime NOT NULL COMMENT '进入时间',
   `DEPARTURE_TIME` datetime NOT NULL COMMENT '离开时间',
   `STAY_TIME` int(64) NOT NULL DEFAULT '0' COMMENT '停留时长，单位秒',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='app用户操作路径表';

CREATE TABLE `app_user_use_path_conf` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `HANDLE_ID` varchar(16) NOT NULL COMMENT '操作ID,即页面/按钮 ID',
   `HANDLE_NAME` varchar(32) NOT NULL COMMENT '操作名称',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`,`HANDLE_ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='app用户操作路径配置表';

 CREATE TABLE `app_wallet_balance_change` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `ORDER_NO` varchar(64) NOT NULL COMMENT '订单编号(唯一)',
   `HANDLE_TYPE` int(1) NOT NULL COMMENT '操作类型：1充值；2消费；3退款',
   `PRICE` int(8) NOT NULL DEFAULT '0' COMMENT '本次操作金额',
   `BALANCE_BEFORE` int(8) NOT NULL DEFAULT '0' COMMENT '变动前余额',
   `BALANCE_AFTER` int(8) NOT NULL DEFAULT '0' COMMENT '变动后余额',
   `CHANGE_STATUS` varchar(8) NOT NULL COMMENT '变动状态：100未支付；200支付成功；400 订单作废；500支付失败',
   `SUBJECT` varchar(64) NOT NULL COMMENT '标题',
   `HANDLE_BODY` varchar(64) NOT NULL COMMENT '操作描述',
   `CREATE_TIME` datetime NOT NULL COMMENT '记录创建时间',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '记录修改时间',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   PRIMARY KEY (`ID`),
   UNIQUE KEY `idx_app_change_on` (`ORDER_NO`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='APP钱包余额变动表';

CREATE TABLE `app_wallet_recharge` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `CITY_CODE` int(10) DEFAULT NULL COMMENT '城市代码',
   `AREA_CODE` int(10) DEFAULT NULL COMMENT '区级代码',
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `USER_ACCOUNT` varchar(32) DEFAULT NULL COMMENT '用户账号',
   `RECHARGE_NO` varchar(64) NOT NULL COMMENT '充值订单编号(唯一)',
   `BILL_NO` varchar(16) DEFAULT NULL COMMENT '招行订单编号',
   `PAY_TYPE` varchar(10) NOT NULL COMMENT '支付方式(1支付宝 2微信APP支付 3微信公众号支付 4余额退款 5招行一网通支付)',
   `PRICE` int(8) NOT NULL DEFAULT '0' COMMENT '充值金额',
   `BALANCE_HIS` int(8) NOT NULL DEFAULT '0' COMMENT '充值前账户余额',
   `BALANCE` int(8) NOT NULL DEFAULT '0' COMMENT '当前账户余额',
   `ORDER_STATUS` varchar(10) NOT NULL COMMENT '充值订单状态码(100未支付；200支付成功；400 订单作废；500支付失败)',
   `ORDER_TIME` datetime NOT NULL COMMENT '订单时间',
   `PAY_TIME` datetime DEFAULT NULL COMMENT '支付时间',
   `BUYER_ACCOUNT` varchar(64) DEFAULT NULL COMMENT '买家账号',
   `NOTIFY_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '通知状态(0：未通知后台或通知未返回成功，1：通知成功返回)',
   `NOTIFY_TIME` varchar(32) DEFAULT NULL COMMENT '最后一次通知时间',
   `CREATE_TIME` datetime NOT NULL COMMENT '记录创建时间',
   PRIMARY KEY (`ID`),
   UNIQUE KEY `idx_app_recharge_on` (`RECHARGE_NO`),
   KEY `idx_CITY_CODE` (`CITY_CODE`),
   KEY `idx_ORDER_STATUS` (`ORDER_STATUS`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='APP钱包充值记录表';

 
