/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2/26/2022 10:12:09 PM                        */
/*==============================================================*/

use libraryDb
go

/*==============================================================*/
/* Index: CATEGORY_PK                                           */
/*==============================================================*/
create unique index CATEGORY_PK on CATEGORY (
ID ASC
)
go

/*==============================================================*/
/* Index: BOOK_PK                                               */
/*==============================================================*/
create unique index BOOK_PK on BOOK (
ID ASC
)
go

/*==============================================================*/
/* Index: BOOK_FK                                                */
/*==============================================================*/
create index BOOK_FK on BOOK (
CATEGORY_ID ASC
)
go

/*==============================================================*/
/* Index: AUTHOR_PK                                             */
/*==============================================================*/
create unique index AUTHOR_PK on AUTHOR (
ID ASC
)
go

/*==============================================================*/
/* Index: BOOK_AUTHOR_PK                                        */
/*==============================================================*/
create unique index BOOK_AUTHOR_PK on BOOK_AUTHOR (
BOOK_ID ASC,
AUTHOR_ID ASC
)
go

/*==============================================================*/
/* Index: BOOK_AUTHOR2_FK                                       */
/*==============================================================*/
create index BOOK_AUTHOR_FK on BOOK_AUTHOR (
AUTHOR_ID ASC
)
go

/*==============================================================*/
/* Index: MEMBER_PK                                             */
/*==============================================================*/
create unique index MEMBER_PK on MEMBER (
USERNAME ASC
)
go

/*==============================================================*/
/* Index: RESERVATION_PK                                        */
/*==============================================================*/
create unique index RESERVATION_PK on RESERVATION (
BOOK_ID ASC,
MEMBER_USERNAME ASC
)
go

/*==============================================================*/
/* Index: RESERVATION_FK                                       */
/*==============================================================*/
create index RESERVATION_FK on RESERVATION (
MEMBER_USERNAME ASC
)
go

/*==============================================================*/
/* Index: LOAN_PK                                               */
/*==============================================================*/
create unique index LOAN_PK on LOAN (
ID ASC
)
go

/*==============================================================*/
/* Index: BORROWED_BOOKS_PK                                     */
/*==============================================================*/
create unique index BORROWED_BOOKS_PK on BORROWED_BOOKS (
BOOK_ID ASC,
MEMBER_USERNAME ASC,
LOAN_ID ASC
)
go

/*==============================================================*/
/* Index: BORROWED_BOOKS_FK                                    */
/*==============================================================*/
create index BORROWED_BOOKS_FK on BORROWED_BOOKS (
MEMBER_USERNAME ASC
)
go

/*==============================================================*/
/* Index: BORROWED_BOOKS2_FK                                    */
/*==============================================================*/
create index BORROWED_BOOKS2_FK on BORROWED_BOOKS (
LOAN_ID ASC
)
go