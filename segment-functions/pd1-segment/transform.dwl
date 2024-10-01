%dw 2.0
output application/json
import * from dw::core::Strings
import try from dw::Runtime

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

fun segmentBuild(data) = data match  {
   case is Object -> valuesOf(data) joinBy "^"
   case is Array -> (data reduce ((item, acc = "") -> (acc) ++ "~" ++ segmentBuild(item) ))substringAfter "~"
   case is String -> data
   else -> ""
}

fun hl7(header,details) = header ++ "|" ++ ((valuesOf(details)) map (segmentBuild ($)) joinBy "|")

var result = {
    "PD1":{
    (mapping.livingDependency): payload.livingDependency,
    (mapping.livingArrangement): payload.livingArrangement,
    (mapping.patientPrimaryFacility): payload.patientPrimaryFacility,
    (mapping.patientPrimaryCareProvider): payload.patientPrimaryCareProvider,
    (mapping.studentIndicator): payload.studentIndicator,
    (mapping.handicap): payload.handicap,
    (mapping.livingWillCode): payload.livingWillCode,
    (mapping.organDonorCode): payload.organDonorCode,
    (mapping.separateBill): payload.separateBill,
    (mapping.duplicatePatient): payload.duplicatePatient,
    (mapping.publicityCode.id): payload.publicityCode.id,
    (mapping.publicityCode.description): payload.publicityCode.description,
    (mapping.publicityCode.code): payload.publicityCode.code,
    (mapping.protectionIndicator): payload.protectionIndicator,
    (mapping.protectionIndicatorEffectiveDate): parseDate(payload.protectionIndicatorEffectiveDate),
    (mapping.placeOfWorship): payload.placeOfWorship,
    (mapping.advanceDirectiveCode): payload.advanceDirectiveCode,
    (mapping.immunizationRegistryStatus): payload.immunizationRegistryStatus,
    (mapping.immunizationRegistryStatusEffectiveDate): parseDate(payload.immunizationRegistryStatusEffectiveDate),
    (mapping.publicityCodeEffectiveDate): parseDate(payload.publicityCodeEffectiveDate),
    (mapping.militaryBranch): payload.militaryBranch,
    (mapping.militaryRankGrade): payload.militaryRankGrade,
    (mapping.militaryStatus): payload.militaryStatus
}
}

var inputData = {
  "2": result.PD1."2" default "",
  "3": result.PD1."3" default "",
  "4": result.PD1."4" default "",
  "5": result.PD1."5" default "",
  "6": result.PD1."6" default "",
  "7": result.PD1."7" default "",
  "8": result.PD1."8" default "",
  "9": result.PD1."9" default "",
  "10": result.PD1."2" default "",
  "11": result.PD1."11" default "",
  "12":{
      "12.1": result.PD1."12.1" default "",
      "12.2": result.PD1."12.2" default "",
      "12.3": result.PD1."12.3"  default ""
  },
  "13": result.PD1."13" default "",
  "14": result.PD1."14" default "",
  "15": result.PD1."15" default "",
  "16": result.PD1."16" default "",
  "17": result.PD1."17" default "",
  "18": result.PD1."18" default "",
  "19": result.PD1."19" default "",
  "20": result.PD1."20" default "",
  "21": result.PD1."21" default "",
  "22": result.PD1."22" default "",
}
---
hl7("PD1",inputData)