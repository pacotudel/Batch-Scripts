@ECHO OFF
:: Check WMIC is available
WMIC.EXE Alias /? >NUL 2>&1 || GOTO s_error

:: Use WMIC to retrieve date and time
FOR /F "skip=1 tokens=1-6" %%G IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
   IF "%%~L"=="" goto s_done
      Set _yyyy=%%L
      Set _mm=00%%J
      Set _dd=00%%G
      Set _hour=00%%H
      SET _minute=00%%I
      SET _second=00%%K
)
:s_done

:: Pad digits with leading zeros
      Set _mm=%_mm:~-2%
      Set _dd=%_dd:~-2%
      Set _hour=%_hour:~-2%
      Set _minute=%_minute:~-2%
      Set _second=%_second:~-2%

Set logtimestamp=%_yyyy%-%_mm%-%_dd%_%_hour%_%_minute%_%_second%
goto make_dump

:s_error
echo WMIC is not available, using default log filename
Set logtimestamp=_

:make_dump
set FILENAME=backup_diff_%logtimestamp%
:: Diferencial
"C:\Program Files\7-Zip\7z" u c:\backup\archive.7z c:\Users\username\Desktop\scripts -ms=off -mx=9 -t7z -up0q3r2x2y2z0w2!c:\backup\%FILENAME%.7z
:: Incremental
::"C:\Program Files\7-Zip\7z" u c:\backup\archive.7z c:\Users\username\Desktop\scripts -ms=off -mx=9 -t7z -up0q3r2x2y2z1w2!c:\backup\%FILENAME%.7z

:: The long string after the -u tells the program what to do with specific cases of files:
:: The letters:
:: p – File exists in archive, but is not matched with wildcard.
:: q – File exists in archive, but doesn’t exist on disk.
:: r – File doesn’t exist in archive, but exists on disk.
:: x – File in archive is newer than the file on disk.
:: y – File in archive is older than the file on disk.
:: z – File in archive is same as the file on disk
:: w – Can not be detected what file is newer (times are the same, sizes are different)
:: The numbers:
:: 0 Ignore file (don't create item in new archive for this file)
:: 1 Copy file (copy from old archive to new)
:: 2 Compress (compress file from disk to new archive)
:: 3 Create Anti-item (item that will delete file or directory during extracting). This feature is supported only in 7z format
:: From here you could write a small bat file that runs the update command and then schedule it if you want it to happen on a regular basis
