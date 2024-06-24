%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date



var ORC = "ORC|::orderControl:|:placerOrderNumber:^:placerOrderId:^:placerOrderCode:^:placerOrderIdentifier:|:fillerOrderNumber.entityIdentifier:^:fillerOrderNumber.name:^:fillerOrderNumber.universalId:^:fillerOrderNumber.uidType:|:placerGroupNumber:|::orderStatus:|:responseFlag:|:quantityTiming:|:parent:|:dateTimeOfTransaction:|:enteredBy.id:^:enteredBy.firstName:^:enteredBy.lastName:|:verifiedBy:|:provider.id:^:provider.firstName:^:provider.lastName:|:enterersLocation:|:callBackPhoneNumber:|:orderEffectiveDateTime:|:orderControlCodeReason:|:enteringOrganization:|:enteringDevice:|:actionBy:|:advancedBeneficiaryNoticeCode:|:orderingFacilityName.name:^:orderingFacilityName.codeType:^:orderingFacilityName.code:^:orderingFacilityName.uidType:^:orderingFacilityName.universalId:|:orderingFacilityAddressArray:|:orderingFacilityPhoneNumber:|:orderingProviderAddress:|:orderStatusModifier:|:advancedBeneficiaryNoticeOverrideReason:|:fillersExpectedAvailabilityDateTime:|:confidentialityCode:|:orderType:|:entererAuthorizationMode:|:universalServiceidentifier:|"

var RXA = "RXA|:giveSubIDCounter:|:administrationSubIDCounter:|:dateTimeStartOfAdministration:|:dateTimeEndOfAdministration:|:administeredCode.id:^:administeredCode.description:^:administeredCode.code:|:administeredAmount:|:administeredUnits.code:^:administeredUnits.unit:^:administeredUnits.id:|:administeredDosageForm:|:administrationNotes.id:^:administrationNotes.name:^:administrationNotes.code:|:administeringProvider:|^^^:administeredatLocation:|:administeredPer:|::administeredStrength:|:administeredStrengthUnits:|:substanceLotNumber:|:substanceExpirationDate:|:substanceManufacturerName.id:^:substanceManufacturerName.name:^:substanceManufacturerName.code:|:substanceTreatmentRefusalReason:|:indication:|:CompletionStatus:|:actionCode:|:systemEntryDateTime:|::administeredDrugStrengthVolume:|:administeredDrugStrengthVolumeUnits:|:administeredBarcodeIdentifier:|:pharmacyOrderType:|"

fun rxa(data)=RXA
replace ":giveSubIDCounter:" with (data.giveSubIDCounter default "")
replace ":administrationSubIDCounter:" with (data.administrationSubIDCounter default "")
replace ":dateTimeStartOfAdministration:" with (( parseDate(data.dateTimeStartOfAdministration)  default ""))
replace ":dateTimeEndOfAdministration:" with ((parseDate(data.dateTimeEndOfAdministration )default ""))
replace ":administeredCode.id:" with( data.administeredCode.id default "")
replace ":administeredCode.description:" with (data.administeredCode.description default "")
replace ":administeredCode.code:" with (data.administeredCode.code default "")
replace ":administeredAmount:" with (data.administeredAmount default "")
replace ":administeredUnits.code:" with (data.administeredUnits.code default "")
replace ":administeredUnits.unit:" with (data.administeredUnits.unit default "")
replace ":administeredUnits.id:" with (data.administeredUnits.id default "")
replace ":administeredDosageForm:" with (data.administeredDosageForm default "")
replace ":administrationNotes.id:" with (data.administrationNotes.id default "")
replace ":administrationNotes.name:" with (data.administrationNotes.name default "")
replace ":administrationNotes.code:" with (data.administrationNotes.code default "")
replace ":administeringProvider:" with (data.administeringProvider default "")
replace ":administeredatLocation:" with (data.administeredatLocation default "")
replace ":administeredPer:" with (data.administeredPer default "")
replace "::administeredStrength:" with (data.administeredStrength default "")
replace ":administeredStrengthUnits:" with (data.administeredStrengthUnits default "")
replace ":substanceLotNumber:" with (data.substanceLotNumber default "")
replace ":substanceExpirationDate:" with ( parseDate(data.substanceExpirationDate)  default "")
replace ":substanceManufacturerName.id:" with (data.substanceManufacturerName.id default "")
replace ":substanceManufacturerName.name:" with (data.substanceManufacturerName.name default "")
replace ":substanceManufacturerName.code:" with (data.substanceManufacturerName.code default "")
replace ":substanceTreatmentRefusalReason:" with (data.substanceTreatmentRefusalReason default "")
replace ":indication:" with (data.indication default "")
replace ":CompletionStatus:" with (data.CompletionStatus default "")
replace ":actionCode:" with (data.actionCode default "")
replace ":systemEntryDateTime:" with (data.systemEntryDateTime default "")
replace "::administeredDrugStrengthVolume:" with (data.administeredDrugStrengthVolume default "")
replace ":administeredDrugStrengthVolumeUnits:" with (data.administeredDrugStrengthVolumeUnits default "")
replace ":administeredBarcodeIdentifier:" with (data.administeredBarcodeIdentifier default "")
replace ":pharmacyOrderType:" with (data.pharmacyOrderType default "")


---
rxa(payload)