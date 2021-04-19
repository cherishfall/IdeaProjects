-- 月报表添加字段
ALTER TABLE app_stat_month ADD ALIPAY_REFUND_SUC_COUNT INT(8) DEFAULT '0' COMMENT '支付宝退费成功笔数' AFTER CREATE_TIME;
ALTER TABLE app_stat_month ADD ALIPAY_REFUND_SUC_AMOUNT INT(8) DEFAULT '0' COMMENT '支付宝退费成功金额' AFTER ALIPAY_REFUND_SUC_COUNT;
ALTER TABLE app_stat_month ADD WXPAY_REFUND_SUC_COUNT INT(8) DEFAULT '0' COMMENT '微信退费成功笔数' AFTER ALIPAY_REFUND_SUC_AMOUNT;
ALTER TABLE app_stat_month ADD WXPAY_REFUND_SUC_AMOUNT INT(8) DEFAULT '0' COMMENT '微信退费成功金额' AFTER WXPAY_REFUND_SUC_COUNT;
ALTER TABLE app_stat_month ADD CMBPAY_REFUND_SUC_COUNT INT(8) DEFAULT '0' COMMENT '一网通退费成功笔数' AFTER WXPAY_REFUND_SUC_AMOUNT;
ALTER TABLE app_stat_month ADD CMBPAY_REFUND_SUC_AMOUNT INT(8) DEFAULT '0' COMMENT '一网通退费成功金额' AFTER CMBPAY_REFUND_SUC_COUNT;
ALTER TABLE app_stat_month ADD MCPAY_REFUND_SUC_COUNT INT(8) DEFAULT '0' COMMENT '会员卡退费成功笔数' AFTER CMBPAY_REFUND_SUC_AMOUNT;
ALTER TABLE app_stat_month ADD MCPAY_REFUND_SUC_AMOUNT INT(8) DEFAULT '0' COMMENT '会员卡退费成功金额' AFTER MCPAY_REFUND_SUC_COUNT;

-- 代扣
ALTER TABLE app_user_car ADD IS_CARD_AUTOPAY INT(1) DEFAULT '0' COMMENT '是否绑定会员卡自动代扣（0否；1是；默认0）' AFTER IS_IDENTIFY;
ALTER TABLE app_user_car ADD IS_ELECT_TAG INT(1) DEFAULT '0' COMMENT '是否绑定电子标签（0否；1是；默认0）' AFTER IS_CARD_AUTOPAY;
ALTER TABLE app_user_car ADD ELECT_TAG_NO VARCHAR(36) COMMENT '绑定电子标签编号' AFTER IS_ELECT_TAG;

-- 代扣 trans_park_record
ALTER TABLE trans_park_record ADD IS_CARD_AUTOPAY INT(1) DEFAULT '2' COMMENT '是否开通会员卡代扣 0开通 1不开通' AFTER PARK_FEE;
ALTER TABLE trans_park_record ADD CARD_AUTOPAY_USERID VARCHAR(36) DEFAULT NULL COMMENT '会员卡代扣用户id' AFTER IS_CARD_AUTOPAY;

--赠送金额
ALTER TABLE app_member_card ADD GIFT_AMOUNT INT(8) DEFAULT '0' COMMENT '赠送金额' AFTER BALANCE;

-- 会员卡赠送金额
ALTER TABLE app_order_paylog ADD MEMBER_CARD_FEE INT(8) DEFAULT '0' COMMENT '会员卡实际优惠金额' AFTER REDBOX_FEE;

insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('b6c23326-8971-11e7-98d9-54ee756108e5','DISPLAYCONF','3','app弹窗显示','显示策略','0','3','0','admin','','2017-08-25 16:45:14',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('2b7d604e-8704-11e7-b75f-008cfae40fdc','PAY_METHOD','8','支付宝扫码','支付方式','0','8','0','wangc','','2017-08-22 14:36:03',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('675e4cea-7cb5-11e7-b75f-008cfae40fdc','PAY_ACCOUNT_TYPE','8','支付宝扫码支付','支付账号类型','0','8','0','wangc','','2017-08-09 11:47:02',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('f8c03307-7cb4-11e7-b75f-008cfae40fdc','PAY_ACCOUNT_TYPE','7','支付宝代扣','支付账号类型','0','7','0','wangc','','2017-08-09 11:43:56',NULL);
insert into `base_dictionary` (`ID`, `CODE_TYPE`, `CODE_VALUE`, `CODE_TEXT`, `CODE_TYPE_DESC`, `STATE`, `ORDER_NUM`, `IS_DEFAULT`, `CREATED_BY`, `UPDATED_BY`, `CREATE_TIME`, `UPDATE_TIME`) values('8151183d-8946-11e7-b75f-008cfae40fdc','FEEDBACK_TYPE','4','个人建议','反馈问题类型','0','4','0','wangx','','2017-08-25 11:35:56',NULL);



ALTER TABLE app_order_refund ADD refund_pay_fee INT(8) COMMENT '退款金额（加上会员卡优惠的金额）' AFTER refund_fee;

UPDATE app_order_refund SET refund_pay_fee = refund_fee;

ALTER TABLE app_message ADD IS_DISPLAY_CONTENT INT(1) DEFAULT '1' COMMENT '是否显示标题和内容' AFTER ISCLICK;

ALTER TABLE app_feedback ADD PROCESS_STATUS INT(1) DEFAULT '0' COMMENT '0未受理 1受理中 2已完成' AFTER APP_ID;

UPDATE app_feedback SET PROCESS_STATUS = 2 WHERE PROCESS_RESULT IS NOT NULL;

-- app_provider_connect ALIPAY_PRIVATE 长度改成2048 payment  8 支付宝扫码
-- 增加支付宝appId字段
ALTER TABLE app_provider_connect ADD APPLYID VARCHAR(64) COMMENT '支付宝appId' AFTER APPID;

-- app_member_card_order 支付方式备注 8支付宝扫码支付
-- app_member_card_record HANDLE_TYPE 11支付宝扫码充值