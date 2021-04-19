-- 用户会员卡信息表 app_member_card

CREATE TABLE `app_member_card` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `USER_ID` varchar(36) NOT NULL COMMENT '归属用户ID',
   `USER_ACCOUNT` varchar(32) DEFAULT NULL COMMENT '用户账号',
   `AREA_CODE` int(10) NOT NULL COMMENT '区级代码',
   `MEMBER_CARD_NO` varchar(11) NOT NULL COMMENT '会员卡编码（3301+1594128 城市编码+手机号前三后四）',
   `BALANCE` int(10) NOT NULL DEFAULT '0' COMMENT '卡内余额',
   `PAY_PASSWORD` varchar(36) NOT NULL COMMENT '支付密码',
   `IS_NO_PWDPAY` int(1) NOT NULL DEFAULT '0' COMMENT '是否开启免密支付 1是0否',
   `STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '会员卡状态（0正常1锁定2注销）',
   `ERR_COUNT` int(1) DEFAULT '0' COMMENT '密码连续输错次数',
   `LAST_ERR_TIME` datetime DEFAULT NULL COMMENT '最近一次密码输错时间',
   `REFUND_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '退款状态（0未产生退款；1退款处理中；2处理完结）',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='用户会员卡信息表'
 
 -- 会员卡充值订单表 app_member_card_order
 
CREATE TABLE `app_member_card_order` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `CITY_CODE` int(10) NOT NULL COMMENT '城市代码',
   `AREA_CODE` int(10) NOT NULL COMMENT '区级代码',
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `USER_ACCOUNT` varchar(32) DEFAULT NULL COMMENT '用户账号',
   `ORDER_NO` varchar(64) NOT NULL COMMENT '充值订单编号(唯一)',
   `RECHARGE_CARD_NO` varchar(64) DEFAULT NULL COMMENT '充值卡编码',
   `BILL_NO` varchar(16) DEFAULT NULL COMMENT '招行订单编号',
   `PAY_TYPE` varchar(10) NOT NULL COMMENT '支付方式；1 支付宝 2 微信 5一网通 17 充值卡',
   `PRICE` int(8) DEFAULT '0' COMMENT '充值金额',
   `COUNTER_FEE` int(8) DEFAULT '0' COMMENT '手续费',
   `SUBJECT` varchar(64) DEFAULT NULL COMMENT '订单标题',
   `ORDER_BODY` varchar(128) DEFAULT NULL COMMENT '订单描述',
   `ORDER_STATUS` varchar(10) NOT NULL COMMENT '订单状态码(200支付成功;100未支付;400订单作废)',
   `PAY_TIME` datetime DEFAULT NULL COMMENT '支付时间',
   `BUYER_ACCOUNT` varchar(64) DEFAULT NULL COMMENT '买家账号',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='会员卡充值订单表'

 
-- 会员卡余额变动记录表 app_member_card_record

CREATE TABLE `app_member_card_record` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `HANDLE_TYPE` int(1) NOT NULL COMMENT '操作类型：1app充值；2充值卡充值；3后台充值;4积分兑换；5活动奖励；10停车缴费',
   `OBJ_ID` varchar(64) NOT NULL COMMENT '操作对象ID：1充值订单订单编号；2充值卡号；3；操作人账号；4积分变动记录ID；5活动ID；10交易订单订单编号',
   `PRICE` int(8) NOT NULL DEFAULT '0' COMMENT '本次操作金额',
   `BALANCE_BEFORE` int(8) DEFAULT NULL COMMENT '变动前余额',
   `BALANCE_AFTER` int(8) DEFAULT NULL COMMENT '变动后余额',
   `GIVE_AMOUNT` int(8) DEFAULT '0' COMMENT '赠送金额',
   `CHANGE_STATUS` varchar(8) NOT NULL COMMENT '变动状态：100未支付；200支付成功；400 订单作废；',
   `SUBJECT` varchar(64) NOT NULL COMMENT '标题',
   `HANDLE_BODY` varchar(64) NOT NULL COMMENT '操作描述',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='会员卡余额变动记录表'

 
-- 会员卡充值金额映射表 app_member_card_price_rel

CREATE TABLE `app_member_card_price_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `AREA_CODE` int(10) DEFAULT NULL COMMENT '区域代码',
   `RECHARGE_AMOUNT` int(10) NOT NULL COMMENT '充值金额',
   `PAY_AMOUNT` int(10) NOT NULL COMMENT '第三方支付金额',
   `IS_COMMON` int(1) NOT NULL COMMENT '是否通用 1是0否',
   `IS_DEFAULT` int(1) NOT NULL COMMENT '是否默认',
   `DISPLAY_NO` int(2) NOT NULL COMMENT '排序号',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`),
   UNIQUE KEY `INDEX_AREA_PAYAMOUNT` (`AREA_CODE`,`PAY_AMOUNT`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='会员卡充值金额映射表'

 
-- 会员卡自动支付映射表  app_memeber_card_autopay_rel

CREATE TABLE `app_member_card_autopay_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `MEMBER_CARD_NO` varchar(11) NOT NULL COMMENT '会员卡ID',
   `PLATE_ID` varchar(36) NOT NULL COMMENT '车牌ID',
   `IS_AUTO_PAY` int(1) NOT NULL COMMENT '是否开启自动支付；1是0否',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='会员卡自动支付映射表'


-- 会员充值卡表 app_memeber_recharge_card

CREATE TABLE `app_member_recharge_card` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `BATCH_ID` int(10) NOT NULL COMMENT '批次ID',
   `RECHARGE_CARD_NO` varchar(36) NOT NULL COMMENT '充值卡号',
   `PASSWORD` varchar(36) NOT NULL COMMENT '充值卡密码',
   `DENOMINATION` int(10) NOT NULL COMMENT '充值卡面额',
   `VALID_DATE` date NOT NULL COMMENT '到期时间',
   `IS_USED` int(1) DEFAULT '0' COMMENT '是否已使用（0：未使用；1已使用）',
   `IS_OVERTIME` int(1) DEFAULT '0' COMMENT '是否已过期（0：未过期；1已过期）',
   `IS_RECEVICE` int(1) DEFAULT '0' COMMENT '是否已领取（0：未领取；1已领取）',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='会员充值卡表'

-- 充值卡批次信息表 app_memeber_recharge_card_batch

CREATE TABLE `app_member_recharge_card_batch` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `BATCH_ID` int(10) NOT NULL COMMENT '批次号码',
   `DENOMINATION` int(10) NOT NULL COMMENT '充值卡面额',
   `PRODUCER` varchar(36) NOT NULL COMMENT '生成人',
   `PRODECE_TIME` datetime NOT NULL COMMENT '生成时间',
   `PRODECE_COUNT` int(10) NOT NULL COMMENT '生成张数',
   `IS_RECEVICE` int(1) DEFAULT '0' COMMENT '是否已领取（0：未领取；1已领取）',
   `RECEVICER` varchar(36) DEFAULT NULL COMMENT '领取人',
   `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '领取时间',
   `VALID_DATE` date NOT NULL COMMENT '到期时间',
   `IS_DOWNLOAD` int(1) DEFAULT '0' COMMENT '是否已下载；1是0否',
   `DOWNLOAD_URL` varchar(128) DEFAULT NULL COMMENT '文件下载地址',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   PRIMARY KEY (`ID`),
   UNIQUE KEY `INDEX_BATCH_ID` (`BATCH_ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='会员充值卡批次信息表'
 
 -- 区域表添加是否支持会员卡支付
 ALTER TABLE base_area ADD IS_MEMBER_CARD_PAY INT(1) DEFAULT '0' COMMENT '是否支持会员卡支付；1是0否' AFTER is_support_account;
 
 -- 全局参数表添加会员卡最大余额配置
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('3730aa59-34b9-11e7-9075-00ff484aeadc','MEMBER_CARD_ORDER_SUBJECT','中国好停车会员卡充值','会员卡充值标题','1','0','admin',NULL,'2017-05-09 21:12:56',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('708e6ab8-34b6-11e7-9075-00ff484aeadc','APP_RECHARGE_ORDER_BODY','用户%s于%s使用%s给会员卡%s充值%s元，实付%s元','App充值订单描述','1','0','admin',NULL,'2017-05-09 20:53:04',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('4d798ee8-34b6-11e7-9075-00ff484aeadc','MEMBR_RECHARGE_CARD_ORDER_BODY','用户%s于%s使用充值卡%s给会员卡%s充值%s元','充值卡订单描述','1','0','admin',NULL,'2017-05-09 20:52:05',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('c3fe252d-349e-11e7-9075-00ff484aeadc','MEMBER_CARD_MAX_BALANCE','100000','会员卡最大余额，单位（分）','1','0','admin',NULL,'2017-05-09 18:03:36',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('cca4d90d-3934-11e7-90cb-00ff484aeadc','MEMBER_CARD_RECHARGE_DESC','充值-%s充值','充值-余额变动记录描述','1','0','admin',NULL,'2017-05-15 14:07:39',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('cca4df9a-3934-11e7-90cb-00ff484aeadc','MEMBER_CARD_ORDER_DESC','停车缴费-%s','支付-会员卡余额变动记录描述','1','0','admin',NULL,'2017-05-15 14:07:39',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('c05e9a99-3eba-11e7-b9da-00ff484aeadc','MAX_ERR_COUNT_MEMBER_COUNT','3','会员卡密码最大输入次数','1','0','admin',NULL,'2017-05-22 14:49:07',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('4c6bf059-41e5-11e7-8416-00ff484aeadc','MEMBER_CARD_REFUND_FEE_DESC','退款','会员卡退款描述','1','0','admin',NULL,'2017-05-26 15:31:15',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('418da872-41e5-11e7-8416-00ff484aeadc','MEMBER_CARD_REFUND_FEE_SUBJECT','中国好停车会员卡退款','会员卡退款标题','1','0','admin',NULL,'2017-05-26 15:30:56',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('773d9e4f-466f-11e7-9564-00ff484aeadc','RECHARGE_MC_REMIND_CONTENT','尊敬的车主，您成功向中国“好停车”APP会员卡中充值%s元，充值赠送%s元停车费','会员卡充值提醒消息描述','1','0','admin',NULL,'2017-06-01 10:10:21',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('765b493a-466f-11e7-9564-00ff484aeadc','CREATE_MC_REMIND_CONTENT','尊敬的车主，恭喜您成功开通中国“好停车”APP会员卡','开通会员卡提醒消息描述','1','0','admin',NULL,'2017-06-01 10:10:19',NULL);
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('75082816-466f-11e7-9564-00ff484aeadc','MC_REFUND_REMIND_CONTENT','尊敬的车主，您的会员卡已经成功退款，详情请查看APP会员卡明细','会员卡退款提醒消息描述','1','0','admin',NULL,'2017-06-01 10:10:17',NULL);


-- 运营统计
ALTER TABLE app_stat_daily ADD MCPAY_SUCCESS_COUNT INT(8) DEFAULT '0' COMMENT '会员卡支付成功笔数' AFTER CMBPAY_COUNTER_AMOUNT;
ALTER TABLE app_stat_daily ADD MCPAY_SUCCESS_AMOUNT INT(8) DEFAULT '0' COMMENT '会员卡支付成功金额' AFTER MCPAY_SUCCESS_COUNT;

-- 数据字典
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('1d60d0e4-3fa5-11e7-9f00-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','10','停车缴费','余额变动记录操作类型','0','6','0','admin','','2017-05-23 18:46:45',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('06cd9d65-3fa5-11e7-9f00-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','5','活动奖励','余额变动记录操作类型','0','5','0','admin','','2017-05-23 18:46:08',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('f6da8ad4-3fa4-11e7-9f00-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','4','积分兑换','余额变动记录操作描述','0','4','0','admin','','2017-05-23 18:45:41',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('e7599d28-3fa4-11e7-9f00-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','3','后台充值','余额变动记录操作描述','0','3','0','admin','','2017-05-23 18:45:15',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('d56d7aa7-3fa4-11e7-9f00-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','2','充值卡充值','余额变动记录操作类型','0','2','0','admin','','2017-05-23 18:44:45',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('b0897060-3fa4-11e7-9f00-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','1','APP充值','余额变动记录操作类型','0','1','1','admin','','2017-05-23 18:43:43',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('34be7bcc-3f7b-11e7-9f00-00ff484aeadc','MEMBER_CARD_STATUS','2','注销','会员卡状态','0','3','0','admin','','2017-05-23 13:46:45',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('2c45453e-3f7b-11e7-9f00-00ff484aeadc','MEMBER_CARD_STATUS','1','锁定','会员卡状态','0','2','0','admin','','2017-05-23 13:46:31',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('2417116c-3f7b-11e7-9f00-00ff484aeadc','MEMBER_CARD_STATUS','0','正常','会员卡状态','0','1','1','admin','','2017-05-23 13:46:17',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('292ad904-3f5f-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','100000','￥1000','会员充值卡面额','0','7','0','admin','','2017-05-23 10:26:00',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('1c4de355-3f5f-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','50000','￥500','会员充值卡面额','0','6','0','admin','','2017-05-23 10:25:38',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('0bade964-3f5f-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','25000','￥250','会员充值卡面额','0','5','0','admin','','2017-05-23 10:25:10',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('fb608383-3f5e-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','20000','￥200','会员充值卡面额','0','4','0','admin','','2017-05-23 10:24:43',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('ee81117f-3f5e-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','15000','￥150','会员充值卡面额','0','3','0','admin','','2017-05-23 10:24:21',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('dcc10d22-3f5e-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','10000','￥100','会员充值卡面额','0','2','0','admin','','2017-05-23 10:23:52',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('c47f37ea-3f5e-11e7-947a-00ff484aeadc','MEMBER_REC_CARD_DENO','5000','￥50','会员充值卡面额','0','1','1','admin','','2017-05-23 10:23:11',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('fb543f8f-4120-11e7-9c36-00ff484aeadc','PAY_METHOD','17','充值卡','支付方式','0','8','0','admin','','2017-05-25 16:05:57',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('ff23c0a9-41c1-11e7-8416-00ff484aeadc','MC_PAYFEE','10000','￥100','第三方支付金额','0','4','0','admin','','2017-05-26 11:18:32',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('f4647cdf-41c1-11e7-8416-00ff484aeadc','MC_PAYFEE','5000','￥50','第三方支付金额','0','3','0','admin','','2017-05-26 11:18:14',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('e86c0ebf-41c1-11e7-8416-00ff484aeadc','MC_PAYFEE','3000','￥30','第三方支付金额','0','2','0','admin','','2017-05-26 11:17:54',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('dc16ff2d-41c1-11e7-8416-00ff484aeadc','MC_PAYFEE','2000','￥20','第三方支付金额','0','1','1','admin','','2017-05-26 11:17:33',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('ca32396d-41c1-11e7-8416-00ff484aeadc','MC_RECHARGEFEE','15000','￥150','实际充值金额','0','4','0','admin','','2017-05-26 11:17:03',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('b5fd3961-41c1-11e7-8416-00ff484aeadc','MC_RECHARGEFEE','6000','￥60','实际充值金额','0','3','0','admin','','2017-05-26 11:16:29',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('a6cf0ac7-41c1-11e7-8416-00ff484aeadc','MC_RECHARGEFEE','3800','￥38','实际充值金额','0','2','0','admin','','2017-05-26 11:16:04',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('945b70b9-41c1-11e7-8416-00ff484aeadc','MC_RECHARGEFEE','2500','￥25','实际充值金额','0','1','1','admin','','2017-05-26 11:15:33',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('b425e3a2-41df-11e7-8416-00ff484aeadc','MEMBER_CARD_HANDLE_TYPE','6','退款','余额变动记录操作类型','0','7','0','admin','','2017-05-26 14:51:12',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('74ed8140-41de-11e7-8416-00ff484aeadc','PAY_METHOD','6','会员卡支付','支付方式','0','9','0','admin','','2017-05-26 14:42:16',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('0f7302f7-45ab-11e7-9dca-00ff484aeadc','ORDER_REFUND_STATUS','2','需要退款','订单退款状态','0','2','0','admin','','2017-05-31 10:44:25',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('0358c590-45ab-11e7-9dca-00ff484aeadc','ORDER_REFUND_STATUS','1','无退款','订单退款状态','0','1','1','admin','','2017-05-31 10:44:05',NULL);
INSERT INTO `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) VALUES('e53da261-468e-11e7-9564-00ff484aeadc','MEMBER_CARD_REFUND_STATUS','0','无退款','会员卡退款状态','0','1','1','admin','','2017-06-01 13:55:20',NULL);
INSERT INTO `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) VALUES('b17e5315-42ba-11e7-9561-00ff484aeadc','MEMBER_CARD_REFUND_STATUS','2','退款完结','会员卡退款状态','0','3','0','admin','admin','2017-05-27 16:58:47','2017-06-01 13:55:48');
INSERT INTO `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) VALUES('a171146d-42ba-11e7-9561-00ff484aeadc','MEMBER_CARD_REFUND_STATUS','1','处理中','会员卡退款状态','0','2','0','admin','admin','2017-05-27 16:58:20','2017-06-01 13:55:40');

-- 更新会员充值卡存储过程（过期充值卡+会员卡解锁）
DELIMITER $$

USE `fragrans`$$

DROP PROCEDURE IF EXISTS `p_update_mrc_status`$$

CREATE DEFINER=`fragrans`@`%` PROCEDURE `p_update_mrc_status`()
    SQL SECURITY INVOKER
BEGIN
	-- 过期到期的会员充值卡
	UPDATE app_member_recharge_card 
	SET IS_OVERTIME = 1,FLAG = 'UPDATE',UPDATED_BY = 'system',UPDATE_TIME = NOW() 
	WHERE FLAG != 'DELETE' AND IS_USED = 0 AND IS_OVERTIME = 0 
	  AND DATE_FORMAT(NOW(),'%Y-%m-%d') > valid_date;
		
	COMMIT;
	
	-- 解锁锁定会员卡
	UPDATE app_member_card
	SET STATUS = 0,ERR_COUNT = 0,FLAG = 'UPDATE',UPDATED_BY = 'system',UPDATE_TIME = NOW()
	WHERE FLAG != 'DELETE' AND STATUS = 1;
	
	COMMIT;
	
    END$$

DELIMITER ;

-- 更新会员充值卡定时任务
DELIMITER $$

ALTER DEFINER=`fragrans`@`%` EVENT `event_update_mrc_status` ON SCHEDULE EVERY 1 DAY STARTS '2017-01-10 00:00:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
	     CALL p_update_mrc_status();
	END$$

DELIMITER ;

