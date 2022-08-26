set projloc=C:\Users\user\Desktop\Our_I3306_Project\LibraryDatabase\
set conn=-S Mhamad-Ayoub -U sa -P Ayoub123? -w 300
cls
echo Begining on top of MS Sqlserver DBMS engine...

osql %conn% -i %projloc%\SQL\insertValues.sql -o %projloc%\Log\insertValues.log

echo Values inserted...


echo End of batch file....