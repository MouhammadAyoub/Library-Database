use libraryDb
go

create view borrowedBookList as

	select USERNAME, FIRST_NAME, LAST_NAME, TITLE AS BOOK_BORROWED
	from MEMBER , BOOK ,BORROWED_BOOKS
	where ID = BOOK_ID
	AND USERNAME = MEMBER_USERNAME
go

create view reservationList as

	select USERNAME, FIRST_NAME, LAST_NAME, TITLE, RESERVATION_DATE
	from MEMBER, BOOK, RESERVATION
	where USERNAME = MEMBER_USERNAME and ID = BOOK_ID
go

create view availableBookList as

	select TITLE
	from BOOK
	where COPIES_ON_SHELF != 0
go