%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var NK1 ="NK1|:setId:|:name.firstName:^:name.lastName:|:relationship.code:^:relationship.name:^:relationship.id:|:addressArray:|:phoneNumber:|:businessPhoneNumber:|:contactRole:|:startDate:|:endDate:|:nextOfKinAssociatedPartiesJobTitle:|:nextOfKinAssociatedPartiesJobCodeClass:|:nextOfKinAssociatedPartiesEmployeeNumber:|:nextOfKinAssociatedPartysIdentifiers:|:nextOfKinBirthPlace:|:organizationName:|:maritalStatus:|:administrativeSex:|:dateTimeOfBirth:|:livingDependency:|:ambulatoryStatus:|:citizenship:|:primaryLan:|:livingArrangement:|:publicityCode:|:protectionIndicator:|:studentIndicator:|:religion:|:mothersMaidenName:|:nationality:|:ethnicGroup:|:contactReason:|:contactPersonsName:|:contactPersonsTelephoneNumber:|:contactPersonsAddress:|:jobStatus:|:race:|:handicap:|:contactPersonSocialSecurityNumber:|:vipIndicator:|"

fun nk1(data) =NK1
replace ":setId:" with (data.setId  default "")
replace ":name.firstName:" with (data.name.firstName default "")
replace ":name.lastName:" with (data.name.lastName default "")
replace ":relationship.code:" with (data.relationship.code default "")
replace ":relationship.name:" with (data.relationship.name default "")
replace ":relationship.id:" with (data.relationship.id default "")
replace ":addressArray:" with address(data.address  default [])
replace ":phoneNumber:" with telephone((data.phoneNumber  default []))
replace ":businessPhoneNumber:" with (data.businessPhoneNumber default "")
replace ":contactRole:" with (data.contactRole default "")
replace ":startDate:" with (parseDate(data.startDate default "") )
replace ":endDate:" with (parseDate(data.endDate default ""))
replace ":nextOfKinAssociatedPartiesJobTitle:" with (data.nextOfKinAssociatedPartiesJobTitle default "")
replace ":nextOfKinAssociatedPartiesJobCodeClass:" with (data.nextOfKinAssociatedPartiesJobCodeClass default "")
replace ":nextOfKinAssociatedPartiesEmployeeNumber:" with (data.nextOfKinAssociatedPartiesEmployeeNumber default "")
replace ":nextOfKinAssociatedPartysIdentifiers:" with (data.nextOfKinAssociatedPartysIdentifiers default "")
replace ":nextOfKinBirthPlace:" with (data.nextOfKinBirthPlace default "")
replace ":organizationName:" with (data.organizationName default "")
replace ":maritalStatus:" with (data.maritalStatus default "")
replace ":administrativeSex:" with (data.administrativeSex default "")
replace ":dateTimeOfBirth:" with (parseDate(data.dateTimeOfBirth default "") )
replace ":livingDependency:" with (data.livingDependency default "")
replace ":ambulatoryStatus:" with (data.ambulatoryStatus default "")
replace ":citizenship:" with (data.citizenship default "")
replace ":primaryLan:" with (data.primaryLan default "")
replace ":livingArrangement:" with (data.livingArrangement default "")
replace ":publicityCode:" with (data.publicityCode default "")
replace ":protectionIndicator:" with (data.protectionIndicator default "")
replace ":studentIndicator:" with (data.studentIndicator default "")
replace ":religion:" with (data.religion default "")
replace ":mothersMaidenName:" with (data.mothersMaidenName default "")
replace ":nationality:" with (data.nationality default "")
replace ":ethnicGroup:" with (data.ethnicGroup default "")
replace ":contactReason:" with (data.contactReason default "")
replace ":contactPersonsName:" with (data.contactPersonsName default "")
replace ":contactPersonsTelephoneNumber:" with (data.contactPersonsTelephoneNumber default "")
replace ":contactPersonsAddress:" with (data.contactPersonsAddress default "")
replace ":jobStatus:" with (data.jobStatus default "")
replace ":race:" with (data.race default "")
replace ":handicap:" with (data.handicap default "")
replace ":contactPersonSocialSecurityNumber:" with (data.contactPersonSocialSecurityNumber default "")
replace ":vipIndicator:" with (data.vipIndicator default "")
---
nk1(payload)