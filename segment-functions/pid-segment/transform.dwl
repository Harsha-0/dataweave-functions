%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var PID ="PID|:setId:|:patientId:|:id.value:^^^:id.code:^:identifierCode:|:alternatePatientId:|:patientName.firstName:^:patientName.middleName:^:patientName.lastName:^^^^:patientName.code:|:mothersMaidenName.firstName:^:mothersMaidenName.lastName:|:dateOfBirth:|:administrativeSex:|:patientAlias:|:race.code:^:race.description:^:race.id:^|:patientAddressArray:|:countyCode:|:telecomArray:|:phoneNumberBusiness:|:primaryLanguage.id:^:primaryLanguage.name:^:primaryLanguage.code:|:maritalStatus:|:religion:|:patientAccountNumber:|:ssnNumber:|:driversLicenseNumber:|:mothersIdentifier:|:ethnicGroup.code:^:ethnicGroup.description:^:ethnicGroup.id:|:birthPlace:|:multipleBirthIndicator:|:birthOrder:|:citizenship:|:veteransMilitaryStatus:|:nationality:|:patientDeathDateAndTime:|:patientDeathIndicator:|:identityUnknownIndicator:|:identityRelaibilityCode:|:lastUpdateDateTime:|:lastUpdateFacility:|:speciesCode:|:breedCode:|:strain:|:productionClassCode:|:tribalCitizenship:|"

var result = {
    (mapping.setId): payload.setId,
    (mapping.patientId): payload.patientId,
    id: {
        (mapping.id.value): payload.id.value,
        (mapping.id.code): payload.id.code
    },
    (mapping.identifierCode): payload.identifierCode,
    (mapping.alternatePatientId): payload.alternatePatientId,
    patientName: {
        (mapping.patientName.firstName): payload.patientName.firstName,
        (mapping.patientName.middleName): payload.patientName.middleName,
        (mapping.patientName.lastName): payload.patientName.lastName,
        (mapping.patientName.code): payload.patientName.code
    },
    mothersMaidenName: {
        (mapping.mothersMaidenName.firstName): payload.mothersMaidenName.firstName,
        (mapping.mothersMaidenName.lastName): payload.mothersMaidenName.lastName
    },
    (mapping.dateOfBirth): payload.dateOfBirth,
    (mapping.administrativeSex): payload.administrativeSex,
    (mapping.patientAlias): payload.patientAlias,
    race: {
        (mapping.race.code): payload.race.code,
        (mapping.race.description): payload.race.description,
        (mapping.race.id): payload.race.id
    },
    (mapping.countyCode): payload.countyCode,
    (mapping.phoneNumberBusiness): payload.phoneNumberBusiness,
    primaryLanguage: {
        (mapping.primaryLanguage.id): payload.primaryLanguage.id,
        (mapping.primaryLanguage.name): payload.primaryLanguage.name,
        (mapping.primaryLanguage.code): payload.primaryLanguage.code
    },
    (mapping.maritalStatus): payload.maritalStatus,
    (mapping.religion): payload.religion,
    (mapping.patientAccountNumber): payload.patientAccountNumber,
    (mapping.ssnNumber): payload.ssnNumber,
    (mapping.driversLicenseNumber): payload.driversLicenseNumber,
    (mapping.mothersIdentifier): payload.mothersIdentifier,
    ethnicGroup: {
        (mapping.ethnicGroup.code): payload.ethnicGroup.code,
        (mapping.ethnicGroup.description): payload.ethnicGroup.description,
        (mapping.ethnicGroup.id): payload.ethnicGroup.id
    },
    (mapping.birthPlace): payload.birthPlace,
    (mapping.multipleBirthIndicator): payload.multipleBirthIndicator,
    (mapping.birthOrder): payload.birthOrder,
    (mapping.citizenship): payload.citizenship,
    (mapping.veteransMilitaryStatus): payload.veteransMilitaryStatus,
    (mapping.nationality): payload.nationality,
    (mapping.patientDeathDateAndTime): payload.patientDeathDateAndTime,
    (mapping.patientDeathIndicator): payload.patientDeathIndicator,
    (mapping.identityUnknownIndicator): payload.identityUnknownIndicator,
    (mapping.identityReliabilityCode): payload.identityReliabilityCode,
    (mapping.lastUpdateDateTime): payload.lastUpdateDateTime,
    (mapping.lastUpdateFacility): payload.lastUpdateFacility,
    (mapping.speciesCode): payload.speciesCode,
    (mapping.breedCode): payload.breedCode,
    (mapping.strain): payload.strain,
    (mapping.productionClassCode): payload.productionClassCode,
    (mapping.tribalCitizenship): payload.tribalCitizenship
}


fun pid (data) = PID 
replace ":setId:" with (data."2" default "")
replace ":patientId:" with (data."3" default "")
replace ":id.value:" with (data.id."4.1" default "") 
replace ":id.code:" with (data.id."4.2" default "")
replace ":identifierCode:" with (data."5" default "")
replace ":alternatePatientId:" with (data."6" default "")
replace ":patientName.firstName:" with (data.patientName."7.1" default "")
replace ":patientName.middleName:" with (data.patientName."7.2" default "")
replace ":patientName.lastName:" with (data.patientName."7.3" default "")
replace ":patientName.code:" with (data.patientName."7.4" default "")
replace ":mothersMaidenName.firstName:" with (data.mothersMaidenName."8.1" default "")
replace ":mothersMaidenName.lastName:" with (data.mothersMaidenName."8.2" default "")
replace ":dateOfBirth:" with (parseDate(data."9"  default  ""))
replace ":administrativeSex:" with (data."10" default "")
replace ":patientAlias:" with (data."11" default "")
replace ":race.code:" with (data.race."12.1" default "")
replace ":race.description:" with (data.race."12.2" default "")
replace ":race.id:" with (data.race."12.3" default "")
replace ":patientAddressArray:" with (address(payload.patientAddress) default []) 
replace ":countyCode:" with (data."14" default "")
replace ":telecomArray:" with telephone((payload.telecom default []))
replace ":phoneNumberBusiness:" with (data."16" default "")
replace ":primaryLanguage.id:" with( data.primaryLanguage."17.1" default "")
replace ":primaryLanguage.name:" with (data.primaryLanguage."17.2" default "")
replace ":primaryLanguage.code:" with (data.primaryLanguage."17.3" default "")
replace ":maritalStatus:" with (data."18" default "")
replace ":religion:" with (data."19" default "")
replace ":patientAccountNumber:" with (data."20" default "")
replace ":ssnNumber:" with (data."21" default "")
replace ":driversLicenseNumber:" with (data."22" default "")
replace ":mothersIdentifier:" with (data."23" default "")
replace ":ethnicGroup.code:" with (data.ethnicGroup."24.1" default "")
replace ":ethnicGroup.description:" with (data.ethnicGroup."24.2" default "")
replace ":ethnicGroup.id:" with (data.ethnicGroup."24.3" default "")
replace ":birthPlace:" with (data."25" default "")
replace ":multipleBirthIndicator:" with (data."26" default "")
replace ":birthOrder:" with (data."27" default "")
replace ":citizenship:" with (data."28" default "")
replace ":veteransMilitaryStatus:" with (data."29" default "")
replace ":nationality:" with (data."30" default "")
replace ":patientDeathDateAndTime:" with (parseDate((data."31" default "")))
replace ":patientDeathIndicator:" with (data."32" default "")
replace ":identityUnknownIndicator:" with (data."33" default "")
replace ":identityRelaibilityCode:" with (data."34" default "")
replace ":lastUpdateDateTime:" with (parseDate((data."35" default "")))
replace ":lastUpdateFacility:" with (data."36" default "")
replace ":speciesCode:" with (data."37" default "")
replace ":breedCode:" with (data."38" default "")
replace ":strain:" with (data."39" default "")
replace ":productionClassCode:" with (data."40" default "")
replace ":tribalCitizenship:" with (data."41" default "")
---
pid(result)