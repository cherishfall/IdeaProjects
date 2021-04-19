CREATE TABLE `app_activity_redeem_code` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID',
   `ACTIVITY_ID` varchar(36) NOT NULL COMMENT '活动ID',
   `REDEEM_CODE` varchar(255) NOT NULL COMMENT '兑换码',
   `REDDEM_IMAGEURL` varchar(255) NOT NULL COMMENT '兑换码宣传图片',
   `REDEEM_ACTIVITY_URL` varchar(225) NOT NULL COMMENT '兑换活动URL外连接',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='活动兑换码关联表';
 
CREATE TABLE `app_activity_ticket_push_record_rel` (
   `ID` varchar(36) NOT NULL COMMENT '主键ID ',
   `PUTLOG_ID` varchar(36) NOT NULL COMMENT '关联优惠券发放日志ID',
   `TICKET_NO` varchar(36) DEFAULT NULL COMMENT '优惠券编号',
   `USER_ID` varchar(36) NOT NULL COMMENT '归属用户ID',
   `CLIENT_ID` varchar(36) NOT NULL COMMENT '归属用户客户端ID',
   `CONTENT` mediumtext NOT NULL COMMENT '下发内容',
   `STATUS` varchar(10) NOT NULL COMMENT '下发状态；100失败；200成功',
   `PUSH_TIME` datetime NOT NULL COMMENT '下发时间',
   `FLAG` varchar(16) NOT NULL DEFAULT '' COMMENT '操作标示 ADD：增加 UPDATE:修改 DELETE:删除',
   `CREATED_BY` varchar(36) NOT NULL COMMENT '创建人',
   `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
   `UPDATED_BY` varchar(36) DEFAULT NULL COMMENT '修改人',
   `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间,默认SYSDATE',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC COMMENT='即将过期优惠券消息推送记录关联表';
 
ALTER TABLE app_activity_ticket_putlog ADD REDEEM_CODE VARCHAR(225) COMMENT '来源兑换码' AFTER ORDERNO;

ALTER TABLE app_user_use_path ADD APP_VERSION VARCHAR(8) COMMENT 'APP版本号' AFTER STAY_TIME;