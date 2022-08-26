use libraryDb
go

/*==============================================================*/
/* Table: Add CATEGORIES VALUES                                 */
/*==============================================================*/

exec addCategory 'Action'
go
exec addCategory 'Adventure'
go
exec addCategory 'Classics'
go
exec addCategory 'Comic'
go
exec addCategory 'Cookbooks'
go
exec addCategory 'Detective'
go
exec addCategory 'Essays'
go
exec addCategory 'Fantasy'
go
exec addCategory 'History'
go
exec addCategory 'Horror'
go
exec addCategory 'Literary'
go
exec addCategory 'Poetry'
go
exec addCategory 'Romance'
go
exec addCategory 'Sci-Fi'
go
exec addCategory 'Suspense'
go

/*==============================================================*/
/* Table: ADD BOOKS VALUES                                      */
/*==============================================================*/

exec addBook 'Romance','Anna Karenina','1990-11-27',5,'Mario','Vargas'
go
exec addBook 'Fantasy','To Kill a Mockingbird','1993-01-11',2,'Milan','Kundera'
go
exec addBook 'Sci-Fi','The Great Gatsby','1985-07-02',7,'Salman','Rushdie'
go
exec addBook 'Comic','One Hundred Years of Solitude','1995-12-15',3,'Margaret','Atwood'
go
exec addBook 'Suspense','A Passage to India','1978-04-20',5,'Kazuo','Ishiguro'
go
exec addBook 'Classics','Invisible Man','2000-09-23',9,'Hilary','Mantel'
go
exec addBook 'Detective','Don Quixote','1999-02-05',4,'Alice','Walker'
go
exec addBook 'Action','Beloved','1981-06-14',8,'Mo','Yan'
go
exec addBook 'Essays','Mrs. Dalloway','1997-12-01',1,'Arundhati','Roy'
go
exec addBook 'Horror','Things Fall Apart','2002-04-17',6,'Khaled','Hosseini'
go
exec addBook 'Poetry','Jane Eyre','1991-10-09',10,'Mohammad','Ayoub'
go
exec addBook 'Adventure','The Color Purple','2002-03-21',3,'Bayan','Cherry'
go

/*==============================================================*/
/* Table: ADD MEMBERS VALUES                                    */
/*==============================================================*/

exec addMember 'Farah_Ghandour','Farah123?','farah_ghandour@hotmail.com','Farah','Ghandour'
go
exec addMember 'Zahraa_Faour','Zahraa123?','zahraa_faour@hotmail.com','Zahraa','Faour'
go
exec addMember 'Ali_Zaiter','Ali123?','ali_zaiter@hotmail.com','Ali','Zaiter'
go
exec addMember 'Ghenwa_Jradi','Ghenwa123?','ghenwa_jradi@hotmail.com','Ghenwa','Jradi'
go
exec addMember 'Hussein_Jalloul','Hussein123?','hussein_jalloul@hotmail.com','Hussein','Jalloul'
go
exec addMember 'Abbass_Mortada','Abbass123?','abbass_mortada@hotmail.com','Abbass','Mortada'
go
update MEMBER set IS_ADMIN = 1 where USERNAME = 'Abbass_Mortada'
exec addMember 'Kawthar_Bazzal','Kawthar123?','kawthar_bazzal@hotmail.com','Kawthar','Bazzal'
go
exec addMember 'Mariam_Beydoun','Mariam123?','mariam_beydoun@hotmail.com','Mariam','Beydoun'
go
exec addMember 'Haidar_Shamas','Haidar123?','haidar_shamas@hotmail.com','Haidar','Shamas'
go
exec addMember 'Jaafar_Maatouk','Jaafar123?','jaafar_maatouk@hotmail.com','Jaafar','Maatouk'
go
exec addMember 'Zainab_Hamieh','Zainab123?','Zainab_Hamieh@hotmail.com','Zainab','Hamieh'
go