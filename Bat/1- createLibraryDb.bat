set projloc=C:\Users\user\Desktop\Our_I3306_Project\LibraryDatabase\
set conn=-S Mhamad-Ayoub -U sa -P Ayoub123? -w 300
cls
echo Begining on top of MS Sqlserver DBMS engine...

osql %conn% -i %projloc%\SQL\createDatabase.sql -o %projloc%\Log\createDatabase.log

echo database created...


echo End of batch file....