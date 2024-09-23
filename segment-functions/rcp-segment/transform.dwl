%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date
var RCP = "RCP|:queryPriority:|:quantityLimitedRequestMaxLength:^:quantityLimitedRequestunits:|:responseModality:|:modifyIndicator:|:sortByField:|:segmentGroupInclusion:|"

var result = {
    (mapping.queryPriority): payload.queryPriority,
    quantityLimitedRequest:{
        (mapping.quantityLimitedRequest.maxLength): payload.quantityLimitedRequest.maxLength,
        (mapping.quantityLimitedRequest.units): payload.quantityLimitedRequest.units,
    (mapping.responseModality): payload.responseModality,
    (mapping.modifyIndicator): payload.modifyIndicator,
    (mapping.sortByField): payload.sortByField,
    (mapping.segmentGroupInclusion): payload.segmentGroupInclusion    
    }
}

fun rcp(data) = RCP
replace ":queryPriority:" with (data."1" default "")
replace ":quantityLimitedRequestMaxLength:" with (data.quantityLimitedRequest."2.1" default "")
replace ":quantityLimitedRequestunits:" with (data.quantityLimitedRequest."2.2" default "")
replace ":responseModality:" with (data."3" default "")
replace ":modifyIndicator:" with (data."4" default "")
replace ":sortByField:" with (data."5" default "")
replace ":segmentGroupInclusion:" with (data."6" default "")
---
rcp(result)

