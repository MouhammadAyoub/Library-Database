USE master

GO

CREATE DATABASE libraryDb
ON 
( NAME = libraryDb_dat,
  FILENAME = 'C:\Users\user\Desktop\Our_I3306_Project\LibraryDatabase\DataBase\libraryDb.mdf')
LOG ON
( NAME = 'libraryDb_log',
  FILENAME = 'C:\Users\user\Desktop\Our_I3306_Project\LibraryDatabase\DataBase\libraryDb.ldf')

go