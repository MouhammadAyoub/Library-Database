use libraryDb
go


/*==============================================================*/
/* 1- Procedure: ADD CATEGORIES                                 */
/*==============================================================*/


create procedure addCategory @cat_name varchar(80)
as
begin
	if not exists (select ID from CATEGORY where CATEGORY_NAME = @cat_name)
	begin
		insert into CATEGORY(CATEGORY_NAME) values(@cat_name)
	end
end
go


/*==============================================================*/
/* 2- Procedure: ADD BOOKS                                      */
/*==============================================================*/


create procedure addBook @cat_name varchar(80), @titre varchar(80), @pub_date date, @copies int,
						 @author_first varchar(80), @author_last varchar(80)
as
begin
	declare @cat_id int, @book_id int, @autor_id int
	if not exists (select ID from BOOK where TITLE = @titre)
	begin
		set @cat_id = (select ID from CATEGORY where @cat_name = CATEGORY_NAME)
		insert into BOOK(CATEGORY_ID,TITLE,PUBLICATION_DATE,COPIES_ON_SHELF) values(@cat_id,@titre,@pub_date,@copies)
		set @book_id = (select ID from BOOK where TITLE = @titre)
		if not exists (select ID from AUTHOR where FIRST_NAME = @author_first and LAST_NAME = @author_last)
		begin
			insert into AUTHOR(FIRST_NAME,LAST_NAME) values(@author_first,@author_last)
		end
		set @autor_id = (select ID from AUTHOR where FIRST_NAME = @author_first and LAST_NAME = @author_last)
		insert into BOOK_AUTHOR values (@book_id,@autor_id)
	end
end
go


/*==============================================================*/
/* 3- Procedure: SEARCH BY BOOK CATEGORY                        */
/*==============================================================*/


create procedure searchByBookCategory @book_cat varchar(80)
as
begin
	declare @cat_id int
	set @cat_id = (select ID from CATEGORY where CATEGORY_NAME = @book_cat)
	select TITLE from BOOK where CATEGORY_ID = @cat_id
end
go


/*==============================================================*/
/* 4- Procedure: SEARCH BY BOOK NAME                            */
/*==============================================================*/


create procedure searchByBookName @book_name varchar(160)
as
begin
	select TITLE from BOOK where TITLE like @book_name+'%'
end
go


/*==============================================================*/
/* 5- Procedure: UPDATE BOOKS                                   */
/*==============================================================*/


create procedure bookUpdate @bookName varchar(160), @copies int
as
begin
	update BOOK set COPIES_ON_SHELF = @copies where TITLE = @bookName
end
go


/*==============================================================*/
/* 6- Procedure: ADD MEMBERS                                    */
/*==============================================================*/


create procedure addMember @username varchar(80),@login_password varchar(80),@email varchar(160),
							@firstName varchar(80), @lastName varchar(80)
as
begin
	if not exists (select USERNAME from MEMBER where USERNAME = @username )
	begin
		insert into MEMBER(USERNAME,LOGIN_PASSWORD,EMAIL,FIRST_NAME,LAST_NAME,JOINED_DATE)
					values(@username,@login_password,@email,@firstName,@lastName,(SELECT CAST(GETDATE() AS DATE)))
	end
end
go


/*==============================================================*/
/* 7- Procedure: BORROW BOOKS                                   */
/*==============================================================*/


create procedure borrowBook @username varchar(80),@bookName varchar(160)
as
begin

	declare @book_id int,@loan_id int,@copies int, @errmsg varchar(255), @loanDate date, @returnedDate date
	set @loanDate = (SELECT CAST(GETDATE() AS DATE))
	select @returnedDate = dateadd(day,7,@loanDate)
	set @book_id = (select ID from BOOK where TITLE = @bookName)
	set @copies = (select COPIES_ON_SHELF from BOOK where ID = @book_id)
	if ( @copies > 0 )
	begin
		insert into LOAN(LOAN_DATE,RETURNED_DATE) values(@loanDate,@returnedDate)
		set @loan_id = (SELECT ID FROM LOAN WHERE ID = @@Identity)
		insert into BORROWED_BOOKS values(@book_id,@username,@loan_id)
		update BOOK set COPIES_ON_SHELF = COPIES_ON_SHELF-1 where ID = @book_id
	end
end
go

/*==============================================================*/
/* 8- Procedure: RETURN BOOKS                                   */
/*==============================================================*/


create procedure returnBook @username varchar(80),@bookName varchar(160)
as
begin
	declare @bookID int, @loanID int
	set @bookID   = (select ID from BOOK where TITLE = @bookName)
	set @loanID   = (select LOAN_ID from BORROWED_BOOKS where BOOK_ID = @bookID and MEMBER_USERNAME = @username)
	delete from BORROWED_BOOKS where BOOK_ID = @bookID and MEMBER_USERNAME = @username
	delete from LOAN where ID = @loanID
	update BOOK set COPIES_ON_SHELF = COPIES_ON_SHELF+1 where ID = @bookID
end
go

/*==============================================================*/
/* 9- Procedure: BOOK RESERVATION                               */
/*==============================================================*/


create procedure bookReservation @username varchar(80),@bookName varchar(160)
as
begin
	declare @book_id int, @reserve_date date
	set @book_id = (select ID from BOOK where TITLE = @bookName)
	if not exists (select BOOK_ID from RESERVATION where BOOK_ID = @book_id)
	begin
		set @reserve_date = (select MIN(RETURNED_DATE) from LOAN where ID IN (
														select LOAN_ID from BORROWED_BOOKS
														where BOOK_ID = @book_id) )
	end
	else
	begin
		set @reserve_date = (select MAX(RESERVATION_DATE) from RESERVATION where BOOK_ID = @book_id)
		select @reserve_date = dateadd(day,7,@reserve_date)
	end
	select @reserve_date = dateadd(day,1,@reserve_date)
	insert into RESERVATION values (@book_id,@username,@reserve_date)
end
go


/*==============================================================*/
/* 10- Procedure: REMOVE BOOKS                                  */
/*==============================================================*/


create procedure removeBook @bookName varchar(160)
as
begin
	declare @book_id int
	set @book_id = (select ID from BOOK where TITLE = @bookName)
	delete from BOOK_AUTHOR where BOOK_ID = @book_id
	delete from BORROWED_BOOKS where BOOK_ID = @book_id
	delete from RESERVATION where BOOK_ID = @book_id
	delete from LOAN where ID IN (select LOAN_ID from BORROWED_BOOKS where BOOK_ID = @book_id)
	delete from BOOK where ID = @book_id
end
go
