%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var OBR = "OBR|:orderControl:|:placerOrderNumber.entityIdentifier:^:placerOrderNumber.name:^:placerOrderNumber.universalId:^:placerOrderNumber.uidType:|:fillerOrderNumber.entityIdentifier:^:fillerOrderNumber.name:^:fillerOrderNumber.universalId:^:fillerOrderNumber.uidType:|:testRequested.identifier:^:testRequested.text:^:testRequested.codingSystem:^:testRequested.codingSystemVersion:|:observationBeginDateTime:|:observationEndDateTime:|:dateTimeOfTransaction:|:relevantClinicalInfo:|:specimenReceivedDateTime:|:specimenSource:|:orderingProvider.idNumber:^:orderingProvider.lastName:^:orderingProvider.firstName:^:orderingProvider.MI:^:orderingProvider.suffix:^:orderingProvider.prefix:|:callBackPhoneNumber.value:^:callBackPhoneNumber.'type':|:resultsDateTime:|:resultStatus:|:parentResult.identifier:^:parentResult.text:^:parentResult.codingSystem:^:parentResult.parentObsSubId:^:parentResult.parentObsValueDesc:|:parent.placerAssignedId:^:parent.fillerAssignedId:|:reasonForStudy.identifier:^:reasonForStudy.text:^:reasonForStudy.codingSystem:^:reasonForStudy.date:|:principalResultInterpreter.code:^:principalResultInterpreter.name:|"

fun obr(data) =OBR
replace  ":orderControl:" with (data.orderControl  default "")
replace  ":placerOrderNumber.entityIdentifier:" with (data.placerOrderNumber.entityIdentifier  default "")
replace  ":placerOrderNumber.name:" with (data.placerOrderNumber.name default "")
replace  ":placerOrderNumber.universalId:" with (data.placerOrderNumber.universalId default "")
replace  ":placerOrderNumber.uidType:" with (data.placerOrderNumber.uidType default "")
replace  ":fillerOrderNumber.entityIdentifier:" with (data.fillerOrderNumber.entityIdentifier  default "")
replace  ":fillerOrderNumber.name:" with (data.fillerOrderNumber.name  default "")
replace  ":fillerOrderNumber.universalId:" with (data.fillerOrderNumber.universalId  default "")
replace  ":fillerOrderNumber.uidType:" with (data.fillerOrderNumber.uidType  default "")
replace  ":testRequested.identifier:" with (data.testRequested.identifier  default "")
replace  ":testRequested.text:" with (data.testRequested.text  default "")
replace  ":testRequested.codingSystem:" with (data.testRequested.codingSystem  default "")
replace  ":testRequested.codingSystemVersion:" with (data.testRequested.codingSystemVersion  default "")
replace  ":observationBeginDateTime:" with (parseDate((data.observationBeginDateTime  default "")))
replace  ":observationEndDateTime:" with (parseDate((data.observationEndDateTime  default "")))
replace  ":dateTimeOfTransaction:" with (data.dateTimeOfTransaction  default "")
replace  ":relevantClinicalInfo:" with (data.relevantClinicalInfo  default "")
replace  ":specimenReceivedDateTime:" with (data.specimenReceivedDateTime  default "")
replace  ":specimenSource:" with (data.specimenSource  default "")
replace  ":orderingProvider.idNumber:" with (data.orderingProvider.idNumber  default "")
replace  ":orderingProvider.lastName:" with (data.orderingProvider.lastName  default "")
replace  ":orderingProvider.firstName:" with (data.orderingProvider.firstName  default "")
replace  ":orderingProvider.MI:" with (data.orderingProvider.MI  default "")
replace  ":orderingProvider.suffix:" with (data.orderingProvider.suffix  default "")
replace  ":orderingProvider.prefix:" with (data.orderingProvider.prefix  default "")
replace  ":callBackPhoneNumber.value:" with (data.callBackPhoneNumber.value  default "")
replace  ":callBackPhoneNumber.'type':" with telephone((data.callBackPhoneNumber  default []))
replace  ":resultsDateTime:" with (parseDate ((data.resultsDateTime default "")))
replace  ":resultStatus:" with (data.resultStatus default "")
replace  ":parentResult.identifier:" with (data.parentResult.identifier default "")
replace  ":parentResult.text:" with (data.parentResult.text default "")
replace  ":parentResult.codingSystem:" with (data.parentResult.codingSystem default "")
replace  ":parentResult.parentObsSubId:" with (data.parentResult.parentObsSubId default "")
replace  ":parentResult.parentObsValueDesc:" with (data.parentResult.parentObsValueDesc default "")
replace  ":parent.placerAssignedId:" with (data.parent.placerAssignedId default "")
replace  ":parent.fillerAssignedId:" with (data.parent.fillerAssignedId default "")
replace  ":reasonForStudy.identifier:" with (data.reasonForStudy.identifier default "")
replace  ":reasonForStudy.text:" with (data.reasonForStudy.text default "")
replace  ":reasonForStudy.codingSystem:" with (data.reasonForStudy.codingSystem default "")
replace  ":reasonForStudy.date:" with (parseDate((data.reasonForStudy.date default "")))
replace  ":principalResultInterpreter.code:" with (data.principalResultInterpreter.code default "")
replace  ":principalResultInterpreter.name:" with (data.principalResultInterpreter.name default "")
---
obr(payload)