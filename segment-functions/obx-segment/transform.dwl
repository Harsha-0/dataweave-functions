%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var OBX="OBX|:setId:|:valueType:|:observationIdentifier.id:^:observationIdentifier.description:^:observationIdentifier.code:^|:observationSubID:|:observationValue.id:^:observationValue.description:^:observationValue.code:|:units:|:referencesRange:|:abnormalFlags:|:probability:|:natureOfAbnormalTest:|:observationResultStatus:|:effectiveDateOfReferenceRangeValues:|:userDefinedAccessChecks:|:dateTimeOfTheObservation:|:producersReference:|:responsibleObserver:|:observationMethod.id:^:observationMethod.description:^:observationMethod.code:|:equipmentInstanceIdentifier:|:dateTimeOfTheAnalysis:|:reservedForHarmonizationWithV2.6:||:performingOrganizationName.name:^:performingOrganizationName.universalId:^:performingOrganizationName.uidType:^:performingOrganizationName.code:^:performingOrganizationName.identifier:|:performingOrganizationAddress:|:performingOrganizationMedicalDirector:|"

var result = {
    (mapping.setId): payload.setId,
    (mapping.valueType): payload.valueType,
    observationIdentifier: {
        (mapping.observationIdentifier.id): payload.observationIdentifier.id,
        (mapping.observationIdentifier.description): payload.observationIdentifier.description,
        (mapping.observationIdentifier.code): payload.observationIdentifier.code
    },
    observationMethod: {
        (mapping.observationMethod.id): payload.observationMethod.id,
        (mapping.observationMethod.description): payload.observationMethod.description,
        (mapping.observationMethod.code): payload.observationMethod.code
    },
    observationValue: {
        (mapping.observationValue.id): payload.observationValue.id,
        (mapping.observationValue.description): payload.observationValue.description,
        (mapping.observationValue.code): payload.observationValue.code
    },
    (mapping.observationSubID): payload.observationSubID,
    (mapping.units): payload.units,
    (mapping.referencesRange): payload.referencesRange,
    (mapping.abnormalFlags): payload.abnormalFlags,
    (mapping.probability): payload.probability,
    (mapping.natureOfAbnormalTest): payload.natureOfAbnormalTest,
    (mapping.observationResultStatus): payload.observationResultStatus,
    (mapping.effectiveDateOfReferenceRangeValues): payload.effectiveDateOfReferenceRangeValues,
    (mapping.userDefinedAccessChecks): payload.userDefinedAccessChecks,
    (mapping.dateTimeOfTheObservation): payload.dateTimeOfTheObservation,
    (mapping.producersReference): payload.producersReference,
    (mapping.responsibleObserver): payload.responsibleObserver,
    (mapping.equipmentInstanceIdentifier): payload.equipmentInstanceIdentifier,
    (mapping.dateTimeOfTheAnalysis): payload.dateTimeOfTheAnalysis,
    (mapping."reservedForHarmonizationWithV2.6"): payload."reservedForHarmonizationWithV2.6",
    performingOrganizationName: {
        (mapping.performingOrganizationName.name): payload.performingOrganizationName.name,
        (mapping.performingOrganizationName.codeType): payload.performingOrganizationName.codeType,
        (mapping.performingOrganizationName.universalId): payload.performingOrganizationName.universalId,
        (mapping.performingOrganizationName.uidType): payload.performingOrganizationName.uidType,
        (mapping.performingOrganizationName.code): payload.performingOrganizationName.code,
        (mapping.performingOrganizationName.identifier): payload.performingOrganizationName.identifier
    },
    (mapping.performingOrganizationAddress): payload.performingOrganizationAddress,
    (mapping.performingOrganizationMedicalDirector): payload.performingOrganizationMedicalDirector
}
fun obx(data) =((OBX
replace ":setId:" with (data."2" default "")
replace ":valueType:" with (data."3" default "")
replace ":observationIdentifier.id:" with (data.observationIdentifier."4.1" default "")
replace ":observationIdentifier.description:" with (data.observationIdentifier."4.2" default "")
replace ":observationIdentifier.code:" with (data.observationIdentifier."4.3" default "")
replace ":observationSubID:" with (data."7" default "")
replace ":observationValue.id:" with parseDate(data.observationValue."6.1" default "")
replace "^:observationValue.description:" with (if(isEmpty(data.observationValue."6.2"))"" else ("^" ++(data.observationValue."6.2" default ""))))
replace "^:observationValue.code:" with (if(isEmpty(data.observationValue."6.3"))"" else ("^"++(data.observationValue."6.3" default ""))))
replace ":units:" with (data."8"  default "")
replace ":referencesRange:" with (data."9"  default "")
replace ":abnormalFlags:" with (data."10"  default "")
replace ":probability:" with (data."11"  default "")
replace ":natureOfAbnormalTest:" with (data."12"  default "")
replace ":observationResultStatus:" with (data."13" default "")
replace ":effectiveDateOfReferenceRangeValues:" with (data."14" default "")
replace ":userDefinedAccessChecks:" with (data."15"  default "")
replace ":dateTimeOfTheObservation:" with (parseDate(data."16" default ""))
replace ":producersReference:" with (data."17"  default "")
replace ":responsibleObserver:" with (data."18"  default "")
replace ":observationMethod.id:" with (data.observationMethod."5.1" default "")
replace ":observationMethod.description:" with (data.observationMethod."5.2" default "")
replace ":observationMethod.code:" with (data.observationMethod."5.3" default "")
replace ":equipmentInstanceIdentifier:" with (data."19" default "")
replace ":dateTimeOfTheAnalysis:" with (parseDate(data."20" default ""))
replace ":reservedForHarmonizationWithV2.6:" with (data."21" default "")
replace ":performingOrganizationName.name:" with (data.performingOrganizationName."22.1"  default "")
replace ":performingOrganizationName.codeType:" with (data.performingOrganizationName."22.2"  default "")
replace ":performingOrganizationName.universalId:" with (data.performingOrganizationName."22.3"  default "")
replace ":performingOrganizationName.uidType:" with (data.performingOrganizationName."22.4"  default "")
replace ":performingOrganizationName.code:" with (data.performingOrganizationName."22.5"  default "")
replace ":performingOrganizationName.identifier:" with (data.performingOrganizationName."22.6"  default "")
replace ":performingOrganizationAddress:" with (data."23" default "")
replace ":performingOrganizationMedicalDirector:" with (data."24" default "")
---
obx(result)