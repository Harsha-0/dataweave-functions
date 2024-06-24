%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var OBX="OBX|:setId:|:valueType:|:observationIdentifier.id:^:observationIdentifier.description:^:observationIdentifier.code:^|:observationSubID:|:observationValue.id:^:observationValue.description:^:observationValue.code:|:units:|:referencesRange:|:abnormalFlags:|:probability:|:natureOfAbnormalTest:|:observationResultStatus:|:userDefinedAccessChecks:|:dateTimeOfTheObservation:|:producersReference:|:responsibleObserver:|:observationMethod.id:^:observationMethod.description:^:observationMethod.code:|:equipmentInstanceIdentifier:|:dateTimeOfTheAnalysis:|:reservedForHarmonizationWithV2.6:||:performingOrganizationName.name:^:performingOrganizationName.universalId:^:performingOrganizationName.uidType:^:performingOrganizationName.code:^:performingOrganizationName.identifier:|:performingOrganizationAddress:|:performingOrganizationMedicalDirector:|"

fun obx(data) =((OBX
replace ":setId:" with (data.setId default "")
replace ":valueType:" with (data.valueType default "")
replace ":observationIdentifier.id:" with (data.observationIdentifier.id default "")
replace ":observationIdentifier.description:" with (data.observationIdentifier.description default "")
replace ":observationIdentifier.code:" with (data.observationIdentifier.code default "")
replace ":observationSubID:" with (data.observationSubID default "")
replace ":observationValue.id:" with parseDate(data.observationValue.id default "")
replace "^:observationValue.description:" with (if(isEmpty(data.observationValue.description))"" else ("^" ++(data.observationValue.description default ""))))
replace "^:observationValue.code:" with (if(isEmpty(data.observationValue.code))"" else ("^"++(data.observationValue.code default ""))))
replace ":units:" with (data.units  default "")
replace ":referencesRange:" with (data.referencesRange  default "")
replace ":abnormalFlags:" with (data.abnormalFlags  default "")
replace ":probability:" with (data.probability  default "")
replace ":natureOfAbnormalTest:" with (data.natureOfAbnormalTest  default "")
replace ":observationResultStatus:" with (data.observationResultStatus default "")
replace ":userDefinedAccessChecks:" with (data.userDefinedAccessChecks  default "")
replace ":dateTimeOfTheObservation:" with (parseDate(data.dateTimeOfTheObservation default ""))
replace ":producersReference:" with (data.producersReference  default "")
replace ":responsibleObserver:" with (data.responsibleObserver  default "")
replace ":observationMethod.id:" with (data.observationMethod.id default "")
replace ":observationMethod.description:" with (data.observationMethod.description default "")
replace ":observationMethod.code:" with (data.observationMethod.code default "")
replace ":equipmentInstanceIdentifier:" with (data.equipmentInstanceIdentifier default "")
replace ":dateTimeOfTheAnalysis:" with (parseDate(data.dateTimeOfTheAnalysis default ""))
replace ":reservedForHarmonizationWithV2.6:" with (data.reservedForHarmonizationWithV26 default "")
replace ":performingOrganizationName.name:" with (data.performingOrganizationName.name  default "")
replace ":performingOrganizationName.codeType:" with (data.performingOrganizationName.codeType  default "")
replace ":performingOrganizationName.universalId:" with (data.performingOrganizationName.universalId  default "")
replace ":performingOrganizationName.uidType:" with (data.performingOrganizationName.uidType  default "")
replace ":performingOrganizationName.code:" with (data.performingOrganizationName.code  default "")
replace ":performingOrganizationName.identifier:" with (data.performingOrganizationName.identifier  default "")
replace ":performingOrganizationAddress:" with (data.performingOrganizationAddress default "")
replace ":performingOrganizationMedicalDirector:" with (data.performingOrganizationMedicalDirector default "")
---
obx(payload)