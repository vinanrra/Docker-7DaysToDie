./sdtdserver auto-install;
mv sdtdserver.cfg /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
# Update server
./sdtdserver update;
# Update serverconfig
cp /home/sdtdserver/sdtdserverserverfiles/serverconfig.xml /home/sdtdserver/sdtdserverserverfiles/sdtdserver.xml
# Start server
./sdtdserver start
