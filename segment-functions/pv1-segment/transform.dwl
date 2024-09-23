%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var PV1 = "PV1|:setId:|:patientClass:|:assignedPatientLocation.code:^:assignedPatientLocation.description:"

var result = {
    (mapping.setId): payload.setId,
    (mapping.patientClass): payload.patientClass,
    assignedPatientLocation: {
        (mapping.assignedPatientLocation.code): payload.assignedPatientLocation.code,
        (mapping.assignedPatientLocation.description): payload.assignedPatientLocation.description
    }
}

fun pv1(data) = PV1
replace ":setId:" with (data."2" default "")
replace ":patientClass:" with (data."3" default "")
replace ":assignedPatientLocation.code:" with (data.assignedPatientLocation."4.1" default "")
replace ":assignedPatientLocation.description:" with (data.assignedPatientLocation."4.2" default "")
---
pv1(result)