-- 添加数据库表

CREATE TABLE `app_order_park_monthly` (
  `ID` VARCHAR(36) NOT NULL COMMENT '主键ID',
  `MONTHLY_RECORD_ID` VARCHAR(36) NOT NULL COMMENT '包月记录ID',
  `USER_ID` VARCHAR(36) NOT NULL COMMENT '用户ID',
  `USER_ACCOUNT` VARCHAR(32) DEFAULT NULL COMMENT '用户账号',
  `ORDER_NO` VARCHAR(64) DEFAULT NULL COMMENT '交易订单编号(唯一)',
  `BILL_NO` VARCHAR(16) DEFAULT NULL COMMENT '招行订单编号',
  `PRICE` INT(8) DEFAULT '0' COMMENT '订单金额',
  `PAYMENT` INT(2) NOT NULL COMMENT '支付方式(1支付宝，2微信APP支付，5招行一网通支付)',
  `PLATE_NO` VARCHAR(20) DEFAULT NULL COMMENT '车牌号',
  `SUBJECT` VARCHAR(64) DEFAULT NULL COMMENT '订单标题',
  `ORDER_BODY` VARCHAR(64) DEFAULT NULL COMMENT '订单描述',
  `ORDER_STATUS` VARCHAR(10) DEFAULT NULL COMMENT '订单状态码(100未支付;200支付成功;400订单作废)',
  `PAY_TIME` DATETIME DEFAULT NULL COMMENT '支付时间',
  `BUYER_ACCOUNT` VARCHAR(64) DEFAULT NULL COMMENT '买家账号',
  `COUNTER_FEE` INT(8) DEFAULT NULL COMMENT '手续费',
  `NOTIFY_STATUS` INT(1) DEFAULT '0' COMMENT '通知状态(0：未通知后台或通知未返回成功，1：通知成功返回)',
  `NOTIFY_TIME` VARCHAR(32) DEFAULT NULL COMMENT '最后一次通知时间',
  `CREATED_BY` VARCHAR(36) NOT NULL COMMENT '创建人',
  `UPDATED_BY` VARCHAR(36) DEFAULT NULL COMMENT '修改人',
  `CREATE_TIME` DATETIME NOT NULL COMMENT '创建时间',
  `UPDATE_TIME` DATETIME DEFAULT NULL COMMENT '更新时间',
  `CITY_CODE` INT(10) DEFAULT NULL COMMENT '城市代码',
  `AREA_CODE` INT(10) DEFAULT NULL COMMENT '区级代码',
  PRIMARY KEY (`ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='包月订单表';

/*Table structure for table `app_park_monthly_record` */

 
CREATE TABLE `app_park_monthly_record` (
  `ID` VARCHAR(36) NOT NULL COMMENT '主键ID',
  `AREA_CODE` INT(10) NOT NULL COMMENT '区域编码',
  `AREA_NAME` VARCHAR(64) NOT NULL COMMENT '区域名称',
  `MONTHLY_CAR_ID` INT(36) NOT NULL COMMENT '包月车辆ID',
  `PARNET_ID` INT(36) NOT NULL DEFAULT '0' COMMENT '父级ID，即续包月记录ID',
  `MONTHLY_ID` INT(36) DEFAULT NULL COMMENT '后台包月记录ID',
  `PLATE_NO` VARCHAR(20) DEFAULT NULL COMMENT '车牌号',
  `PLATE_COLOR` INT(1) DEFAULT '0' COMMENT '车牌颜色；蓝0，黄1，白2，黑3',
  `PHONE` VARCHAR(36) DEFAULT NULL COMMENT '包月手机号',
  `PARK_NAME` VARCHAR(1024) DEFAULT NULL COMMENT '包月停车点集合（逗号分隔）',
  `MONTHLY_FEE` INT(8) DEFAULT NULL COMMENT '包月费用',
  `START_TIME` DATETIME DEFAULT NULL COMMENT '包月开始时间',
  `END_TIME` DATETIME DEFAULT NULL COMMENT '包月结束时间',
  `STATUS` INT(2) DEFAULT NULL COMMENT '包月状态（1正常，2续包受理中，3已过期，4已作废,5未生效）',
  `IS_PUSH` INT(1) DEFAULT '0' COMMENT '推送提醒状态(1已推送；0未推送)',
  `NOTE` VARCHAR(500) DEFAULT NULL COMMENT '描述（可填具体包月信息，如车牌号，颜色，街道，包月开始结束时间，包月费用等）',
  `FLAG` VARCHAR(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
  `CREATED_BY` VARCHAR(36) NOT NULL COMMENT '创建人',
  `UPDATED_BY` VARCHAR(36) DEFAULT NULL COMMENT '修改人',
  `CREATE_TIME` DATETIME NOT NULL COMMENT '创建时间',
  `UPDATE_TIME` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `INDEX_MONTHLY_ID` (`MONTHLY_ID`,`AREA_CODE`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='包月记录表';

-- 唯一索引
ALTER TABLE app_park_monthly_record add UNIQUE KEY `INDEX_MONTHLY_ID` (`MONTHLY_ID`,`AREA_CODE`);

/*Table structure for table `app_park_monthly_record_log` */
 

CREATE TABLE `app_park_monthly_record_log` (
  `ID` VARCHAR(36) NOT NULL COMMENT '主键ID',
  `MONTHLY_RECORD_ID` VARCHAR(36) NOT NULL COMMENT '包月记录ID',
  `USER_ID` VARCHAR(36) NOT NULL COMMENT '用户ID',
  `START_TIME` DATETIME DEFAULT NULL COMMENT '包月开始时间',
  `END_TIME` DATETIME DEFAULT NULL COMMENT '包月结束时间',
  `MONTHLY_FEE` INT(8) DEFAULT NULL COMMENT '包月费用',
  `ACCEPT_TIME` DATETIME DEFAULT NULL COMMENT '受理时间',
  `ACCEPT_USER` VARCHAR(64) DEFAULT NULL COMMENT '受理人',
  `VERIFY_USER` VARCHAR(64) DEFAULT NULL COMMENT '审核人',
  `VERIFY_TIME` DATETIME DEFAULT NULL COMMENT '审核时间',
  `VERIFY_STATUS` INT(2) DEFAULT NULL COMMENT '审核状态（0未受理，1受理中，2通过，3不通过）',
  `VERIFY_INFO` VARCHAR(200) DEFAULT NULL COMMENT '审核意见，审核状态不通过非空',
  `ADVICE_START_TIME` DATETIME DEFAULT NULL COMMENT '建议开始时间',
  `ADVICE_MONTHLY_DURATION` INT(4) DEFAULT NULL COMMENT '建议包月时长',
  `FLAG` VARCHAR(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
  `CREATED_BY` VARCHAR(36) NOT NULL COMMENT '创建人',
  `UPDATED_BY` VARCHAR(36) DEFAULT NULL COMMENT '修改人',
  `CREATE_TIME` DATETIME NOT NULL COMMENT '创建时间',
  `UPDATE_TIME` DATETIME DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='包月日志表';

	-- 添加字段
	 ALTER TABLE base_area ADD COLUMN IS_DELETE_PARKRECORD INT(2) DEFAULT 0  COMMENT '是否支持删除停车记录' AFTER IS_BATCHPAY;
	 ALTER TABLE base_area ADD COLUMN CITY_SPELL VARCHAR(32) DEFAULT NULL  COMMENT '城市中文拼音' AFTER IS_DELETE_PARKRECORD;
	 ALTER TABLE app_prebuy_parkrecord ADD COLUMN PHOTO_SCORE INT(4) DEFAULT -1 COMMENT '照片评分' AFTER PHOTO_URL;
	 ALTER TABLE app_user_car ADD COLUMN IS_IDENTIFY INT(1) DEFAULT 0 COMMENT '是否认证车牌（0否；1是；默认0）' AFTER UPDATE_TIME;

	-- 更新包月记录状态存储过程
	DELIMITER $$
	
	USE `fragrans`$$
	
	DROP PROCEDURE IF EXISTS `p_reset_monthly_record_status`$$
	
	CREATE DEFINER=`fragrans`@`%` PROCEDURE `p_reset_monthly_record_status`(
	)
	    SQL SECURITY INVOKER
	BEGIN
		-- 作废今天到期且正在审核中的包月记录
		UPDATE app_park_monthly_record SET STATUS = 4,flag = 'DELETE'
		WHERE flag != 'DELETE' AND STATUS IN (2,4) AND END_TIME <= STR_TO_DATE(NOW(),'%Y-%m-%s 00:00:00');
		
		COMMIT;
		
		-- 将已到期的非作废记录置为已过期
		UPDATE app_park_monthly_record SET STATUS = 3
		WHERE flag != 'DELETE'AND STATUS != 4 AND END_TIME <= STR_TO_DATE(NOW(),'%Y-%m-%s 00:00:00');
		
		COMMIT;
		
		-- 将今天到期的未生效记录置为正常
		UPDATE app_park_monthly_record SET STATUS = 1
		WHERE flag != 'DELETE' AND STATUS = 5 AND START_TIME >= STR_TO_DATE(NOW(),'%Y-%m-%s 00:00:00');
			
		COMMIT;
		
	    END$$
	
	DELIMITER ;

	-- 更新包月记录状态定时任务
	
	DELIMITER $$
	
	ALTER DEFINER=`fragrans`@`%` EVENT `event_reset_monthly_record_status` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-10 00:01:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
		     CALL p_reset_monthly_record_status();
		END$$
	
	DELIMITER ;

 	-- 扩展表添加用户设备类型 
 	ALTER TABLE app_user_ext ADD DEVICE_TYPE INT(1) DEFAULT NULL COMMENT '用户设备类型：1 ANDROID；2 IOS';

 	-- 扩展表数据备份
 	CREATE TABLE app_user_ext_bak_0324 AS SELECT * FROM app_user_ext;
	
 	-- 更新扩展表设备类型存储过程
	DELIMITER $$
	
	USE `fragrans`$$
	
	DROP PROCEDURE IF EXISTS `p_update_user_device_type`$$
	
	CREATE DEFINER=`fragrans`@`%` PROCEDURE `p_update_user_device_type`()
	BEGIN
        DECLARE _userId VARCHAR(36);		-- 用户ID
        DECLARE _deviceNo VARCHAR(64);		-- 设备编号
        DECLARE _deviceType INT(1);             -- 设备类型
        DECLARE _oldDeviceType INT(1);		-- 原设备类型
        DECLARE _fetchEnd BOOLEAN DEFAULT FALSE;-- 是否获取数据结束表识
	
	-- 定义游标
	DECLARE myCursor CURSOR FOR 
	SELECT t.user_id,t.device_no
	FROM app_user_login t
	ORDER BY CREATE_TIME DESC;
	    
	   
	-- 定义如果找不到纪录则设置获取数据结束标示为TRUE
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _fetchEnd = TRUE;
	 
	-- 打开游标处理
	OPEN myCursor;
	cursor_loop:LOOP
	    FETCH myCursor INTO _userId,_deviceNo;
	    
	    IF _fetchEnd THEN 
		LEAVE cursor_loop; 	
	    END IF;
	   
	    IF (_userId IS NULL OR _deviceNo IS NULL) THEN 
		ITERATE  cursor_loop;
	    END IF;
	    
	    IF (LENGTH(_deviceNo) > 35 && _deviceNo LIKE '%-%') THEN 
		SET _deviceType = 2;
	    ELSE 
		SET _deviceType = 1;
	    END IF;
		 
	    -- 获取用户原设备类型
	    SET _oldDeviceType = (SELECT device_type  FROM  app_user_ext WHERE user_id = _userId);
	    IF (_oldDeviceType IS NOT NULL AND _oldDeviceType = _deviceType) THEN
	        ITERATE  cursor_loop;
	    ELSE
	        UPDATE app_user_ext SET device_type = _deviceType WHERE user_id = _userId;
	    END IF;	
	    
	    COMMIT;	    
	END LOOP cursor_loop;
	CLOSE myCursor;
		   
    END$$

	DELIMITER ;


	-- 执行存储过程
	CALL p_update_user_device_type();

	-- 添加是否支持删除车牌
	ALTER TABLE base_area ADD IS_DELETE_PARKRECORD INT(1) DEFAULT '0' COMMENT '是否支持删除停车记录；0不支持1支持' 

	-- app_user_car表添加字段 ： 是否认证（0否；1是；默认0）
	ALTER TABLE app_user_car ADD IS_IDENTIFY INT(1) DEFAULT 0 COMMENT '是否认证（0否；1是；默认0）';


	-- 车主车辆信息表
	CREATE TABLE `app_user_car_info` (
	   `ID` varchar(36) NOT NULL COMMENT '主键ID',
	   `CAR_ID` varchar(36) NOT NULL COMMENT '车牌id',
	   `CAR_BRAND` varchar(36) DEFAULT NULL COMMENT '车辆品牌',
	   `CAR_COLOR` varchar(10) DEFAULT NULL COMMENT '车辆颜色',
	   `VEHICLE_TYPE` varchar(36) DEFAULT NULL COMMENT '车辆型号',
	   `VEHICLE_NUMBER` varchar(36) DEFAULT NULL COMMENT '车架号',
	   `ENGINE_NUMBER` varchar(36) DEFAULT NULL COMMENT '发动机号',
	   `MANUFACTURE_TIME` datetime DEFAULT NULL COMMENT '出厂时间',
	   `LICENSE_PHOTO` varchar(225) NOT NULL COMMENT '行驶证照片（正页）',
	   `LICENSE_PHOTO_VICE` varchar(225) DEFAULT NULL COMMENT '行驶证照片（副页）',
	   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
	   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
	   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
	   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
	   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
	   PRIMARY KEY (`ID`)
	 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='车主车辆信息表';
	
	-- 审核日志表
	CREATE TABLE `app_review_log` (
	   `ID` varchar(36) NOT NULL COMMENT '主键ID',
	   `CITY_CODE` int(10) DEFAULT NULL COMMENT '城市编码',
	   `BUSI_TYPE` int(1) NOT NULL COMMENT '业务类型（1表示车牌认证审核）',
	   `BUSI_ID` varchar(36) NOT NULL COMMENT '业务ID',
	   `BUSI_DESC` varchar(225) NOT NULL COMMENT '业务描述',
	   `PLATE_NO` varchar(32) DEFAULT NULL COMMENT '车牌号',
	   `PLATE_COLOR` int(1) DEFAULT '0' COMMENT '车牌颜色',
	   `REVIEW_STATUS` int(1) NOT NULL DEFAULT '0' COMMENT '审核状态 （0、未审核 1、审核中 2、通过 3、驳回）',
	   `REVIEWER` varchar(36) DEFAULT NULL COMMENT '审核人',
	   `REVIEW_TIME` datetime DEFAULT NULL COMMENT '审核时间',
	   `PASS_REASON` varchar(225) DEFAULT NULL COMMENT '通过原因',
	   `REJECT_REASON` varchar(225) DEFAULT NULL COMMENT '驳回原因',
	   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
	   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
	   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
	   PRIMARY KEY (`ID`)
	 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='审核日志表';

	-- 区域配置表添加包月时长配置
	insert into app_area_config values (uuid(),330110,'MAX_MONTHLY_DURATION',12,1,'最大包月时长',0,'admin',null,now(),null);

	-- 包月记录描述
	INSERT INTO base_para VALUES (UUID(),'PARK_MONTHLY_DESC','车主%s，车牌号%s于%s对%s包月，包月时间从%s至%s，包月%s个月','包月记录描述',1,0,'admin',NULL,NOW(),NULL);

	-- 包月订单标题
	INSERT INTO base_para VALUES (UUID(),'PARK_MONTHLY_ORDER_SUBJECT','中国好停车包月付费','包月订单标题',1,0,'admin',NULL,NOW(),NULL);

	-- 包月订单描述
	INSERT INTO base_para VALUES (UUID(),'PARK_MONTHLY_ORDER_BODY','车牌号%s于%s包月缴费','包月订单描述',1,0,'admin',NULL,NOW(),NULL);

	-- 包月审核通过提醒模板
	INSERT INTO base_para VALUE (UUID(),'MONTHLY_VERIFY_PASS','尊敬的%s车主,您的包月申请已通过, 很荣幸为您提供服务,如有问题，请拨打客服电话400-888-8236','包月审核通过提示内容',1,0,'admin',NULL,NOW(),NULL);

	-- 包月审核驳回模板
	INSERT INTO base_para VALUE (UUID(),'MONTHLY_VERIFY_REJECT','尊敬的%s车主,您的包月申请被拒绝, 请查看原因或重新提交申请,我们将竭诚为您服务,如有问题，请拨打客服电话400-888-8236','包月审核不通过提示内容',1,0,'admin',NULL,NOW(),NULL);

	-- 普通订单退款描述
	insert into base_para values(uuid(),'BASE_ORDER_REFUND_NOTE','停车记录%s于%s停车退款%s元','普通订单退款描述',1,0,'admin',null,now(),null);
    
	-- 包月订单退款描述
    INSERT INTO base_para VALUES(UUID(),'MONTHLY_ORDER_REFUND_NOTE','包月记录%s05于%s包月续费退款%s元','包月续费订单退款描述',1,0,'admin',NULL,NOW(),NULL);

    -- 区域表增加区域拼音字段
 	ALTER TABLE base_area ADD CITY_SPELL VARCHAR(36) COMMENT '城市中文拼音';

	-- base_para表新增参数  
	insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('96a8bd62-28b2-11e7-b3e4-54ee756108e5','UNBUNDLING_PLATE_CONTENT','尊敬的车主，由于%s已被其他用户认证，系统自动解绑了您的%s车牌，如有问题，请拨打客服电话400-888-8236','车牌解绑通知内容','1','0','admin','','2017-04-24 13:55:19',NULL);
	insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('85855754-28b2-11e7-b3e4-54ee756108e5','UNBUNDLING_PLATE_TITLE','车牌解绑通知','车牌解绑通知标题','1','0','admin','','2017-04-24 13:54:50',NULL);
	insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('631d220f-28b2-11e7-b3e4-54ee756108e5','REFRESH_VEHICLE_LIMIT_HOUR','1','刷新车辆限行信息更新时间（例：1点）','1','0','admin','','2017-04-24 13:53:52',NULL);
	insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('df7cb66f-1a9a-11e7-96d2-54ee756108e5','REFRESH_PM2_5_TIMELONG','60','PM2.5更新缓存时间间隔（分钟）','1','0','admin','admin','2017-04-06 15:30:20','2017-04-06 15:31:40');

	-- 数据字典新增
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('91de229c-257b-11e7-9735-00ff484aeadc','MONTHLY_REVIEW_STATUS','4','已失效','包月记录审核状态','0','5','0','admin','','2017-04-20 11:43:51',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('10fd163d-2037-11e7-9d15-00ff484aeadc','MONTHLY_REVIEW_STATUS','3','不通过','包月记录审核状态','0','4','0','admin','','2017-04-13 18:50:54',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('02f30da2-2037-11e7-9d15-00ff484aeadc','MONTHLY_REVIEW_STATUS','2','通过','包月记录审核状态','0','3','0','admin','','2017-04-13 18:50:31',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('f42c521c-2036-11e7-9d15-00ff484aeadc','MONTHLY_REVIEW_STATUS','1','受理中','包月记录审核状态','0','2','0','admin','','2017-04-13 18:50:06',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('e49593b4-2036-11e7-9d15-00ff484aeadc','MONTHLY_REVIEW_STATUS','0','未受理','包月记录审核状态','0','1','1','admin','','2017-04-13 18:49:40',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('63330362-2033-11e7-9d15-00ff484aeadc','MONTHLY_RECORD_STATUS','5','未生效','包月记录状态','0','5','0','admin','','2017-04-13 18:24:34',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('551ea9fb-2033-11e7-9d15-00ff484aeadc','MONTHLY_RECORD_STATUS','4','已作废','包月记录状态','0','4','0','admin','','2017-04-13 18:24:10',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('46dbb6e3-2033-11e7-9d15-00ff484aeadc','MONTHLY_RECORD_STATUS','3','已过期','包月记录状态','0','3','0','admin','','2017-04-13 18:23:46',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('354d304b-2033-11e7-9d15-00ff484aeadc','MONTHLY_RECORD_STATUS','2','续包受理中','包月记录状态','0','2','0','admin','','2017-04-13 18:23:17',NULL);
	insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('208a8b7b-2033-11e7-9d15-00ff484aeadc','MONTHLY_RECORD_STATUS','1','正常','包月记录状态','0','1','1','admin','','2017-04-13 18:22:42',NULL);

 
 
 
 
 
 