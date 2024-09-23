%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var RXR ="RXR|:route.code:^:route.name:^:route.id:|:administrationSite.code:^:administrationSite.name:^:administrationSite.id:|:administrationDevice:|:administrationMethod:|:routingInstruction:|:administrationSiteModifier:|"

var result = {
    route:{
        (mapping.route.code) : payload.route.code,
        (mapping.route.name) : payload.route.name,
        (mapping.route.id) : payload.route.id
    },
    administrationSite:{
        (mapping.administrationSite.code): payload.administrationSite.code,
        (mapping.administrationSite.name): payload.administrationSite.name,
        (mapping.administrationSite.id): payload.administrationSite.id,
    },
    (mapping.administrationDevice): payload.administrationDevice,
    (mapping.administrationMethod): payload.administrationMethod,
    (mapping.routingInstruction): payload.routingInstruction,
    (mapping.administrationSiteModifier): payload.administrationSiteModifier
}

fun rxr(data) = RXR
replace ":route.code:" with( data.route."2.1" default "")
replace ":route.name:" with (data.route."2.2" default "")
replace ":route.id:" with (data.route."2.3" default "")
replace ":administrationSite.code:" with (data.administrationSite."3.1" default "")
replace ":administrationSite.name:" with (data.administrationSite."3.2" default "")
replace ":administrationSite.id:" with (data.administrationSite."3.3" default "")
replace ":administrationDevice:" with (data."4" default "")
replace ":administrationMethod:" with (data."5" default "")
replace ":routingInstruction:" with (data."6" default "")
replace ":administrationSiteModifier:" with (data."7" default "")
---
rxr(result)