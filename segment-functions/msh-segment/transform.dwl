%dw 2.0
output application/json
import * from dw::core::Strings
import try from dw::Runtime

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

fun segmentBuild(data) = data match  {
   case is Object -> valuesOf(data) joinBy  "^"
   case is Array -> (data reduce ((item, acc = "") -> (acc) ++ "~" ++ segmentBuild(item) ))substringAfter "~"
   case is String -> data
   else -> ""
}
 
fun hl7(header,details) = header ++ "|" ++ ((valuesOf(details)) map (segmentBuild ($)) joinBy "|")

var result = {MSH : {
    (mapping.sendingApp.name): payload.sendingApp.name,
    (mapping.sendingApp.id): payload.sendingApp.id,
    (mapping.sendingApp.code): payload.sendingApp.code,
      (mapping.sendingFacility.name): payload.sendingFacility.name,
      (mapping.sendingFacility.id): payload.sendingFacility.id,
      (mapping.sendingFacility.code): payload.sendingFacility.code,
      (mapping.receivingApp.name): payload.receivingApp.name,
      (mapping.receivingApp.id): payload.receivingApp.id,
      (mapping.receivingApp.code): payload.receivingApp.code,
      (mapping.receivingFacility.name): payload.receivingFacility.name,
      (mapping.receivingFacility.id): payload.receivingFacility.id,
      (mapping.receivingFacility.code): payload.receivingFacility.code,
    (mapping.dateTime): (parseDate(payload.dateTime)),
    (mapping.security): (payload.security),
    (mapping.messageType."type"): payload.messageType."type",
    (mapping.messageType."code"): payload.messageType."code",
    (mapping.messageType."id"): payload.messageType."id",
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
      (mapping.messageProfileIdentifier.name): payload.messageProfileIdentifier.name,
      (mapping.messageProfileIdentifier.code): payload.messageProfileIdentifier.code,
      (mapping.messageProfileIdentifier.identifier): payload.messageProfileIdentifier.identifier,
      (mapping.messageProfileIdentifier.id): payload.messageProfileIdentifier.id,
    (mapping.sendingResponsibleOrg): payload.sendingResponsibleOrg,
    (mapping.receivingResponsibleOrg): payload.receivingResponsibleOrg,
    (mapping.sendingNetworkAddress): payload.sendingNetworkAddress,
    (mapping.receivingNetworkAddress): payload.receivingNetworkAddress
}}

var inputData = {
  "3": {
    "3.1": result.MSH."3.1" default "",
    "3.2":  result.MSH."3.1" default "",
    "3.3":result.MSH."3.1" default "",
  },
  "4": {
    "4.1": result.MSH."4.1" default "",
    "4.2": result.MSH."4.2" default "",
    "4.3": result.MSH."4.3" default ""
  },
  "5": {
    "5.1": result.MSH."5.1" default "",
    "5.2": result.MSH."5.2" default "",
    "5.3": result.MSH."5.3" default ""
  },
  "6": {
    "6.1": result.MSH."6.1" default "",
    "6.2": result.MSH."6.2" default "",
    "6.3": result.MSH."6.3" default ""
  },
  "7": result.MSH."7" default "",
  "8": result.MSH."8" default "",
  "9": {
    "9.1": result.MSH."9.1" default "",
    "9.2": result.MSH."9.2" default "",
    "9.3": result.MSH."9.3" default ""
  },
  "10": result.MSH."10" default "",
  "11": result.MSH."11" default "",
  "12": result.MSH."12" default "",
  "13": result.MSH."13" default "",
  "14": result.MSH."14" default "",
  "15": result.MSH."15" default "",
  "16": result.MSH."16" default "",
  "17": result.MSH."17" default "",
  "18": result.MSH."18" default "",
  "19": result.MSH."19" default "",
  "20": result.MSH."20" default "",
  "21": {
    "21.1": result.MSH."21.1" default "",
    "21.2": result.MSH."21.2" default "",
    "21.3": result.MSH."21.3" default "",
    "21.4": result.MSH."21.4" default ""
  },
  "22": result.MSH."22" default "",
  "23": result.MSH."23" default "",
  "24": result.MSH."24" default "",
  "25": result.MSH."25" default ""
}
---
hl7("MSH|^~\\&",inputData)
