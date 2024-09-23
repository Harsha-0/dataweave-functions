%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var SCH = "SCH|:placerAppointmentId:|:fillerAppointmentId:||||||:appointmentType:||||:appointmentTimingQuantity.startDateTime:||||||||||||||:fillerStatusCode:"

var result = {
    (mapping.placerAppointmentId): payload.placerAppointmentId,
    (mapping.fillerAppointmentId): payload.fillerAppointmentId,
    (mapping.appointmentType): payload.appointmentType,
    (mapping.appointmentDuration): payload.appointmentDuration,
    (mapping.appointmentDurationUnits): payload.appointmentDurationUnits,
    appointmentTimingQuantity: {
        (mapping.appointmentTimingQuantity.startDateTime): payload.appointmentTimingQuantity.startDateTime,
        (mapping.appointmentTimingQuantity.endDateTime): payload.appointmentTimingQuantity.endDateTime
    },
    (mapping.fillerStatusCode): payload.fillerStatusCode
}

fun sch(data) = SCH
replace ":placerAppointmentId:" with (data."2" default "")
replace ":fillerAppointmentId:" with (data."3" default "")
replace ":appointmentType:" with (data."4" default "")
replace ":appointmentDuration:" with (data."5" default "")
replace ":appointmentDurationUnits:" with (data."6" default "")
replace ":appointmentTimingQuantity.startDateTime:" with (parseDate ((data.appointmentTimingQuantity."7.1" default "")))
replace ":appointmentTimingQuantity.endDateTime:" with (parseDate ((data.appointmentTimingQuantity."7.2" default "")))
replace ":fillerStatusCode:" with (data."8" default "")
---
sch(result)