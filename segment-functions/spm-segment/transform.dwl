%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var SPM = "SPM|:setId:|:specimenId.placerAssignedId.entityIdentifier:&:specimenId.placerAssignedId.name:&:specimenId.placerAssignedId.universalId:&:specimenId.placerAssignedId.uidType:^:specimenId.placerAssignedId.entityIdentifier:&:specimenId.placerAssignedId.name:&:specimenId.placerAssignedId.universalId:&:specimenId.placerAssignedId.uidType:|:specimenType.identifierCode:^:specimenType.description:^:specimenType.codingSystem:|:specimenCollectionMethod.resultCode:^:specimenCollectionMethod.text:|:specimenSourceSite.resultCode:^:specimenSourceSite.text:|:specimenCollectionDateTime:|:specimenReceivedDateTime:"

fun spm(data) = SPM
replace  ":setId:" with (data.setId  default "")
replace  ":specimenId.placerAssignedId.entityIdentifier:" with (data.specimenId.placerAssignedId.entityIdentifier  default "")
replace  ":specimenId.placerAssignedId.name:" with (data.specimenId.placerAssignedId.name  default "")
replace  ":specimenId.placerAssignedId.universalId:" with (data.specimenId.placerAssignedId.universalId  default "")
replace  ":specimenId.placerAssignedId.uidType:" with (data.specimenId.placerAssignedId.uidType  default "")
replace  ":specimenType.identifierCode:" with (data.specimenType.identifierCode  default "")
replace  ":specimenType.description:" with (data.specimenType.description  default "")
replace  ":specimenType.codingSystem:" with (data.specimenType.codingSystem  default "")
replace  ":specimenCollectionMethod.resultCode:" with (data.specimenCollectionMethod.resultCode  default "")
replace  ":specimenCollectionMethod.text:" with (data.specimenCollectionMethod.text  default "")
replace  ":specimenSourceSite.resultCode:" with (data.specimenSourceSite.resultCode  default "")
replace  ":specimenSourceSite.text:" with (data.specimenSourceSite.text  default "")
replace  ":specimenCollectionDateTime:" with (parseDate (data.specimenCollectionDateTime)  default "")
replace  ":specimenReceivedDateTime:" with (parseDate(data.specimenReceivedDateTime)  default "")
---
spm(payload)