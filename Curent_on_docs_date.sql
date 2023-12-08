Select
    loginom.ref_sql_to_string(ПоследнееОбновлениеВалют._IDRRef) As Ссылка,
    КурсыВалют._Fld47555 As Курс,
    КурсыВалют._Fld47556 As Кратность
From
    (Select
         РеализацияТоваровУслуг._IDRRef As _IDRRef,
         РеализацияТоваровУслуг._Fld37519RRef As Валюта_Key,
         Max(КурсыВалют._Period) As Date_Last_Update
     From
         _InfoRg47553 КурсыВалют Inner Join
         _Document1051 РеализацияТоваровУслуг On РеализацияТоваровУслуг._Fld37519RRef = КурсыВалют._Fld47554RRef
                 And РеализацияТоваровУслуг._Date_Time >= КурсыВалют._Period
     Group By
         РеализацияТоваровУслуг._IDRRef,
         РеализацияТоваровУслуг._Fld37519RRef) ПоследнееОбновлениеВалют Inner Join
    _InfoRg47553 КурсыВалют On ПоследнееОбновлениеВалют.Date_Last_Update = КурсыВалют._Period
            And ПоследнееОбновлениеВалют.Валюта_Key = КурсыВалют._Fld47554RRef
