-- 新建APP_AREA_CONFIG表
create table APP_AREA_CONFIG
(
   ID VARCHAR2(36) NOT NULL,
   AREA_CODE NUMBER(10) NOT NULL ,
   PARA_NAME VARCHAR2(32) NOT NULL ,
   PARA_VALUE VARCHAR2(512)  NOT NULL ,
   PARA_TYPE NUMBER(1)  DEFAULT 0 NOT NULL ,
   PARA_DESC VARCHAR2(256) DEFAULT NULL ,
   STATE NUMBER(1)  DEFAULT 0 NOT NULL,
   CREATED_BY VARCHAR2(36)  NOT NULL ,
   UPDATED_BY VARCHAR2(36)  DEFAULT '' ,
   CREATE_TIME DATE default sysdate NOT NULL ,
   UPDATE_TIME DATE DEFAULT NULL 
)
tablespace FRAGRANS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on table APP_AREA_CONFIG
  is 'APP区域参数配置表';
  
comment on column APP_AREA_CONFIG.ID
  is '主键ID';
comment on column APP_AREA_CONFIG.AREA_CODE
  is '区域编码';
comment on column APP_AREA_CONFIG.PARA_NAME
  is '参数关键字';
comment on column APP_AREA_CONFIG.PARA_VALUE
  is '参数值';
comment on column APP_AREA_CONFIG.PARA_TYPE
  is '是否通用（1通用；0不通用）';
comment on column APP_AREA_CONFIG.PARA_DESC
  is '参数描述';
comment on column APP_AREA_CONFIG.STATE
  is '参数状态（1.停用；0.正常）';
comment on column APP_AREA_CONFIG.CREATED_BY
  is '创建人';
comment on column APP_AREA_CONFIG.UPDATED_BY
  is '修改人';
comment on column APP_AREA_CONFIG.CREATE_TIME
  is '创建时间';
comment on column APP_AREA_CONFIG.UPDATE_TIME
  is '更新时间';

alter table APP_AREA_CONFIG
  add constraint PK_APP_AREA_CONFIG primary key (ID)
  using index
  tablespace FRAGRANS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );


-- app_message表增加的字段
alter table APP_MESSAGE add MESSAGE_REMARK VARCHAR2(1024);
comment on column APP_MESSAGE.MESSAGE_REMARK is '消息摘要';
alter table APP_MESSAGE add MESSAGE_IMAGE VARCHAR2(128);
comment on column APP_MESSAGE.MESSAGE_IMAGE is '消息列表图片地址';
alter table APP_MESSAGE add MESSAGE_URL VARCHAR2(128);
comment on column APP_MESSAGE.MESSAGE_URL is '消息跳转h5页面地址（配置了连接地址必须支持点击，点击跳转跳转到目标地址，不会打开消息详细）';
alter table APP_MESSAGE add ISCLICK number(1) default 0 not null;
comment on column APP_MESSAGE.ISCLICK is '是否可点击（1是0否；不可点击的消息，消息摘要不可空，消息内容可空）';
  
  

-- app_order表增加的字段
alter table APP_ORDER add BILL_NO VARCHAR2(16);
comment on column APP_ORDER.BILL_NO is '招行订单编号';
alter table APP_ORDER add EXTERNAL_NO VARCHAR2(36);
comment on column APP_ORDER.EXTERNAL_NO is '对外订单编号；旋极对接返回';


-- 修改app_stat_activity_effect表字段名
alter table APP_STAT_ACTIVITY_EFFECT  rename column CUMULATIV_UNUSED_USER_COUNT to UNUSED_USER_COUNT ;
alter table APP_STAT_ACTIVITY_EFFECT modify CUMULATIV_UNUSED_USER_COUNT NUMBER(8);
alter table APP_STAT_ACTIVITY_EFFECT  rename column CUMULATIVE_PARTICIPATE_USER_COUNT to PART_USER_COUNT ;
alter table APP_STAT_ACTIVITY_EFFECT modify PART_USER_COUNT NUMBER(8);
alter table APP_STAT_ACTIVITY_EFFECT  rename column CUMULATIVE_PAYFEE_ORDER_COUNT to PAYFEE_ORDER_COUNT ;
alter table APP_STAT_ACTIVITY_EFFECT modify PAYFEE_ORDER_COUNT NUMBER(8);
alter table APP_STAT_ACTIVITY_EFFECT  rename column TICKETPAY_USER_COUNT to TP_USER_COUNT ;
alter table APP_STAT_ACTIVITY_EFFECT modify TP_USER_COUNT NUMBER(8);
alter table APP_STAT_ACTIVITY_EFFECT  rename column ACTUAL_DISCOUNT_AMOUNT to ACT_DISCOUNT_AMOUNT ;
alter table APP_STAT_ACTIVITY_EFFECT modify ACT_DISCOUNT_AMOUNT NUMBER(8);


-- 修改app_stat_daily表字段名
ALTER TABLE APP_STAT_DAILY rename column TICKETPAY_SUCCESS_USER_COUNT to TICKET_SUCCESS_USER_COUNT ;
alter table APP_STAT_DAILY modify TICKET_SUCCESS_USER_COUNT NUMBER(8);



-- app_user_ext表增加的字段
ALTER TABLE APP_USER_EXT ADD PAY_PASSWORD VARCHAR2(64);
comment on column APP_USER_EXT.PAY_PASSWORD is '钱包支付密码';


-- app_user_pay_account表增加的字段
ALTER TABLE APP_USER_PAY_ACCOUNT ADD BANK_NAME VARCHAR2(32);
comment on column APP_USER_PAY_ACCOUNT.BANK_NAME is '绑定银行卡名称';
ALTER TABLE APP_USER_PAY_ACCOUNT ADD BANK_CARD VARCHAR2(32);
comment on column APP_USER_PAY_ACCOUNT.BANK_CARD is '银行卡号';



-- 新建表APP_USER_USE_PATH
 create table APP_USER_USE_PATH
(
   ID VARCHAR2(36) NOT NULL ,
   USER_ID VARCHAR2(36) DEFAULT NULL,
   PROCESS_ID VARCHAR2(36) NOT NULL ,
   HANDLE_ID VARCHAR2(16) NOT NULL ,
   ARRIVE_TIME DATE NOT NULL  ,
   DEPARTURE_TIME DATE NOT NULL ,
   STAY_TIME NUMBER(32)  DEFAULT '0' NOT NULL ,
   CREATED_BY VARCHAR2(36) NOT NULL ,
   CREATE_TIME DATE NOT NULL 
)
tablespace FRAGRANS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on table APP_USER_USE_PATH
  is 'APP用户操作路径表';
   
comment on column APP_USER_USE_PATH.ID
  is '主键ID';
comment on column APP_USER_USE_PATH.USER_ID
  is '用户ID';
comment on column APP_USER_USE_PATH.PROCESS_ID
  is '流程ID,标识一次app操作,一次操作内流程ID相同';
comment on column APP_USER_USE_PATH.HANDLE_ID
  is '操作ID,即页面/按钮 ID';
comment on column APP_USER_USE_PATH.ARRIVE_TIME
  is '进入时间';
comment on column APP_USER_USE_PATH.DEPARTURE_TIME
  is '离开时间';
comment on column APP_USER_USE_PATH.STAY_TIME
  is '停留时长，单位秒';
comment on column APP_USER_USE_PATH.CREATED_BY
  is '创建人';
comment on column APP_USER_USE_PATH.CREATE_TIME
  is '创建时间';

alter table APP_USER_USE_PATH
  add constraint PK_APP_USER_USE_PATH primary key (ID)
  using index
  tablespace FRAGRANS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );


-- 新建表APP_USER_USE_PATH_CONF
 create table APP_USER_USE_PATH_CONF
(
   ID VARCHAR2(36) NOT NULL ,
   HANDLE_ID VARCHAR2(16) NOT NULL,
   HANDLE_NAME VARCHAR2(32) NOT NULL ,
   CREATED_BY VARCHAR2(36) NOT NULL ,
   CREATE_TIME DATE NOT NULL
)
tablespace FRAGRANS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on table APP_USER_USE_PATH_CONF
  is 'APP用户操作路径配置表';
   
comment on column APP_USER_USE_PATH_CONF.ID
  is '主键ID';
  comment on column APP_USER_USE_PATH_CONF.HANDLE_ID
  is '操作ID,即页面/按钮 ID';
comment on column APP_USER_USE_PATH_CONF.HANDLE_NAME
  is '操作名称';
comment on column APP_USER_USE_PATH_CONF.CREATED_BY
  is '创建人';
comment on column APP_USER_USE_PATH_CONF.CREATE_TIME
  is '创建时间';
  
alter table APP_USER_USE_PATH_CONF
  add constraint PK_APP_USER_USE_PATH_CONF primary key (ID)
  using index
  tablespace FRAGRANS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );


-- 新建表APP_WALLET_BALANCE_CHANGE
 create table APP_WALLET_BALANCE_CHANGE
(

   ID VARCHAR2(36) NOT NULL ,
   USER_ID VARCHAR2(36) NOT NULL ,
   ORDER_NO VARCHAR2(64) NOT NULL ,
   HANDLE_TYPE NUMBER(1) NOT NULL  ,
   PRICE NUMBER(8) DEFAULT 0  NOT NULL ,
   BALANCE_BEFORE NUMBER(8)  DEFAULT 0 NOT NULL,
   BALANCE_AFTER NUMBER(8) DEFAULT 0 NOT NULL ,
   CHANGE_STATUS VARCHAR2(8) NOT NULL ,
   SUBJECT VARCHAR2(64) NOT NULL ,
   HANDLE_BODY VARCHAR2(64) NOT NULL ,
   CREATE_TIME DATE NOT NULL  ,
   CREATED_BY VARCHAR2(36) NOT NULL ,
   UPDATE_TIME DATE DEFAULT NULL ,
   UPDATED_BY VARCHAR2(36) DEFAULT NULL 
)
tablespace FRAGRANS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

comment on table APP_WALLET_BALANCE_CHANGE
  is 'APP钱包余额变动表';
   
  comment on column APP_WALLET_BALANCE_CHANGE.ID
  is '主键ID';
  comment on column APP_WALLET_BALANCE_CHANGE.USER_ID
  is '用户ID';
  comment on column APP_WALLET_BALANCE_CHANGE.ORDER_NO
  is '订单编号(唯一)';
  comment on column APP_WALLET_BALANCE_CHANGE.HANDLE_TYPE
  is '操作类型：1充值；2消费；3退款';
  comment on column APP_WALLET_BALANCE_CHANGE.PRICE
  is '本次操作金额';
  comment on column APP_WALLET_BALANCE_CHANGE.BALANCE_BEFORE
  is '变动前余额';
  comment on column APP_WALLET_BALANCE_CHANGE.BALANCE_AFTER
  is '变动后余额';
  comment on column APP_WALLET_BALANCE_CHANGE.CHANGE_STATUS
  is '变动状态：100未支付；200支付成功；400 订单作废；500支付失败';
  comment on column APP_WALLET_BALANCE_CHANGE.SUBJECT
  is  '标题';
  comment on column APP_WALLET_BALANCE_CHANGE.HANDLE_BODY
  is '操作描述';
  comment on column APP_WALLET_BALANCE_CHANGE.CREATE_TIME
  is '记录创建时间';
  comment on column APP_WALLET_BALANCE_CHANGE.CREATED_BY
  is  '创建人';
  comment on column APP_WALLET_BALANCE_CHANGE.UPDATE_TIME
  is '记录修改时间';
  comment on column APP_WALLET_BALANCE_CHANGE.UPDATED_BY
  is '修改人';


create unique index UK_BALANCE_CHANGE_ORDER_NO on APP_WALLET_BALANCE_CHANGE (ORDER_NO)
  tablespace FRAGRANS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


alter table APP_WALLET_BALANCE_CHANGE
  add constraint PK_APP_WALLET_BALANCE_CHANGE primary key (ID)
  using index
  tablespace FRAGRANS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );



-- 新建表APP_WALLET_RECHARGE
 create table APP_WALLET_RECHARGE
(
   ID VARCHAR2(36) NOT NULL ,
   CITY_CODE NUMBER(10) DEFAULT NULL ,
   AREA_CODE NUMBER(10) DEFAULT NULL ,
   USER_ID VARCHAR2(36) NOT NULL  ,
   USER_ACCOUNT VARCHAR2(32) DEFAULT NULL ,
   RECHARGE_NO VARCHAR2(64) NOT NULL  ,
   BILL_NO VARCHAR2(16) DEFAULT NULL ,
   PAY_TYPE VARCHAR2(10) NOT NULL  ,
   PRICE NUMBER(8) DEFAULT 0 NOT NULL  ,
   BALANCE_HIS NUMBER(8) DEFAULT 0 NOT NULL  ,
   BALANCE NUMBER(8)  DEFAULT 0 NOT NULL,
   ORDER_STATUS VARCHAR2(10) NOT NULL  ,
   ORDER_TIME DATE NOT NULL  ,
   PAY_TIME DATE DEFAULT NULL ,
   BUYER_ACCOUNT VARCHAR2(64) DEFAULT NULL  ,
   NOTIFY_STATUS NUMBER(1) DEFAULT 0 NOT NULL   ,
   NOTIFY_TIME VARCHAR2(32) DEFAULT NULL ,
   CREATE_TIME DATE NOT NULL 
)
tablespace FRAGRANS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


comment on table APP_WALLET_RECHARGE
  is 'APP钱包充值记录表';
   
 comment on column APP_WALLET_RECHARGE.ID
  is '主键ID';
 comment on column APP_WALLET_RECHARGE.CITY_CODE
  is '城市代码';
 comment on column APP_WALLET_RECHARGE.AREA_CODE
  is '区级代码';
 comment on column APP_WALLET_RECHARGE.USER_ID
  is '用户ID';
 comment on column APP_WALLET_RECHARGE.USER_ACCOUNT
  is  '用户账号';
 comment on column APP_WALLET_RECHARGE.RECHARGE_NO
  is '充值订单编号(唯一)';
 comment on column APP_WALLET_RECHARGE.BILL_NO
  is '招行订单编号';
 comment on column APP_WALLET_RECHARGE.PAY_TYPE
  is '支付方式(1支付宝 2微信APP支付 3微信公众号支付 4余额退款 5招行一网通支付)';
 comment on column APP_WALLET_RECHARGE.PRICE
  is '充值金额';
  comment on column APP_WALLET_RECHARGE.BALANCE_HIS
  is '充值前账户余额';
 comment on column APP_WALLET_RECHARGE.BALANCE
  is  '当前账户余额';
 comment on column APP_WALLET_RECHARGE.ORDER_STATUS
  is '充值订单状态码(100未支付；200支付成功；400 订单作废；500支付失败)';
 comment on column APP_WALLET_RECHARGE.ORDER_TIME
  is '订单时间';
  comment on column APP_WALLET_RECHARGE.PAY_TIME
  is '支付时间';
  comment on column APP_WALLET_RECHARGE.BUYER_ACCOUNT
  is '买家账号';
  comment on column APP_WALLET_RECHARGE.NOTIFY_STATUS
  is '通知状态(0：未通知后台或通知未返回成功，1：通知成功返回)';
  comment on column APP_WALLET_RECHARGE.NOTIFY_TIME
  is '最后一次通知时间';
  comment on column APP_WALLET_RECHARGE.CREATE_TIME
  is '记录创建时间';


create unique index UK_WALLET_RECHARGE_NO on APP_WALLET_RECHARGE (RECHARGE_NO);
create index PK_WALLET_RECHARGE_CITY_CODE on APP_WALLET_RECHARGE (CITY_CODE);
create index PK_RECHARGE_ORDER_STATUS on APP_WALLET_RECHARGE (ORDER_STATUS);

alter table APP_WALLET_RECHARGE
  add constraint PK_APP_WALLET_RECHARGE primary key (ID)
  using index
  tablespace FRAGRANS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 320K
    next 1M
    minextents 1
    maxextents unlimited
  );
