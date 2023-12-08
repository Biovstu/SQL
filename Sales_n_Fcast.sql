Select
    "SYS_FORECASTING_CUMUL"."Period" As "Period",
    "SYS_FORECASTING_CUMUL"."Product" As "Product",
    "SYS_FORECASTING_CUMUL"."Index" + MaxIndex.Max_Index As "Index",
    "SYS_FORECASTING_CUMUL"."Forecast" As "QTY",
    "SYS_FORECASTING_CUMUL"."Precision" As "Precision",
    'Прогноз' As "TipDannyh"
From
    (Select
         "SYS_FORECASTING_CUMUL"."Product",
         Max("SYS_FORECASTING_CUMUL"."Period") As Max_Period
     From
         "SYS_FORECASTING_CUMUL"
     Group By
         "SYS_FORECASTING_CUMUL"."Product") ДатаПоследнегоОбновления Inner Join
    "SYS_FORECASTING_CUMUL" On ДатаПоследнегоОбновления."Product" = "SYS_FORECASTING_CUMUL"."Product"
            And ДатаПоследнегоОбновления.Max_Period = "SYS_FORECASTING_CUMUL"."Period",
    (Select
         Max("SYS_FORECASTING_SALES"."Index") As Max_Index
     From
         "SYS_FORECASTING_SALES") MaxIndex
Union All
Select
    Now() As "Period",
    "SYS_FORECASTING_SALES"."Product" As "Product",
    "SYS_FORECASTING_SALES"."Index" As "Index",
    "SYS_FORECASTING_SALES"."QTY" As "QTY",
    1 As "Precision",
    'Факт' As "TipDannyh"
From
    "SYS_FORECASTING_SALES"