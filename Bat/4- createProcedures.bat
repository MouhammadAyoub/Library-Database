set projloc=C:\Users\user\Desktop\Our_I3306_Project\LibraryDatabase\
set conn=-S Mhamad-Ayoub -U sa -P Ayoub123? -w 300
cls
echo Begining on top of MS Sqlserver DBMS engine...

osql %conn% -i %projloc%\SQL\createProcedures.sql -o %projloc%\Log\createProcedures.log

echo Procedures created...


echo End of batch file....