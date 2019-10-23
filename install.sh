./sdtdserver auto-install;
# Update server
./sdtdserver update;
# Update serverconfig
cp /home/sdtdserver/sdtdserverserverfiles/serverconfig.xml /home/sdtdserver/sdtdserverserverfiles/sdtdserver.xml
# Start server
./sdtdserver start
