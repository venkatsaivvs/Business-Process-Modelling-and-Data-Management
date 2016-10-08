--report 1
set linesize 210

/*This report tells the management that the number of seats currently filled in a track in a campus and the number of seats left.
By default the number of seats are 200(University rule).This makes them aware that they can allot only the number of seats left*/


select campus_id,track_id,count(*),200-count(*) seats_left from campustracks group by campus_id,track_id;


--report 2
/* This report basically helps the universty in sorting out the preferences of the tracks of each student.The studentsa re sorted in the 
order of desceding order of their scores so that the management can easily give the decisions in the following way.
The top students have to be given their first preference till the track is full.Once the track is full the second set of students who didnot get their
first preference are given their second track and so on*/



select a.applicant_id,a.applicant_first_name,a.campus_id_applied,t.track_id,t.preference_num,a.score_srmjee,tr.track_name from applicant a join trackpreference t
on a.applicant_id = t.applicant_id
join track tr
on t.track_id = tr.track_id
order by a.score_srmjee desc,t.preference_num;
