%dw 2.0
output application/json
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date
//====================================================MSH-SEGMENT===================================================================

var MSH = "MSH|^~\&|:sendingAppName:^:sendingAppId:^:sendingAppCode:|:sendingFacilityName:^:sendingFacilityId:^:sendingFacilityCode:|:receivingAppName:^:receivingAppId:^:receivingAppCode:|:receivingFacilityName:^:receivingFacilityId:^:receivingFacilityCode:|:dateTime:|:security:|:messageType:^:messageTypeCode:^:messageTypeId:|:messageControlId:|:processsingId:|:versionId:|:sequenceNumber:|:continuationPointer:|:acceptAckType:|:appAckType:|:countryCode:|:characterSet:|:principalLan:|:alternateChar:|:messageProfileIdentifierName:^:messageProfileIdentifierCode:^:messageProfileIdentifierId:^:messageProfileIdentifierIdentifier:|:sendingResponsibleOrg:|:receivingResponsibleOrg:|:sendingNetworkAddress:|:receivingNetworkAddress:|"

fun msh(data) = MSH
replace ":sendingAppName:" with (data.sendingApp.name default "")
replace ":sendingAppId:" with (data.sendingApp.id default "")
replace ":sendingAppCode:" with (data.sendingApp.code default "")
replace ":sendingFacilityName:" with (data.sendingFacility.name default "")
replace ":sendingFacilityId:" with (data.sendingFacility.id default "")
replace ":sendingFacilityCode:" with (data.sendingFacility.code default "")
replace ":receivingAppName:" with (data.receivingApp.name default "")
replace ":receivingAppId:" with (data.receivingApp.id default "")
replace ":receivingAppCode:" with (data.receivingApp.code default "")
replace ":receivingFacilityName:" with (data.receivingFacility.name  default "")
replace ":receivingFacilityId:" with (data.receivingFacility.id  default "")
replace ":receivingFacilityCode:" with (data.receivingFacility.code default "")
replace ":dateTime:" with ((parseDate(data.dateTime default "")))
replace ":security:" with (data.security default "")
replace ":messageType:" with (data.messageType."type" default "")
replace ":messageTypeCode:" with (data.messageType.code default "")
replace ":messageTypeId:" with (data.messageType.id default "")
replace ":messageControlId:" with (data.messageControlId default "")
replace ":processsingId:" with (data.processsingId default "")
replace ":versionId:" with (data.versionId default "")
replace ":sequenceNumber:" with (data.sequenceNumber default "")
replace ":continuationPointer:" with (data.continuationPointer default "")
replace ":acceptAckType:" with (data.acceptAckType default "")
replace ":appAckType:" with (data.appAckType default "")
replace ":countryCode:" with (data.countryCode default "")
replace ":characterSet:" with (data.characterSet default "")
replace ":principalLan:" with (data.principalLan default "")
replace ":alternateChar:" with (data.alternateChar default "")
replace ":messageProfileIdentifierName:" with (data.messageProfileIdentifier.name default "")
replace ":messageProfileIdentifierCode:" with (data.messageProfileIdentifier.code default "")
replace ":messageProfileIdentifierId:" with (data.messageProfileIdentifier.id default "")
replace ":messageProfileIdentifierIdentifier:" with (data.messageProfileIdentifier.identifier default "")
replace ":sendingResponsibleOrg:" with (data.sendingResponsibleOrg default "")
replace ":receivingResponsibleOrg:" with (data.receivingResponsibleOrg default "")
replace ":sendingNetworkAddress:" with (data.sendingNetworkAddress default "")
replace ":receivingNetworkAddress:" with (data.receivingNetworkAddress default "")
---
msh(payload)