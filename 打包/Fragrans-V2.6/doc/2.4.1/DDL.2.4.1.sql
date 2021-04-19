ALTER TABLE app_activity_ticket_conf ADD USE_RANGE INT(1) DEFAULT 3 COMMENT '使用范围：1停车点;2停车场;3全部' AFTER ALL_PUTCOUNT;

ALTER TABLE app_activity_topic ADD ORDER_NUM INT(2) DEFAULT 0 COMMENT '活动主题排序' AFTER TOPIC_URL;

ALTER TABLE app_key ADD IS_SUPER INT(1) DEFAULT 1 COMMENT '是否超级权限：1是0否' AFTER APP_DESC;

ALTER TABLE app_message ADD MESSAGE_TOPIC_ID VARCHAR(36) COMMENT '消息分类id' AFTER id;

CREATE TABLE `app_message_topic` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID 分类编号',
   `MESSAGE_TOPIC_NAME` varchar(64) NOT NULL COMMENT '消息分类名称',
   `MESSAGE_TOPIC_DESC` varchar(225) DEFAULT NULL COMMENT '消息分类摘要',
   `TOPIC_TYPE` varchar(16) NOT NULL COMMENT '消息分类类型(1、系统消息 2、活动消息 3、个人消息 4、便民信息)',
   `DISPLAYCONF` int(1) NOT NULL DEFAULT '2' COMMENT '显示策略（1在app上显示 2 不显示）',
   `IS_COMMON` int(1) NOT NULL DEFAULT '1' COMMENT '是否通用（0否 1 是）',
   `ORDER_NUM` int(2) DEFAULT '0' COMMENT '排序号',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='消息分类信息表';
 
 CREATE TABLE `app_parklot_record` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID:',
   `CITY_CODE` int(10) NOT NULL COMMENT '城市代码',
   `PARKRECORD_ID` varchar(64) NOT NULL COMMENT '停车记录ID',
   `SERIES_NUMBER` varchar(64) NOT NULL COMMENT '序列号',
   `PARK_ID` varchar(36) NOT NULL COMMENT '停车点ID',
   `PARK_NAME` varchar(255) DEFAULT NULL COMMENT '停车点名称',
   `PLATE_NO` varchar(20) NOT NULL COMMENT '车牌号',
   `PLATE_COLOR` int(1) NOT NULL COMMENT '车牌颜色',
   `ARRIVAL_TIME` datetime NOT NULL COMMENT '驶入时间',
   `DEPARTURE_TIME` datetime DEFAULT NULL COMMENT '驶离时间',
   `IS_PUSH` int(1) NOT NULL COMMENT '是否执行发券：0否；1是',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间,默认SYSDATE',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
   `FLAG` varchar(16) NOT NULL COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='停车场停车记录表';