set projloc=C:\Users\user\Desktop\Our_I3306_Project\LibraryDatabase\
set conn=-S Mhamad-Ayoub -U sa -P Ayoub123? -w 300
cls
echo Begining on top of MS Sqlserver DBMS engine...

osql %conn% -i %projloc%\SQL\createViews.sql -o %projloc%\Log\createViews.log

echo views created...


echo End of batch file....