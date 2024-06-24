%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var SCH = "SCH|:placerAppointmentId:|:fillerAppointmentId:||||||:appointmentType:||||:appointmentTimingQuantity.startDateTime:||||||||||||||:fillerStatusCode:"

fun sch(data) = SCH
replace ":placerAppointmentId:" with (data.placerAppointmentId default "")
replace ":fillerAppointmentId:" with (data.fillerAppointmentId default "")
replace ":occuranceNumber:" with (data.occuranceNumber default "")
replace ":placerGroupNumber:" with (data.placerGroupNumber default "")
replace ":scheduleId:" with (data.scheduleId default "")
replace ":eventReason:" with (data.eventReason default "")
replace ":appointmentReason:" with (data.appointmentReason default "")
replace ":appointmentType:" with (data.appointmentType default "")
replace ":appointmentDuration:" with (data.appointmentDuration default "")
replace ":appointmentDurationUnits:" with (data.appointmentDurationUnits default "")
replace ":appointmentTimingQuantity.startDateTime:" with (parseDate ((data.appointmentTimingQuantity.startDateTime default "")))
replace ":fillerStatusCode:" with (data.fillerStatusCode default "")
---
sch(payload)