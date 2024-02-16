Select
    CalendarOfActivities.calendar_date,
    CalendarOfActivities."USER_EMAIL",
    CalendarOfActivities."USER_ACTIVE",
    Activities."RESPONSIBLE_ID",
    Activities."AUTHOR_ID",
    Activities."USER_FIO_AUTHOR",
    Activities."USER_NAME_DEPARTAMENT_AUTHOR",
    Activities."CALENDAR_EVENT_ID",
    Activities."SUBJECT",
    Activities."COMPLETED",
    Activities."DESCRIPTION",
    Activities."LOCATION",
    Activities."START_TIME",
    Activities."END_TIME",
    Activities."DEADLINE",
    Activities."PRIORITY",
    Activities."STATUS",
    Activities."ID_ACTIVITY",
    Activities."DATA_TIME_REPORT",
    Activities."LAST_UPDATED_DATA",
    Activities."TYPE_ACTIVITY",
    Activities."DIRECTION_ACTIVITY",
    Activities."FIO_RESPONSIBLE",
    Activities."DEPARTMENT_ID_RESPONSIBLE",
    Activities."NAME_DEPARTAMENT_RESPONSIBLE"
From
    (Select
         Dates.calendar_date,
         Users."USER_EMAIL",
         Users."USER_ACTIVE"
     From
         (Select
              calendar_date
          From
              generate_series((Select
                   Min(Date_Trunc('day', "B24_ACTIVITY_MEETING_TIMELINE"."CREATED_DATA_TIME"))
               From
                   "B24_ACTIVITY_MEETING_TIMELINE"), (Select
                   Max(Date_Trunc('day', "B24_ACTIVITY_MEETING_TIMELINE"."CREATED_DATA_TIME"))
               From
                   "B24_ACTIVITY_MEETING_TIMELINE"), '1 day'::Interval) As calendar_date) Dates Cross Join
         (Select Distinct
              "VIEW_B24_USER_DEPARTMENT_v2"."USER_EMAIL",
              "VIEW_B24_USER_DEPARTMENT_v2"."USER_ACTIVE"
          From
              "VIEW_B24_USER_DEPARTMENT_v2"
          Where
              "VIEW_B24_USER_DEPARTMENT_v2"."USER_EMAIL" <> '' And
              "VIEW_B24_USER_DEPARTMENT_v2"."USER_EMAIL" <> '1c@biovitrum.ru') Users) CalendarOfActivities Left Join
    (Select
         "B24_ACTIVITY_MEETING_TIMELINE"."EMAIL_RESPONSIBLE" As EMAIL_RESPONSIBLE,
         Date_Trunc('day', "B24_ACTIVITY_MEETING_TIMELINE"."CREATED_DATA_TIME") As CREATED_DATA_TIME,
         "B24_ACTIVITY_MEETING_TIMELINE"."RESPONSIBLE_ID",
         "B24_ACTIVITY_MEETING_TIMELINE"."AUTHOR_ID",
         "B24_ACTIVITY_MEETING_TIMELINE"."USER_FIO_AUTHOR",
         "B24_ACTIVITY_MEETING_TIMELINE"."USER_NAME_DEPARTAMENT_AUTHOR",
         "B24_ACTIVITY_MEETING_TIMELINE"."CALENDAR_EVENT_ID",
         "B24_ACTIVITY_MEETING_TIMELINE"."SUBJECT",
         "B24_ACTIVITY_MEETING_TIMELINE"."COMPLETED",
         "B24_ACTIVITY_MEETING_TIMELINE"."DESCRIPTION",
         "B24_ACTIVITY_MEETING_TIMELINE"."LOCATION",
         "B24_ACTIVITY_MEETING_TIMELINE"."START_TIME",
         "B24_ACTIVITY_MEETING_TIMELINE"."END_TIME",
         "B24_ACTIVITY_MEETING_TIMELINE"."DEADLINE",
         "B24_ACTIVITY_MEETING_TIMELINE"."PRIORITY",
         "B24_ACTIVITY_MEETING_TIMELINE"."STATUS",
         "B24_ACTIVITY_MEETING_TIMELINE"."ID_ACTIVITY",
         "B24_ACTIVITY_MEETING_TIMELINE"."DATA_TIME_REPORT",
         "B24_ACTIVITY_MEETING_TIMELINE"."LAST_UPDATED_DATA",
         "B24_ACTIVITY_MEETING_TIMELINE"."TYPE_ACTIVITY",
         "B24_ACTIVITY_MEETING_TIMELINE"."DIRECTION_ACTIVITY",
         "B24_ACTIVITY_MEETING_TIMELINE"."FIO_RESPONSIBLE",
         "B24_ACTIVITY_MEETING_TIMELINE"."DEPARTMENT_ID_RESPONSIBLE",
         "B24_ACTIVITY_MEETING_TIMELINE"."NAME_DEPARTAMENT_RESPONSIBLE"
     From
         "B24_ACTIVITY_MEETING_TIMELINE"
     Where
         "B24_ACTIVITY_MEETING_TIMELINE"."EMAIL_RESPONSIBLE" <> '') Activities On CalendarOfActivities."USER_EMAIL" =
            Activities.EMAIL_RESPONSIBLE
            And CalendarOfActivities.calendar_date = Activities.CREATED_DATA_TIME
