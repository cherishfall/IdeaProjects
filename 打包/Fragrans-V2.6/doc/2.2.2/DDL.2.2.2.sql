CREATE TABLE `app_push_task` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `TITLE` varchar(64) NOT NULL COMMENT '消息标题',
   `CONTENT` varchar(512) NOT NULL COMMENT '消息内容',
   `MESSAGE_TYPE` int(4) DEFAULT NULL COMMENT '1个人消息；2缴费通知；3活动推送',
   `TEMPLET_TYPE` int(1) DEFAULT NULL COMMENT '模板类型（1.NotificationTemplate 2.LinkTemplate 3.TransmissionTemplate）',
   `PUSH_RANGE` int(1) NOT NULL COMMENT '推送类型(1.按个人 2.按区域 3.按未注册 4.按appId)',
   `PUSH_CLIENT_TYPE` int(1) DEFAULT '0' COMMENT '推送对象类型(0.全部 1.android 2.ios）',
   `OBJ_ID` varchar(380) DEFAULT NULL COMMENT '对象ID',
   `PUSH_TYPE` int(1) NOT NULL COMMENT '下发类型（1.定时 2.立刻）',
   `PUSH_TIME` datetime DEFAULT NULL COMMENT '下发时间',
   `IS_VOICE` int(1) DEFAULT '0' COMMENT '是否开启声音',
   `IS_SHOCK` int(1) DEFAULT '0' COMMENT '是否开启振动',
   `IS_DISPLAY` int(1) DEFAULT '0' COMMENT '是否显示提示',
   `IS_CLEAR` int(1) DEFAULT '0' COMMENT '是否可清除',
   `IS_OPEN` int(1) DEFAULT '0' COMMENT '是否启动应用',
   `LINK_URL` varchar(128) DEFAULT NULL COMMENT '链接地址',
   `EXE_STATUS` int(2) DEFAULT '0' COMMENT '任务执行状态(0未执行；2执行中；4执行失败；5已执行)',
   `EXE_RESULT` varchar(225) DEFAULT NULL COMMENT '任务执行结果描述',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8

CREATE TABLE `app_push_task_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `TASK_ID` varchar(36) NOT NULL COMMENT '任务ID',
   `USER_ID` varchar(36) DEFAULT NULL COMMENT '接收用户ID',
   `CLIENT_ID` varchar(64) NOT NULL COMMENT '客户端id',
   `DEVICE_TYPE` int(1) DEFAULT NULL COMMENT '设备类型 1、Android ; 2、IOS',
   `SEND_TIME` datetime DEFAULT NULL COMMENT '发送时间',
   `IS_READ` int(1) DEFAULT '0' COMMENT '是否已读（0.未读 1.已读)',
   `PUSH_STATUS` int(2) DEFAULT '0' COMMENT 'PUSH状态（0未发送；1发送中；4发送失败；5发送完成）',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8

 /**app_stat_daily缺少6个字段*/
alter table app_stat_daily add TICKETPAY_SUCCESS_COUNT int(8) default 0 comment '停车券支付笔数' after WXPAY_SUCCESS_AMOUNT;

alter table app_stat_daily add TICKET_ALLPAY_SUCCESS_COUNT int(8) default 0 comment '停车券全额支付笔数' after TICKETPAY_SUCCESS_COUNT;

alter table app_stat_daily add TICKETPAY_SUCCESS_AMOUNT int(8) default 0 comment '停车券抵扣金额' after TICKET_ALLPAY_SUCCESS_COUNT;

alter table app_stat_daily add PAY_USER_COUNT int(8) default 0 comment '支付用户数' after TICKETPAY_SUCCESS_AMOUNT;

alter table app_stat_daily add PAY_SUCCESS_USER_COUNT int(8) default 0 comment '成功支付用户数' after PAY_USER_COUNT;

alter table app_stat_daily add TICKETPAY_SUCCESS_USER_COUNT int(8) default 0 comment '停车券支付用户数' after PAY_SUCCESS_USER_COUNT;

CREATE TABLE `app_stat_user_daily` (
   `ID` varchar(36) NOT NULL COMMENT 'ID',
   `DAY_TIME` date DEFAULT NULL COMMENT '日期',
   `CITY_CODE` int(8) DEFAULT NULL COMMENT '城市编码',
   `AREA_CODE` int(8) DEFAULT NULL COMMENT '区域编码',
   `REG_USER_COUNT` int(8) DEFAULT '0' COMMENT '注册用户数',
   `REG_USER_PAY_COUNT` int(8) DEFAULT '0' COMMENT '注册有缴费用户数',
   `ACTIVE_USER_COUNT` int(8) DEFAULT '0' COMMENT '活跃用户数',
   `ACTIVE_DEVICE_COUNT` int(8) DEFAULT '0' COMMENT '活跃设备数',
   `NEW_DEVICE_COUNT` int(8) DEFAULT '0' COMMENT '新增设备数',
   `USER_PAY_COUNT` int(8) DEFAULT '0' COMMENT '缴费用户数',
   `ACTIVITY_USER_COUNT` int(8) DEFAULT '0' COMMENT '参与活动用户数',
   `REG_USER_MONTH_COUNT` int(8) DEFAULT '0' COMMENT '本月累计注册用户',
   `GROWTH` float DEFAULT '0' COMMENT '同比增长',
   `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户统计报表'

 /**base_user新增PWDSTRONG字段：*/
alter table base_user add PWDSTRONG int(1) default 1 comment '密码强度，取值范围1-4；4表示最强' after NOTE;

CREATE TABLE `fanc_order_balance` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `stat_date` date NOT NULL COMMENT '账单日期(YYYY-MM-DD)',
   `city_code` int(10) DEFAULT NULL COMMENT '城市代码',
   `area_code` int(10) DEFAULT NULL COMMENT '区级代码',
   `order_no` varchar(64) DEFAULT NULL COMMENT '交易订单编号',
   `park_id` varchar(64) DEFAULT NULL COMMENT '停车点ID',
   `parkrecord_id` varchar(64) DEFAULT NULL COMMENT '停车记录id',
   `plate_no` varchar(32) DEFAULT NULL COMMENT '车牌号码',
   `pay_type` varchar(10) DEFAULT NULL COMMENT '支付方式：1支付宝支付；2微信APP支付；3微信公众号支付；4余额支付；',
   `order_type` varchar(10) DEFAULT NULL COMMENT '订单类型：1停车订单；2退费订单',
   `price` int(8) DEFAULT '0' COMMENT '支付金额',
   `refund_no` varchar(36) DEFAULT NULL COMMENT '退款编码',
   `refund_fee` int(8) DEFAULT '0' COMMENT '退款费用',
   `berth_code` varchar(25) DEFAULT NULL COMMENT '泊位编号',
   `park_name` varchar(64) DEFAULT NULL COMMENT '停车点名称',
   `park_durations` varchar(64) DEFAULT NULL COMMENT '停车时长',
   `arrive_time` datetime DEFAULT NULL COMMENT '驶入时间',
   `departure_time` datetime DEFAULT NULL COMMENT '驶离时间',
   `park_type` int(1) DEFAULT NULL COMMENT '停车点类型,1:停车点 2:停车场',
   `SUBJECT` varchar(64) DEFAULT NULL COMMENT '订单标题',
   `order_body` varchar(64) DEFAULT NULL COMMENT '订单描述',
   `is_balance` int(1) DEFAULT NULL COMMENT '账单是否平账:0-平账；1-异常账单',
   `exception_type` int(1) DEFAULT NULL COMMENT '异常类型：1.第三方不存在；2.spms不存在；3.金额不对等；4.平账',
   `exception_desc` varchar(400) DEFAULT NULL COMMENT '异常描述',
   `is_white` int(1) DEFAULT NULL COMMENT '是否在白名单里',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='第三方平账与spms平账匹配'

/**fanc_order_spms新增is_white字段*/
alter table fanc_order_spms add is_white int(1) comment '是否在白名单里' after error_desc;

CREATE TABLE `fanc_order_white_list` (
   `id` varchar(36) NOT NULL COMMENT '主键ID',
   `white_type` int(1) NOT NULL COMMENT '白名单类型',
   `white_value` varchar(64) NOT NULL COMMENT '白名单值',
   `is_enabled` int(1) DEFAULT NULL COMMENT '是否有效：0.有效；1.无效',
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='账单白名单表'
