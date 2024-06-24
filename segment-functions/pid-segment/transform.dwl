%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var PID ="PID|:setId:|:patientId:|:id.value:^^^:id.code:^:identifierCode:|:alternatePatientId:|:patientName.firstName:^:patientName.middleName:^:patientName.lastName:^^^^:patientName.code:|:mothersMaidenName.firstName:^:mothersMaidenName.lastName:|:dateOfBirth:|:administrativeSex:|:patientAlias:|:race.code:^:race.description:^:race.id:^|:patientAddressArray:|:countyCode:|:telecomArray:|:phoneNumberBusiness:|:primaryLanguage.id:^:primaryLanguage.name:^:primaryLanguage.code:|:maritalStatus:|:religion:|:patientAccountNumber:|:ssnNumber:|:driversLicenseNumber:|:mothersIdentifier:|:ethnicGroup.code:^:ethnicGroup.description:^:ethnicGroup.id:|:birthPlace:|:multipleBirthIndicator:|:birthOrder:|:citizenship:|:veteransMilitaryStatus:|:nationality:|:patientDeathDateAndTime:|:patientDeathIndicator:|:identityUnknownIndicator:|:identityRelaibilityCode:|:lastUpdateDateTime:|:lastUpdateFacility:|:speciesCode:|:breedCode:|:strain:|:productionClassCode:|:tribalCitizenship:|"

fun pid (data) = PID 
replace ":setId:" with (data.setId default "")
replace ":patientId:" with (data.patientId default "")
replace ":id.value:" with (data.id.value default "") 
replace ":id.code:" with (data.id.code default "")
replace ":identifierCode:" with (data.identifierCode default "")
replace ":alternatePatientId:" with (data.alternatePatientId default "")
replace ":patientName.firstName:" with (data.patientName.firstName default "")
replace ":patientName.middleName:" with (data.patientName.middleName default "")
replace ":patientName.lastName:" with (data.patientName.lastName default "")
replace ":patientName.code:" with (data.patientName.code default "")
replace ":mothersMaidenName.firstName:" with (data.mothersMaidenName.firstName default "")
replace ":mothersMaidenName.lastName:" with (data.mothersMaidenName.lastName default "")
replace ":dateOfBirth:" with (parseDate(data.dateOfBirth  default  ""))
replace ":administrativeSex:" with (data.administrativeSex default "")
replace ":patientAlias:" with (data.patientAlias default "")
replace ":race.code:" with (data.race.code default "")
replace ":race.description:" with (data.race.description default "")
replace ":race.id:" with (data.race.id default "")
replace ":patientAddressArray:" with (address((data.patientAddress default [])))
replace ":countyCode:" with (data.countyCode default "")
replace ":telecomArray:" with telephone((data.telecom default []))
replace ":phoneNumberBusiness:" with (data.phoneNumberBusiness default "")
replace ":primaryLanguage.id:" with( data.primaryLanguage.id default "")
replace ":primaryLanguage.name:" with (data.primaryLanguage.name default "")
replace ":primaryLanguage.code:" with (data.primaryLanguage.code default "")
replace ":maritalStatus:" with (data.maritalStatus default "")
replace ":religion:" with (data.religion default "")
replace ":patientAccountNumber:" with (data.patientAccountNumber default "")
replace ":ssnNumber:" with (data.ssnNumber default "")
replace ":driversLicenseNumber:" with (data.driversLicenseNumber default "")
replace ":mothersIdentifier:" with (data.mothersIdentifier default "")
replace ":ethnicGroup.code:" with (data.ethnicGroup.code default "")
replace ":ethnicGroup.description:" with (data.ethnicGroup.description default "")
replace ":ethnicGroup.id:" with (data.ethnicGroup.id default "")
replace ":birthPlace:" with (data.birthPlace default "")
replace ":multipleBirthIndicator:" with (data.multipleBirthIndicator default "")
replace ":birthOrder:" with (data.birthOrder default "")
replace ":citizenship:" with (data.citizenship default "")
replace ":veteransMilitaryStatus:" with (data.veteransMilitaryStatus default "")
replace ":nationality:" with (data.nationality default "")
replace ":patientDeathDateAndTime:" with (parseDate((data.patientDeathDateAndTime default "")))
replace ":patientDeathIndicator:" with (data.patientDeathIndicator default "")
replace ":identityUnknownIndicator:" with (data.identityUnknownIndicator default "")
replace ":identityRelaibilityCode:" with (data.identityRelaibilityCode default "")
replace ":lastUpdateDateTime:" with (parseDate((data.lastUpdateDateTime default "")))
replace ":lastUpdateFacility:" with (data.lastUpdateFacility default "")
replace ":speciesCode:" with (data.speciesCode default "")
replace ":breedCode:" with (data.breedCode default "")
replace ":strain:" with (data.strain default "")
replace ":productionClassCode:" with (data.productionClassCode default "")
replace ":tribalCitizenship:" with (data.tribalCitizenship default "")
---
pid(payload)