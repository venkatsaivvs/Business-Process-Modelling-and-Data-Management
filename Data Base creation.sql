

/*The below query creates a table CAMPUS that stores the details of all the campuses of 
SRM University accorss the country .Flelds like campus_id,campus_name and its location are captured
Along with this the table also stores the geo stationary location(latitude and longitude values) of the campus
so that this information can be used to provide students directions to campus in the form maps.
For this we used the datatype SDO_GEOMETRY  */

create table campus
(campus_id number(6) constraint campus_pk primary key,
campus_name varchar(40) constraint name_nn not null,
campus_city varchar(40),
campus_state varchar(40),
campus_zip number(6),
campus_geo_location SDO_GEOMETRY);




/*The below query creates a table scholarship that stores the different scholarships offered by the university 
it has the following fields scholarship_id,scholarship name,scholarship percentage */

create table scholarship
(scholarship_id number(6) constraint scholarship_pk primary key,
scholarship_name varchar(40) constraint scholarship_nn not null,
scholarship_percent number(3) constraint scholarship_nnn not null);

/*This is a table that stores all the tracks the university offers like mechanical engineering,
computerscience engineering which are identified by an ID*/

create table track
(track_id number(6) constraint track_pk primary key,
track_name varchar(40) constraint track_nn not null);

/*This is the major entity which stores all the applicant details who are admitted.It stores fields like applicant id,name etc
Few of the interesting fields here are Scholarship_y_n, a which stores T if the person 
is awarded with a scholarship and F otherwise.
Secondly we have the IP_address that stores the ip of the system on which the application is filled.This may be used for the security purpose 
*/

create table applicant
(Applicant_id number(6) constraint app_pk primary key,
Applicant_first_name varchar(40),
Applicant_last_name varchar(40),
campus_id_applied number(6) constraint campus_fk references campus(campus_id),
score_srmjee number(3) constraint score_chk check(score_srmjee>0),
high_school_percent number(3) constraint high_chk check(high_school_percent>0),
scholarship_y_n varchar(1),
scholarship_id number(6) constraint scholar_fk references scholarship(scholarship_id),
total_fee number(6),
fee_after_scholarship number(6),
date_applied date,
decision_date date,
ip_address varchar(30));





/*This query creates a table for the associative entity campus tracks with track_id and campus_id as foreign keys */

create table campustracks 
(track_id number(6) constraint trackcam_fk references track(track_id),
campus_id number(6) constraint campustr_fk references campus(campus_id));


/*This query creates a table for the associative entity trackpreference with track_id and applicant_id as foreign keys.
While appliying for a college the student can give preferences for his tracks(fields of study) so that if the first preference is not available,
the second will be given and so on .
The preference number stores the number which is the preference of the applicant corresponding to a track_id */

create table trackpreference
(preference_num number(6),
track_id number(6) constraint trackpref_fk references track(track_id),
applicant_id number(6) constraint app_fk references applicant(applicant_id));

alter table trackpreference add constraint comp_key primary key(preference_num,track_id,applicant_id);

------------------------------------------------------------------------
--INSERT STATEMENTS
-----------------------------------------------------------------

     
/* The below query inserts a few sample records in to campus table with a 6 digit campus id ,name 
zip code and the geo stationary location of the campus*/


     
insert all
into campus values(101987,'Banglore abc campus','Banglore','Karnataka',560007,SDO_GEOMETRY(2001, 8307, SDO_POINT_TYPE (-71.48923,42.72347,NULL), NULL, NULL))
into campus values(101988,'Chennai xyz campus','Chennai','Tamilnadu',600029,SDO_GEOMETRY(2002, 8308, SDO_POINT_TYPE (-60.48923,32.72347,NULL), NULL, NULL))
into campus values(101908,'Hyderabad pqr campus','Hyderabad','Telangana',500070,SDO_GEOMETRY(2004, 8366, SDO_POINT_TYPE (-50.48923,22.72347,NULL), NULL, NULL))
into campus values(101671,'Mumbai def campus','Mumbai','Maharastra',400090,SDO_GEOMETRY(2065, 8355, SDO_POINT_TYPE (-40.48923,22.72347,NULL), NULL, NULL))
select * from dual;

/*These are the sample records which are different types of scholarships offered by the university to the students,
the last column 'scholarship percentage' gives the percentage of scholarship corresponding to each scholarship id*/

insert all 
into scholarship values(201234,'Academic full',100)
 into scholarship values(201235,'Academic percent1',50)
into scholarship values(201236,'Academic percent2',25)
into scholarship values(201237,'Academic percent3',75)
into scholarship values(201238,'Sports',25)
select * from dual;


/*These are the sample tracks which are the different fields of study(we call them tracks) that the university offeres accross all its campuses.
It has the track id and a corresponding course  name
 */


insert all
into track values(301345,'Electronics')
into track values(301456,'ComputerScience')
into track values(301657,'Instrumentation')
into track values(301576,'Telecommunication')
into track values(301879,'Mechanical')
into track values(301903,'Automobile')
into track values(301865,'Electrical')
select * from dual;

/*It stores the details of diiferent tracks offered in different campuses.
A track can be offered in many campuses but it must be offered in atleast 1 campus and a campus can have many courses 
but must have atleast one course.*/


insert all
into campustracks values(301345,101987)
into campustracks values(301456,101987)
into campustracks values(301657,101987)
into campustracks values(301576,101908)
into campustracks values(301456,101908)
into campustracks values(301865,101908)
into campustracks values(301865,101988)
into campustracks values(301903,101988)
into campustracks values(301576,101988)
into campustracks values(301879,101671)
into campustracks values(301903,101671)
into campustracks values(301865,101671)
select * from dual;


/*Below are the list of applicants who applied to our university.Each one is given a unique id and all the details like gpa,score are captured.
below are few sample applicants the query 'select sys_context('USERENV', 'ip_address')' gives the ip address of the applicant.This is used for the 
security purpose*/

insert all 
into applicant values(901123,'venkat','varada',101987,200,85.1,'T',201234,75000,0,sysdate,sysdate+7,(select(sys_context('USERENV', 'ip_address')) from dual))
into applicant values(901143,'Ravi','kolla',101988,160,74.2,'T',201235,75000,37500,sysdate,sysdate+7,(select(sys_context('USERENV', 'ip_address')) from dual))
into applicant values(901163,'sai','vijay',101908,194,86.2,'T',201236,75000,56250,sysdate,sysdate+7,(select(sys_context('USERENV', 'ip_address')) from dual))
select * from dual;





/*These are the sample records of the preferences each student has given for his track using preference number,track_id.*/


insert all
into trackpreference values(1,301345,901123)
into trackpreference values(2,301456,901123)
into trackpreference values(1,301345,901143)
into trackpreference values(2,301865,901143)
into trackpreference values(1,301456,901163)
into trackpreference values(2,301865,901163)
select * from dual;

 





