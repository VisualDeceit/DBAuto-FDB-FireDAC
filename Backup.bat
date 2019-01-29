@echo off
set "currentTime=%Time: =0%"
set now=%date:~-4%_%date:~3,2%_%date:~0,2%_%currentTime:~0,2%_%currentTime:~3,2%_%currentTime:~6,2%
  
set user=SYSDBA
set password=masterkey
set database_name=BASE.FDB
set backup_name=Backup\BASE
set ext=.fbk
 
set backup_filename=%backup_name%_%now%%ext%
echo %backup_filename%
nbackup -U %user% -P %password% -B 0 %database_name% %backup_filename%





pause