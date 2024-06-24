%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var RXR ="RXR|:route.code:^:route.name:^:route.id:|:administrationSite.code:^:administrationSite.name:^:administrationSite.id:|:administrationDevice:|:administrationMethod:|:routingInstruction:|:administrationSiteModifier:|"

fun rxr(data) = RXR
replace ":route.code:" with( data.route.code default "")
replace ":route.name:" with (data.route.name default "")
replace ":route.id:" with (data.route.id default "")
replace ":administrationSite.code:" with (data.administrationSite.code default "")
replace ":administrationSite.name:" with (data.administrationSite.name default "")
replace ":administrationSite.id:" with (data.administrationSite.id default "")
replace ":administrationDevice:" with (data.administrationDevice default "")
replace ":administrationMethod:" with (data.administrationMethod default "")
replace ":routingInstruction:" with (data.routingInstruction default "")
replace ":administrationSiteModifier:" with (data.administrationSiteModifier default "")
---
rxr(payload)