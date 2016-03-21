@echo 192.168.0.23 - root - Passw0rd!
@"C:\Program Files (x86)\VMware\VMware vSphere CLI\bin\vicfg-cfgbackup.pl" --server=192.168.0.23 --username=root -s  .\backup_192_168_0_23.cfg 
@echo RESTORE
@echo ----------------
@echo vicfg-cfgbackup.pl --server=ESXi_host_IP_address --username=root -l backup_file
