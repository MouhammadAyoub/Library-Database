use libraryDb
go

/*==============================================================*/
/* Table: CATEGORY                                              */
/*==============================================================*/

create table CATEGORY (

   ID                   int                  Identity(1,1)  not null,
   CATEGORY_NAME        varchar(80)          UNIQUE			not null,
   primary key (ID)
)
go

/*==============================================================*/
/* Table: BOOK                                                  */
/*==============================================================*/

create table BOOK (

   ID					int                  Identity(1,1) not null,
   CATEGORY_ID          int                  not null,
   TITLE                varchar(160)          UNIQUE not null,
   PUBLICATION_DATE     date				         null,
   COPIES_ON_SHELF      int                  not null,
   primary key (ID),
   foreign key (CATEGORY_ID) references CATEGORY (ID)
)
go

/*==============================================================*/
/* Table: AUTHOR                                                */
/*==============================================================*/

create table AUTHOR (

   ID					int                  Identity(1,1) not null,
   FIRST_NAME           varchar(80)          not null,
   LAST_NAME            varchar(80)          not null,
   PRIMARY KEY (ID)
)
go

/*==============================================================*/
/* Table: BOOK_AUTHOR                                           */
/*==============================================================*/

create table BOOK_AUTHOR (

   BOOK_ID               int                  not null,
   AUTHOR_ID             int                  not null,
   primary key (BOOK_ID, AUTHOR_ID),
   foreign key (BOOK_ID) references BOOK (ID),
   foreign key (AUTHOR_ID) references AUTHOR (ID)
)
go

/*==============================================================*/
/* Table: MEMBER                                                */
/*==============================================================*/

create table MEMBER (

   USERNAME				varchar(80)          not null,
   LOGIN_PASSWORD		varchar(80)          not null,
   EMAIL			    varchar(160)         unique not null,
   FIRST_NAME           varchar(80)          not null,
   LAST_NAME            varchar(80)          not null,
   IS_ADMIN             bit                  default '0' not null,
   JOINED_DATE          date				 null
   primary key (USERNAME)
)
go

/*==============================================================*/
/* Table: RESERVATION                                           */
/*==============================================================*/

create table RESERVATION (

   BOOK_ID					int                  not null,
   MEMBER_USERNAME			varchar(80)          not null,
   RESERVATION_DATE			date	             not null,
   primary key (BOOK_ID, MEMBER_USERNAME),
   foreign key (BOOK_ID) references BOOK (ID),
   foreign key (MEMBER_USERNAME) references MEMBER (USERNAME)
)
go

/*==============================================================*/
/* Table: LOAN                                                  */
/*==============================================================*/

create table LOAN (

   ID					int                  Identity(1,1) not null,
   LOAN_DATE            date		         not null,
   RETURNED_DATE        date	             not null,
   primary key (ID)
)
go

/*==============================================================*/
/* Table: BORROWED_BOOKS                                        */
/*==============================================================*/

create table BORROWED_BOOKS (

   BOOK_ID               int                  not null,
   MEMBER_USERNAME       varchar(80)          not null,
   LOAN_ID               int                  not null,
   primary key (BOOK_ID, MEMBER_USERNAME, LOAN_ID),
   foreign key (BOOK_ID)	references BOOK (ID),
   foreign key (MEMBER_USERNAME)	references MEMBER (USERNAME),
   foreign key (LOAN_ID)	references LOAN (ID)
)
go