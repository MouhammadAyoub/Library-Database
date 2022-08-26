/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2/26/2022 10:06:21 PM                        */
/*==============================================================*/

use libraryDb
go

create trigger TD_BOOK on BOOK for delete as
begin
    declare
       @numrows  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Cannot delete parent "BOOK" if children still exist in "BORROWED_BOOKS"  */
    if exists (select 1
               from   BORROWED_BOOKS t2, deleted t1
               where  t2.BOOK_ID = t1.ID)
       begin
          select @errno  = 50006,
                 @errmsg = 'Children still exist in "BORROWED_BOOKS". Cannot delete parent "BOOK".'
          goto error
       end


    return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go


create trigger TU_BOOK on BOOK for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

      /*  Cannot modify parent code in "BOOK" if children still exist in "BORROWED_BOOKS"  */
      if update(ID)
      begin
         if exists (select 1
                    from   BORROWED_BOOKS t2, inserted i1, deleted d1
                    where  t2.BOOK_ID = d1.ID
                     and  (i1.ID != d1.ID))
            begin
               select @errno  = 50005,
                      @errmsg = 'Children still exist in "BORROWED_BOOKS". Cannot modify parent code in "BOOK".'
               goto error
            end
      end


      return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go

create trigger TI_BORROWED_BOOKS on BORROWED_BOOKS for insert as
begin
    declare
       @maxcard  int,
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Parent "BOOK" must exist when inserting a child in "BORROWED_BOOKS"  */
    if update(BOOK_ID)
    begin
       if (select count(*)
           from   BOOK t1, inserted t2
           where  t1.ID = t2.BOOK_ID) != @numrows
          begin
             select @errno  = 50002,
                    @errmsg = 'Parent does not exist in "BOOK". Cannot create child in "BORROWED_BOOKS".'
             goto error
          end
    end
    /*  Parent "MEMBER" must exist when inserting a child in "BORROWED_BOOKS"  */
    if update(MEMBER_USERNAME)
    begin
       if (select count(*)
           from   MEMBER t1, inserted t2
           where  t1.USERNAME = t2.MEMBER_USERNAME) != @numrows
          begin
             select @errno  = 50002,
                    @errmsg = 'Parent does not exist in "MEMBER". Cannot create child in "BORROWED_BOOKS".'
             goto error
          end
    end
    /*  Parent "LOAN" must exist when inserting a child in "BORROWED_BOOKS"  */
    if update(LOAN_ID)
    begin
       if (select count(*)
           from   LOAN t1, inserted t2
           where  t1.ID = t2.LOAN_ID) != @numrows
          begin
             select @errno  = 50002,
                    @errmsg = 'Parent does not exist in "LOAN". Cannot create child in "BORROWED_BOOKS".'
             goto error
          end
    end
    /*  The cardinality of Parent "BOOK" in child "BORROWED_BOOKS" cannot exceed 1 */
    if update(BOOK_ID)
    begin
       select @maxcard = (select count(*)
          from   BORROWED_BOOKS old
          where ins.BOOK_ID = old.BOOK_ID)
       from  inserted ins
       where ins.BOOK_ID is not null
       group by ins.BOOK_ID
       order by 1
       if @maxcard > 1
       begin
          select @errno  = 50007,
                 @errmsg = 'The maximum cardinality of a child has been exceeded! Cannot create child in "BORROWED_BOOKS".'
          goto error
       end
    end
    /*  The cardinality of Parent "LOAN" in child "BORROWED_BOOKS" cannot exceed 1 */
    if update(LOAN_ID)
    begin
       select @maxcard = (select count(*)
          from   BORROWED_BOOKS old
          where ins.LOAN_ID = old.LOAN_ID)
       from  inserted ins
       where ins.LOAN_ID is not null
       group by ins.LOAN_ID
       order by 1
       if @maxcard > 1
       begin
          select @errno  = 50007,
                 @errmsg = 'The maximum cardinality of a child has been exceeded! Cannot create child in "BORROWED_BOOKS".'
          goto error
       end
    end

    return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go


create trigger TU_BORROWED_BOOKS on BORROWED_BOOKS for update as
begin
   declare
      @maxcard  int,
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

      /*  Parent "BOOK" must exist when updating a child in "BORROWED_BOOKS"  */
      if update(BOOK_ID)
      begin
         if (select count(*)
             from   BOOK t1, inserted t2
             where  t1.ID = t2.BOOK_ID) != @numrows
            begin
               select @errno  = 50003,
                      @errmsg = 'BOOK" does not exist. Cannot modify child in "BORROWED_BOOKS".'
               goto error
            end
      end
      /*  Parent "MEMBER" must exist when updating a child in "BORROWED_BOOKS"  */
      if update(MEMBER_USERNAME)
      begin
         if (select count(*)
             from   MEMBER t1, inserted t2
             where  t1.USERNAME = t2.MEMBER_USERNAME) != @numrows
            begin
               select @errno  = 50003,
                      @errmsg = 'MEMBER" does not exist. Cannot modify child in "BORROWED_BOOKS".'
               goto error
            end
      end
      /*  Parent "LOAN" must exist when updating a child in "BORROWED_BOOKS"  */
      if update(LOAN_ID)
      begin
         if (select count(*)
             from   LOAN t1, inserted t2
             where  t1.ID = t2.LOAN_ID) != @numrows
            begin
               select @errno  = 50003,
                      @errmsg = 'LOAN" does not exist. Cannot modify child in "BORROWED_BOOKS".'
               goto error
            end
      end
      /*  The cardinality of Parent "BOOK" in child "BORROWED_BOOKS" cannot exceed 1 */
      if update(BOOK_ID)
      begin
         select @maxcard = (select count(*)
            from   BORROWED_BOOKS old
            where ins.BOOK_ID = old.BOOK_ID)
         from  inserted ins
         where ins.BOOK_ID is not null
         group by ins.BOOK_ID
         order by 1
         if @maxcard > 1
         begin
            select @errno  = 50007,
                   @errmsg = 'The maximum cardinality of a child has been exceeded! Cannot modify child in "BORROWED_BOOKS".'
            goto error
         end
      end
      /*  The cardinality of Parent "LOAN" in child "BORROWED_BOOKS" cannot exceed 1 */
      if update(LOAN_ID)
      begin
         select @maxcard = (select count(*)
            from   BORROWED_BOOKS old
            where ins.LOAN_ID = old.LOAN_ID)
         from  inserted ins
         where ins.LOAN_ID is not null
         group by ins.LOAN_ID
         order by 1
         if @maxcard > 1
         begin
            select @errno  = 50007,
                   @errmsg = 'The maximum cardinality of a child has been exceeded! Cannot modify child in "BORROWED_BOOKS".'
            goto error
         end
      end

      return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go

create trigger TD_LOAN on LOAN for delete as
begin
    declare
       @numrows  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Cannot delete parent "LOAN" if children still exist in "BORROWED_BOOKS"  */
    if exists (select 1
               from   BORROWED_BOOKS t2, deleted t1
               where  t2.LOAN_ID = t1.ID)
       begin
          select @errno  = 50006,
                 @errmsg = 'Children still exist in "BORROWED_BOOKS". Cannot delete parent "LOAN".'
          goto error
       end


    return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go


create trigger TU_LOAN on LOAN for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

      /*  Cannot modify parent code in "LOAN" if children still exist in "BORROWED_BOOKS"  */
      if update(ID)
      begin
         if exists (select 1
                    from   BORROWED_BOOKS t2, inserted i1, deleted d1
                    where  t2.LOAN_ID = d1.ID
                     and  (i1.ID != d1.ID))
            begin
               select @errno  = 50005,
                      @errmsg = 'Children still exist in "BORROWED_BOOKS". Cannot modify parent code in "LOAN".'
               goto error
            end
      end


      return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go

create trigger TD_MEMBER on MEMBER for delete as
begin
    declare
       @numrows  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return

    /*  Cannot delete parent "MEMBER" if children still exist in "BORROWED_BOOKS"  */
    if exists (select 1
               from   BORROWED_BOOKS t2, deleted t1
               where  t2.MEMBER_USERNAME = t1.USERNAME)
       begin
          select @errno  = 50006,
                 @errmsg = 'Children still exist in "BORROWED_BOOKS". Cannot delete parent "MEMBER".'
          goto error
       end


    return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go


create trigger TU_MEMBER on MEMBER for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

      /*  Cannot modify parent code in "MEMBER" if children still exist in "BORROWED_BOOKS"  */
      if update(USERNAME)
      begin
         if exists (select 1
                    from   BORROWED_BOOKS t2, inserted i1, deleted d1
                    where  t2.MEMBER_USERNAME = d1.USERNAME
                     and  (i1.USERNAME != d1.USERNAME))
            begin
               select @errno  = 50005,
                      @errmsg = 'Children still exist in "BORROWED_BOOKS". Cannot modify parent code in "MEMBER".'
               goto error
            end
      end


      return

/*  Errors handling  */
error:
    raiserror (@errmsg, @errno, -1)
    rollback  transaction
end
go

