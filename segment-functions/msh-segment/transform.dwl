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

var result = {
  sendingApp: {
    (mapping.sendingApp.name): payload.sendingApp.name,
    (mapping.sendingApp.id): payload.sendingApp.id,
    (mapping.sendingApp.code): payload.sendingApp.code
  },
  sendingFacility:{
      (mapping.sendingFacility.name): payload.sendingFacility.name,
      (mapping.sendingFacility.id): payload.sendingFacility.id,
      (mapping.sendingFacility.code): payload.sendingFacility.code
  },
  receivingApp:{
      (mapping.receivingApp.name): payload.receivingApp.name,
      (mapping.receivingApp.id): payload.receivingApp.id,
      (mapping.receivingApp.code): payload.receivingApp.code
  },
  receivingFacility:{
      (mapping.receivingFacility.name): payload.receivingFacility.name,
      (mapping.receivingFacility.id): payload.receivingFacility.id,
      (mapping.receivingFacility.code): payload.receivingFacility.code
  },
    (mapping.dateTime): (payload.dateTime),
    (mapping.security): (payload.security),
  messageType:{
    (mapping.messageType."type"): payload.messageType."type",
    (mapping.messageType."code"): payload.messageType."code",
    (mapping.messageType."id"): payload.messageType."id"
    },
    (mapping.messageControlId): payload.messageControlId,
    (mapping.processsingId): payload.processsingId,
    (mapping.versionId): payload.versionId,
    (mapping.sequenceNumber): payload.sequenceNumber,
    (mapping.continuationPointer): payload.continuationPointer,
    (mapping.acceptAckType): payload.acceptAckType,
    (mapping.appAckType): payload.appAckType,
    (mapping.countryCode): payload.countryCode,
    (mapping.characterSet): payload.characterSet,
    (mapping.principalLan): payload.principalLan,
    (mapping.alternateChar): payload.alternateChar,
  messageProfileIdentifier:{
      (mapping.messageProfileIdentifier.name): payload.messageProfileIdentifier.name,
      (mapping.messageProfileIdentifier.code): payload.messageProfileIdentifier.code,
      (mapping.messageProfileIdentifier.identifier): payload.messageProfileIdentifier.identifier,
      (mapping.messageProfileIdentifier.id): payload.messageProfileIdentifier.id
    },
    (mapping.sendingResponsibleOrg): payload.sendingResponsibleOrg,
    (mapping.receivingResponsibleOrg): payload.receivingResponsibleOrg,
    (mapping.sendingNetworkAddress): payload.sendingNetworkAddress,
    (mapping.receivingNetworkAddress): payload.receivingNetworkAddress
}

fun msh(data) = MSH
replace ":sendingAppName:" with (data.sendingApp."3.1" default "")
replace ":sendingAppId:" with (data.sendingApp."3.2" default "")
replace ":sendingAppCode:" with (data.sendingApp."3.3" default "")
replace ":sendingFacilityName:" with (data.sendingFacility."4.1" default "")
replace ":sendingFacilityId:" with (data.sendingFacility."4.2" default "")
replace ":sendingFacilityCode:" with (data.sendingFacility."4.3" default "")
replace ":receivingAppName:" with (data.receivingApp."5.1" default "")
replace ":receivingAppId:" with (data.receivingApp."5.2" default "")
replace ":receivingAppCode:" with (data.receivingApp."5.3" default "")
replace ":receivingFacilityName:" with (data.receivingFacility."6.1"  default "")
replace ":receivingFacilityId:" with (data.receivingFacility."6.2"  default "")
replace ":receivingFacilityCode:" with (data.receivingFacility."6.3" default "")
replace ":dateTime:" with ((parseDate(data."7" default "")))
replace ":security:" with (data."8" default "")
replace ":messageType:" with (data.messageType."9.1" default "")
replace ":messageTypeCode:" with (data.messageType."9.2" default "")
replace ":messageTypeId:" with (data.messageType."9.3" default "")
replace ":messageControlId:" with (data."10" default "")
replace ":processsingId:" with (data."11" default "")
replace ":versionId:" with (data."12" default "")
replace ":sequenceNumber:" with (data."13" default "")
replace ":continuationPointer:" with (data."14" default "")
replace ":acceptAckType:" with (data."15" default "")
replace ":appAckType:" with (data."16" default "")
replace ":countryCode:" with (data."17" default "")
replace ":characterSet:" with (data."18" default "")
replace ":principalLan:" with (data."19" default "")
replace ":alternateChar:" with (data."20" default "")
replace ":messageProfileIdentifierName:" with (data.messageProfileIdentifier."21.1" default "")
replace ":messageProfileIdentifierCode:" with (data.messageProfileIdentifier."21.2" default "")
replace ":messageProfileIdentifierId:" with (data.messageProfileIdentifier."21.3" default "")
replace ":messageProfileIdentifierIdentifier:" with (data.messageProfileIdentifier."21.4" default "")
replace ":sendingResponsibleOrg:" with (data."22" default "")
replace ":receivingResponsibleOrg:" with (data."23" default "")
replace ":sendingNetworkAddress:" with (data."24" default "")
replace ":receivingNetworkAddress:" with (data."25" default "")
---
msh(result)