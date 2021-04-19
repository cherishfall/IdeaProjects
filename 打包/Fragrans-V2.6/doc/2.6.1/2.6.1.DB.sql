--  数据字典
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('79ea8845-0191-11e7-af51-00ff484aeadc','PROVIDER_AUTH_TYPE','2','区域','商户授权类型','0','2','0','admin','','2017-03-05 18:50:03',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('6fe91e85-0191-11e7-af51-00ff484aeadc','PROVIDER_AUTH_TYPE','1','停车点','商户授权类型','0','1','1','admin','','2017-03-05 18:49:46',NULL);

-- 添加是否支持批量缴费，默认不支持
ALTER TABLE base_area ADD IS_BATCHPAY INT(1) not null DEFAULT '0' COMMENT '是否支持批量缴费';

-- 批量缴费折扣策略表
CREATE TABLE `app_activity_discount_strat_batchpay` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `DISCOUNT_ID` varchar(36) NOT NULL COMMENT '关联折扣ID',
   `DISCOUNT_DESC` varchar(225) NOT NULL COMMENT '折扣描述（如：满20元打8折）',
   `DISCOUNT` int(4) DEFAULT '0' COMMENT '折扣率(比如8折 填写80)',
   `IS_VALID` int(1) DEFAULT '0' COMMENT '是否有效(1是0否)',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='折扣批量缴费策略配置表'

-- 批量缴费订单关联表
CREATE TABLE `app_order_batchpay_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `USER_ID` varchar(36) NOT NULL COMMENT '用户ID',
   `CITY_CODE` int(10) DEFAULT NULL COMMENT '区域编码',
   `BATCHPAY_NO` varchar(64) NOT NULL COMMENT '批量缴费订单编号',
   `ORDER_NO` varchar(64) NOT NULL COMMENT '订单编号',
   `PARKRECORD_ID` varchar(36) DEFAULT NULL COMMENT '停车记录ID',
   `PARK_ID` varchar(36) DEFAULT NULL COMMENT '停车场（点）ID',
   `IS_PAID` int(1) DEFAULT NULL COMMENT '是否支付成功',
   `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='批量缴费订单映射表'

-- 地区参数配置表，配置批量缴费参数
insert into `app_area_config` (`ID`, `AREA_CODE`, `PARA_NAME`, `PARA_VALUE`, `PARA_TYPE`, `PARA_DESC`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('01e277f0-02ff-11e7-9eeb-00ff484aeadc','330110','MAX_BATCHPAY_COUNT','10','0','批量缴费单次最大条数','0','admin','','2017-03-07 14:26:41',NULL);
insert into `app_area_config` (`ID`, `AREA_CODE`, `PARA_NAME`, `PARA_VALUE`, `PARA_TYPE`, `PARA_DESC`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('23fef560-02ff-11e7-9eeb-00ff484aeadc','330110','IS_AUTO_COUPON','1','0','是否自动发券(1是；0否)','0','admin','','2017-03-07 14:26:41',NULL);

-- 优惠券表添加锁定时间
ALTER TABLE app_activity_ticket_putlog ADD LOCK_TIME DATETIME DEFAULT NULL COMMENT '锁定时间' AFTER is_lock;

-- 定义定时任务执行策略
DELIMITER $$

CREATE DEFINER=`fragrans`@`%` EVENT `event_deblock_ticket` ON SCHEDULE EVERY 10 SECOND STARTS '2016-01-22 11:19:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
	     CALL p_deblock_ticket;
	END$$

DELIMITER ;

-- 2分钟之前锁定的停车券进行解锁的过程
DELIMITER $$

USE `fragrans`$$

DROP PROCEDURE IF EXISTS `p_deblock_ticket`$$

CREATE DEFINER=`fragrans`@`%` PROCEDURE `p_deblock_ticket`(
)
    SQL SECURITY INVOKER
BEGIN
	
	-- 对2分钟之前锁定的停车券进行解锁
	UPDATE app_activity_ticket_putlog 
	   SET is_lock = 0,LOCK_TIME = NULL 
	WHERE IS_USED = 0 AND IS_OVERTIME = 0 AND ENABLED = 0
	  AND is_lock = 1 AND FLAG != 'DELETE'
	  AND LOCK_TIME < NOW() - 200;
		
	COMMIT;
	
    END$$

DELIMITER ;

-- 订单支付记录表 添加停车点ID、是否批量缴费订单、车牌号码
ALTER TABLE app_order_paylog ADD PARK_ID VARCHAR(36) DEFAULT NULL  COMMENT '停车点ID' AFTER is_paid;
ALTER TABLE app_order_paylog ADD IS_BATCHPAY INT(1) DEFAULT '0' NOT NULL COMMENT '是否批量缴费订单;1是0否' AFTER PARK_ID;
ALTER TABLE app_order_paylog ADD PLATE_NO VARCHAR(20) DEFAULT NULL  COMMENT '车牌号码' AFTER PARK_ID;

-- 数据字典表 添加批量缴费订单支付状态
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('b1f21534-0d41-11e7-ad12-00ff484aeadc','BATCHPAY_ORDER_STATUS','400','订单作废','批量缴费订单状态','0','3','0','admin','','2017-03-20 15:49:07',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('a202e720-0d41-11e7-ad12-00ff484aeadc','BATCHPAY_ORDER_STATUS','200','支付成功','批量缴费订单状态','0','2','0','admin','','2017-03-20 15:48:40',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('714fc847-0d40-11e7-ad12-00ff484aeadc','BATCHPAY_ORDER_STATUS','100','支付失败','批量缴费订单状态','0','1','1','admin','','2017-03-20 15:40:09',NULL);

-- 全局参数表 配置批量缴费订单body
insert into `base_para` (`ID`, `PARA_NAME`, `PARA_VALUE`, `PARA_DESC`, `PARA_TYPE`, `STATE`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('4b5a563c-0e05-11e7-a451-00ff484aeadc','BATCHPAY_ORDER_BODY','车牌号%s于%s批量补缴%s笔','批量补缴订单body','1','0','admin','','2017-03-21 15:09:56',NULL);

