// File name: EasyTraj2CIC.sci
// Final Modified Date: 03/09/2015 
// Author: Hao-Chih,Lin (Jim,Lin)
// Email : F44006076@gmail.com
//
// Abstract:
// The purpose of this Scilab function is to translate the trajectory data generated by Scilab to CIC format file 
//
// Definition:
//	Date is Nx2 vector (MJD, format: [Date,time])
// 	Position is Nx3 vector (unit: km)
//	Velocity is Nx3 vector (unit: km/s)
//	Sat_Name is a string 
//	Body_Name is a string (e.g. 'EARTH')
//	file_name is a string of absolute path for output file (e.g. '/home/birdy/output.txt')
// ================================================================================================
// ============================================FUNCTION============================================
// ================================================================================================
function [] = EasyTraj2CIC(Date, Position, Velocity, Sat_Name, Body_Name, file_name)

	// Header definition
	time = getdate();
	time1 = [time(1),time(2), time(6), time(7), time(8), time(9), time(10)];

	correction_month = "";
	correction_day   = "";
	correction_hour = "";
	correction_mn = "";
	correction_sec = "";

	if time(6) <10 then
	correction_day   = '0';
	end
	if time(2) <10 then
	correction_month = '0';
	end
	if time(7) <10 then
	correction_hour = '0';
	end
	if time(8) <10 then
	correction_mn = '0';
	end
	if time(9) <10 then
	correction_sec = '0';
	end
	time1   = strcat(['CREATION_DATE = ', string(time1(1)),"-",strcat([correction_month,string(time1(2))]),"-",strcat([correction_day,string(time1(3))]),"T",strcat([correction_hour,string(time1(4))]),":",strcat([correction_mn,string(time1(5))]),":",strcat([correction_sec,string(time1(6))]),".",string(time1(7)) ]);

	// Write the header info
	fd = mopen(file_name,'wt');
	mfprintf(fd,'CIC_OEM_VERS = 2.0\n');
	mfprintf(fd,'%s\n',time1);
	mfprintf(fd,'ORIGINATOR = DOCKing System\n');
	mfprintf(fd,'\n');
	mfprintf(fd,'META_START\n');
	mfprintf(fd,'\n');
	mfprintf(fd,'OBJECT_NAME = %s\n',Sat_Name);
	mfprintf(fd,'OBJECT_ID = %s\n',Sat_Name);
	mfprintf(fd,'CENTER_NAME = %s\n',Body_Name);
	mfprintf(fd,'REF_FRAME = EME2000\n');
	mfprintf(fd,'TIME_SYSTEM = UTC\n');
	mfprintf(fd,'\n');
	mfprintf(fd,'META_STOP\n');
	mfprintf(fd,'\n');
	
	// Write the data into specificed file
	if size(Velocity,'r') == size(Position,'r') then
        for i=1:1:size(Date,'r')
            mfprintf(fd,'%i %f %f %f %f %f %f %f\n',Date(i,1),Date(i,2),Position(i,1),Position(i,2),Position(i,3),Velocity(i,1),Velocity(i,2),Velocity(i,3));
        end
	else
        for i=1:1:size(Date,'r')
            mfprintf(fd,'%i %f %f %f %f\n',Date(i,1),Date(i,2),Position(i,1),Position(i,2),Position(i,3));
        end
	end
   
	mclose(fd);


endfunction
