create table OPS$ORACLE.SPACES
(
  TIMESTAMP       DATE not null,
  OWNER           VARCHAR2(30) not null,
  SEGMENT_NAME    VARCHAR2(30) not null,
  SEGMENT_TYPE    VARCHAR2(30) not null,
  TABLESPACE_NAME VARCHAR2(30),
  FREE_BLOCKS     NUMBER,
  TOTAL_BLOCKS    NUMBER,
  UNUSED_BLOCKS   NUMBER,
  LAST_USED_BLOCK NUMBER,
  TOTAL_BYTES     NUMBER,
  UNUSED_BYTES    NUMBER
)
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 20M
    next 10M
    minextents 1
    maxextents 100
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPS$ORACLE.SPACES
  add constraint PK_SPACES primary key (TIMESTAMP,OWNER,SEGMENT_NAME,SEGMENT_TYPE)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 10M
    next 5M
    minextents 1
    maxextents 100
    pctincrease 0
  );
