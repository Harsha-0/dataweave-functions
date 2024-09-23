%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date



var ORC = "ORC|::orderControl:|:placerOrderNumber:^:placerOrderId:^:placerOrderCode:^:placerOrderIdentifier:|:fillerOrderNumber.entityIdentifier:^:fillerOrderNumber.name:^:fillerOrderNumber.universalId:^:fillerOrderNumber.uidType:|:placerGroupNumber:|::orderStatus:|:responseFlag:|:quantityTiming:|:parent:|:dateTimeOfTransaction:|:enteredBy.id:^:enteredBy.firstName:^:enteredBy.lastName:|:verifiedBy:|:provider.id:^:provider.firstName:^:provider.lastName:|:enterersLocation:|:callBackPhoneNumber:|:orderEffectiveDateTime:|:orderControlCodeReason:|:enteringOrganization:|:enteringDevice:|:actionBy:|:advancedBeneficiaryNoticeCode:|:orderingFacilityName.name:^:orderingFacilityName.codeType:^:orderingFacilityName.code:^:orderingFacilityName.uidType:^:orderingFacilityName.universalId:|:orderingFacilityAddressArray:|:orderingFacilityPhoneNumber:|:orderingProviderAddress:|:orderStatusModifier:|:advancedBeneficiaryNoticeOverrideReason:|:fillersExpectedAvailabilityDateTime:|:confidentialityCode:|:orderType:|:entererAuthorizationMode:|:universalServiceidentifier:|"

var RXA = "RXA|:giveSubIDCounter:|:administrationSubIDCounter:|:dateTimeStartOfAdministration:|:dateTimeEndOfAdministration:|:administeredCode.id:^:administeredCode.description:^:administeredCode.code:|:administeredAmount:|:administeredUnits.code:^:administeredUnits.unit:^:administeredUnits.id:|:administeredDosageForm:|:administrationNotes.id:^:administrationNotes.name:^:administrationNotes.code:|:administeringProvider:|^^^:administeredatLocation:|:administeredPer:|::administeredStrength:|:administeredStrengthUnits:|:substanceLotNumber:|:substanceExpirationDate:|:substanceManufacturerName.id:^:substanceManufacturerName.name:^:substanceManufacturerName.code:|:substanceTreatmentRefusalReason:|:indication:|:CompletionStatus:|:actionCode:|:systemEntryDateTime:|::administeredDrugStrengthVolume:|:administeredDrugStrengthVolumeUnits:|:administeredBarcodeIdentifier:|:pharmacyOrderType:|"

var result = {
    (mapping.giveSubIDCounter): payload.giveSubIDCounter,
    (mapping.administrationSubIDCounter): payload.administrationSubIDCounter,
    (mapping.dateTimeStartOfAdministration): payload.dateTimeStartOfAdministration,
    (mapping.dateTimeEndOfAdministration): payload.dateTimeEndOfAdministration,
    administeredCode: {
        (mapping.administeredCode.id): payload.administeredCode.id,
        (mapping.administeredCode.description): payload.administeredCode.description,
        (mapping.administeredCode.code): payload.administeredCode.code
    },
    (mapping.administeredAmount): payload.administeredAmount,
    administeredUnits: {
        (mapping.administeredUnits.code): payload.administeredUnits.code,
        (mapping.administeredUnits.unit): payload.administeredUnits.unit,
        (mapping.administeredUnits.id): payload.administeredUnits.id
    },
    (mapping.administeredDosageForm): payload.administeredDosageForm,
    administrationNotes: {
        (mapping.administrationNotes.id): payload.administrationNotes.id,
        (mapping.administrationNotes.name): payload.administrationNotes.name,
        (mapping.administrationNotes.code): payload.administrationNotes.code
    },
    (mapping.administeringProvider): payload.administeringProvider,
    (mapping.administeredAtLocation): payload.administeredAtLocation,
    (mapping.administeredPer): payload.administeredPer,
    (mapping.administeredStrength): payload.administeredStrength,
    (mapping.administeredStrengthUnits): payload.administeredStrengthUnits,
    (mapping.substanceLotNumber): payload.substanceLotNumber,
    (mapping.substanceExpirationDate): payload.substanceExpirationDate,
    substanceManufacturerName: {
        (mapping.substanceManufacturerName.id): payload.substanceManufacturerName.id,
        (mapping.substanceManufacturerName.name): payload.substanceManufacturerName.name,
        (mapping.substanceManufacturerName.code): payload.substanceManufacturerName.code
    },
    (mapping.substanceTreatmentRefusalReason): payload.substanceTreatmentRefusalReason,
    (mapping.indication): payload.indication,
    (mapping.CompletionStatus): payload.CompletionStatus,
    (mapping.actionCode): payload.actionCode,
    (mapping.systemEntryDateTime): payload.systemEntryDateTime,
    (mapping.administeredDrugStrengthVolume): payload.administeredDrugStrengthVolume,
    (mapping.administeredDrugStrengthVolumeUnits): payload.administeredDrugStrengthVolumeUnits,
    (mapping.administeredBarcodeIdentifier): payload.administeredBarcodeIdentifier,
    (mapping.pharmacyOrderType): payload.pharmacyOrderType
}
fun rxa(data)=RXA
replace ":giveSubIDCounter:" with (data."2" default "")
replace ":administrationSubIDCounter:" with (data."3" default "")
replace ":dateTimeStartOfAdministration:" with (( parseDate(data."4")  default ""))
replace ":dateTimeEndOfAdministration:" with ((parseDate(data."5" )default ""))
replace ":administeredCode.id:" with( data.administeredCode."6.1" default "")
replace ":administeredCode.description:" with (data.administeredCode."6.2" default "")
replace ":administeredCode.code:" with (data.administeredCode."6.3" default "")
replace ":administeredAmount:" with (data."7" default "")
replace ":administeredUnits.code:" with (data.administeredUnits."8.1" default "")
replace ":administeredUnits.unit:" with (data.administeredUnits."8.2" default "")
replace ":administeredUnits.id:" with (data.administeredUnits."8.3" default "")
replace ":administeredDosageForm:" with (data."9" default "")
replace ":administrationNotes.id:" with (data.administrationNotes."10.1" default "")
replace ":administrationNotes.name:" with (data.administrationNotes."10.2" default "")
replace ":administrationNotes.code:" with (data.administrationNotes."10.3" default "")
replace ":administeringProvider:" with (data."11" default "")
replace ":administeredatLocation:" with (data."12" default "")
replace ":administeredPer:" with (data."13" default "")
replace "::administeredStrength:" with (data."14" default "")
replace ":administeredStrengthUnits:" with (data."15" default "")
replace ":substanceLotNumber:" with (data."16" default "")
replace ":substanceExpirationDate:" with ( parseDate(data."17")  default "")
replace ":substanceManufacturerName.id:" with (data.substanceManufacturerName."18.1" default "")
replace ":substanceManufacturerName.name:" with (data.substanceManufacturerName."18.2" default "")
replace ":substanceManufacturerName.code:" with (data.substanceManufacturerName."18.3" default "")
replace ":substanceTreatmentRefusalReason:" with (data."19" default "")
replace ":indication:" with (data."20" default "")
replace ":CompletionStatus:" with (data."21" default "")
replace ":actionCode:" with (data."22" default "")
replace ":systemEntryDateTime:" with (data."23" default "")
replace "::administeredDrugStrengthVolume:" with (data."24" default "")
replace ":administeredDrugStrengthVolumeUnits:" with (data."25" default "")
replace ":administeredBarcodeIdentifier:" with (data."26" default "")
replace ":pharmacyOrderType:" with (data."27" default "")


---
rxa(result)