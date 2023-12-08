Select
    "SYS_TURNOVER_REPORT"."Номенклатура" As "Номенклатура",
    "SYS_TURNOVER_REPORT"."Код" As "Код",
    "SYS_TURNOVER_REPORT"."Артикул" As "Артикул",
    "SYS_TURNOVER_REPORT"."Производитель" As "Производитель",
    "SYS_TURNOVER_REPORT"."СегментНоменклатуры" As "СегментНоменклатуры",
    "SYS_TURNOVER_REPORT"."БизнесНаправление" As "БизнесНаправление",
    "SYS_TURNOVER_REPORT"."ГруппаУправленияЗапасами" As "ГруппаУправленияЗапасами",
    "SYS_TURNOVER_REPORT"."ГруппаАналитическогоУчета" As "ГруппаАналитическогоУчета",
    "SYS_TURNOVER_REPORT"."ОсновнойМенеджер" As "ОсновнойМенеджер",
    "SYS_TURNOVER_REPORT"."ОсновнойПоставщик" As "ОсновнойПоставщик",
    "SYS_TURNOVER_REPORT"."ТипТовара" As "ТипТовара",
    "SYS_TURNOVER_REPORT"."ПерваяДатаЗакупки" As "ПерваяДатаЗакупки",
    "SYS_TURNOVER_REPORT"."СреднийОстатокШт" As "СреднийОстатокШт",
    "SYS_TURNOVER_REPORT"."РасходШт" As "РасходШт",
    "SYS_TURNOVER_REPORT"."Выручка" As "Выручка",
    "SYS_TURNOVER_REPORT"."КонечныйОстаток" As "КонечныйОстаток",
    "SYS_TURNOVER_REPORT"."Себестоимость" As "Себестоимость",
    "SYS_TURNOVER_REPORT"."СебестоимостьПродажЗаПериод" As "СебестоимостьПродажЗаПериод",
    "SYS_TURNOVER_REPORT"."СебестоимостьСреднегоОстатка" As "СебестоимостьСреднегоОстатка",
    "SYS_TURNOVER_REPORT"."ОборачиваемостьРуб" As "ОборачиваемостьРуб",
    "SYS_TURNOVER_REPORT"."СвободныйОстатокТекущий" As "СвободныйОстатокТекущий",
    "SYS_TURNOVER_REPORT"."СебестоимостьСвободногоОстатка" As "СебестоимостьСвободногоОстатка",
    "SYS_TURNOVER_REPORT"."Ранг" As "Ранг",
    "SYS_TURNOVER_REPORT"."Period" As "Period",
    'СрезПоследних' As "TipDannyh"
From
    (Select
         Max(MAX_Period."Period") As Max_Period
     From
         "SYS_TURNOVER_REPORT" MAX_Period) Max_Period Inner Join
    "SYS_TURNOVER_REPORT" On Max_Period.Max_Period = "SYS_TURNOVER_REPORT"."Period"
Union All
Select
    TurnoverWithMonth."Номенклатура" As "Номенклатура",
    TurnoverWithMonth."Код" As "Код",
    TurnoverWithMonth."Артикул" As "Артикул",
    TurnoverWithMonth."Производитель" As "Производитель",
    TurnoverWithMonth."СегментНоменклатуры" As "СегментНоменклатуры",
    TurnoverWithMonth."БизнесНаправление" As "БизнесНаправление",
    TurnoverWithMonth."ГруппаУправленияЗапасами" As "ГруппаУправленияЗапасами",
    TurnoverWithMonth."ГруппаАналитическогоУчета" As "ГруппаАналитическогоУчета",
    TurnoverWithMonth."ОсновнойМенеджер" As "ОсновнойМенеджер",
    TurnoverWithMonth."ОсновнойПоставщик" As "ОсновнойПоставщик",
    TurnoverWithMonth."ТипТовара" As "ТипТовара",
    TurnoverWithMonth."ПерваяДатаЗакупки" As "ПерваяДатаЗакупки",
    TurnoverWithMonth."СреднийОстатокШт" As "СреднийОстатокШт",
    TurnoverWithMonth."РасходШт" As "РасходШт",
    TurnoverWithMonth."Выручка" As "Выручка",
    TurnoverWithMonth."КонечныйОстаток" As "КонечныйОстаток",
    TurnoverWithMonth."Себестоимость" As "Себестоимость",
    TurnoverWithMonth."СебестоимостьПродажЗаПериод" As "СебестоимостьПродажЗаПериод",
    TurnoverWithMonth."СебестоимостьСреднегоОстатка" As "СебестоимостьСреднегоОстатка",
    TurnoverWithMonth."ОборачиваемостьРуб" As "ОборачиваемостьРуб",
    TurnoverWithMonth."СвободныйОстатокТекущий" As "СвободныйОстатокТекущий",
    TurnoverWithMonth."СебестоимостьСвободногоОстатка" As "СебестоимостьСвободногоОстатка",
    TurnoverWithMonth."Ранг" As "Ранг",
    TurnoverWithMonth."Period" As "Period",
    'Исторические' As "TipDannyh"
From
    (Select
         Max("SYS_TURNOVER_REPORT"."Period") As "MaxInMonthPeriod",
         Date_Trunc('month', "SYS_TURNOVER_REPORT"."Period") As "MonthPeriod"
     From
         "SYS_TURNOVER_REPORT"
     Group By
         Date_Trunc('month', "SYS_TURNOVER_REPORT"."Period")) MaskOfMonth Inner Join
    (Select
         "SYS_TURNOVER_REPORT".*,
         Date_Trunc('month', "SYS_TURNOVER_REPORT"."Period") As "MonthPeriod"
     From
         "SYS_TURNOVER_REPORT") TurnoverWithMonth On MaskOfMonth."MonthPeriod" = TurnoverWithMonth."MonthPeriod"
            And MaskOfMonth."MaxInMonthPeriod" = TurnoverWithMonth."Period"
