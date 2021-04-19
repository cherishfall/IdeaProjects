CREATE TABLE `rent_park_space_eval` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `BERTH_ID` varchar(36) NOT NULL COMMENT '泊位ID，车位信息ID',
  `TYPE` int(2) NOT NULL COMMENT '评价类型（1车位出租；2其他）',
  `EVAL_USER_ID` varchar(36) NOT NULL COMMENT '评价人ID',
  `EVAL_USER_ACOUNT` varchar(36) DEFAULT NULL COMMENT '评价人账号',
  `EVAL_CONTENT` varchar(1024) DEFAULT NULL COMMENT '评价内容',
  `EVAL_TIME` datetime NOT NULL COMMENT '评价时间',
  `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='出租车位评价表';

CREATE TABLE `rent_park_space_info` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
  `AREA_CODE` int(10) NOT NULL COMMENT '区域编码',
  `AREA_NAME` varchar(64) DEFAULT NULL COMMENT '区域名称',
  `NAME` varchar(64) NOT NULL COMMENT '车位名称',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '车位地址',
  `MAP_ADDRESS` varchar(255) NOT NULL COMMENT '地图地址',
  `LONGITUDE_GAODE` decimal(10,6) NOT NULL COMMENT '经度(高德)',
  `LATITUDE_GAODE` decimal(10,6) NOT NULL COMMENT '纬度(高德)',
  `IMG_URL` varchar(1024) DEFAULT NULL COMMENT '图片URL',
  `COUNT` int(10) NOT NULL DEFAULT '1' COMMENT '车位数量',
  `PHONE` varchar(50) NOT NULL COMMENT '联系电话',
  `START_DATE` date NOT NULL COMMENT '起租日期',
  `TYPE` int(2) NOT NULL COMMENT '车位类型（1地面，2地上，3其他）',
  `STATUS` int(2) NOT NULL DEFAULT '1' COMMENT '车位状态(0审核不通过；1审核中；2正常；3已取消；4已出租）',
  `IS_PARK_CART` int(1) NOT NULL COMMENT '是否允许停放大车（1是；0否）',
  `IS_RELE_CERT` int(1) NOT NULL COMMENT '是否需要放行证明（1是；0否）',
  `EVAL_NUM` int(10) NOT NULL DEFAULT '0' COMMENT '评价数',
  `REMARK` varchar(1024) DEFAULT NULL COMMENT '备注',
  `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
  `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='出租车位信息表';

CREATE TABLE `rent_park_space_price` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `BERTH_ID` varchar(36) DEFAULT NULL COMMENT '泊位ID，车位信息ID',
  `USER_ID` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `NAME` varchar(255) NOT NULL COMMENT '计费名称（如：每天）',
  `TIME_INTERVAL` varchar(255) NOT NULL COMMENT '计费时段（如：8:00 - 20:00）',
  `PRICE` varchar(255) NOT NULL COMMENT '价格(如：每天10元)',
  `REMARK` varchar(1024) DEFAULT NULL COMMENT '备注(如：周六，周日除外，节假日除外)',
  `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
  `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='出租车位计费表';

CREATE TABLE `rent_park_space_review` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `BERTH_ID` varchar(36) DEFAULT NULL COMMENT '泊位ID，车位信息ID',
  `USER_ID` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `REVIEWER` varchar(36) NOT NULL COMMENT '审核人',
  `REVIEW_TIME` datetime NOT NULL COMMENT '审核时间',
  `REVIEW_RESULT` varchar(1024) DEFAULT NULL COMMENT '审核意见',
  `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='出租车位审核表';

-- app_park添加两个字段
ALTER TABLE app_park ADD IS_ALI_PARK INT(1) DEFAULT 0 COMMENT '是否支付宝认证停车点；1是0否' AFTER SOURCE_IP;
ALTER TABLE app_park ADD ALI_PARK_ID VARCHAR(255) COMMENT '支付宝停车点ID' AFTER IS_ALI_PARK;

insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('c31d4c83-5b23-11e7-9471-54ee756108e5','PARKSPACE_STATUS','4','已出租','共享车位状态','0','4','0','admin','','2017-06-27 18:31:24',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('b919350f-5b23-11e7-9471-54ee756108e5','PARKSPACE_STATUS','3','已取消','共享车位状态','0','3','0','admin','','2017-06-27 18:31:07',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('ab218b33-5b23-11e7-9471-54ee756108e5','PARKSPACE_STATUS','2','正常','共享车位状态','0','2','0','admin','','2017-06-27 18:30:44',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('a02af6b0-5b23-11e7-9471-54ee756108e5','PARKSPACE_STATUS','1','审核中','共享车位状态','0','1','1','admin','','2017-06-27 18:30:25',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('8e3ceb99-5b23-11e7-9471-54ee756108e5','PARKSPACE_STATUS','0','审核不通过','共享车位状态','0','1','0','admin','','2017-06-27 18:29:55',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('0eb3b6c3-5b23-11e7-9471-54ee756108e5','PARKSPACE_TYPE','3','其他','共享车位类型','0','2','0','admin','admin','2017-06-27 18:26:21','2017-06-27 18:27:12');
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('00be998f-5b23-11e7-9471-54ee756108e5','PARKSPACE_TYPE','2','地下','共享车位类型','0','1','0','admin','','2017-06-27 18:25:58',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('edb9cfd7-5b1f-11e7-9471-54ee756108e5','PARKSPACE_TYPE','1','地面','共享车位类型','0','0','1','admin','','2017-06-27 18:03:57',NULL);

