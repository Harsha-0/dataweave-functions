%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var PD1="PD1|:livingDependency:|:livingArrangement:|:patientPrimaryFacility:|:patientPrimaryCareProvider:|:studentIndicator:|:handicap:|:livingWillCode:|:organDonorCode:|:separateBill:|:duplicatePatient:|:publicityCode.id:^:publicityCode.description:^:publicityCode.code:|::protectionIndicator:|:protectionIndicatorEffectiveDate:|:placeOfWorship:|:advanceDirectiveCode:|::immunizationRegistryStatus:|:immunizationRegistryStatusEffectiveDate:|:publicityCodeEffectiveDate:|:militaryBranch:|:militaryRankGrade:|:militaryStatus:|"

fun pd1(data) = PD1
replace ":livingDependency:" with (data.livingDependency default "")
replace ":livingArrangement:" with (data.livingArrangement default "")
replace ":patientPrimaryFacility:" with (data.patientPrimaryFacility default "")
replace ":patientPrimaryCareProvider:" with (data.patientPrimaryCareProvider default "")
replace ":studentIndicator:" with (data.studentIndicator default "")
replace ":handicap:" with (data.handicap default "")
replace ":livingWillCode:" with (data.livingWillCode default "")
replace ":organDonorCode:" with (data.organDonorCode default "")
replace ":separateBill:" with (data.separateBill default "")
replace ":duplicatePatient:" with (data.duplicatePatient default "")
replace ":publicityCode.id:" with (data.publicityCode.id default "")
replace ":publicityCode.description:" with (data.publicityCode.description default "")
replace ":publicityCode.code:" with (data.publicityCode.code default "")
replace "::protectionIndicator:" with (data.protectionIndicator default "")
replace ":protectionIndicatorEffectiveDate:" with (parseDate(data.protectionIndicatorEffectiveDate) default "")
replace ":placeOfWorship:" with (data.placeOfWorship default "")
replace ":advanceDirectiveCode:" with (data.advanceDirectiveCode default "")
replace "::immunizationRegistryStatus:" with (data.immunizationRegistryStatus default "")
replace ":immunizationRegistryStatusEffectiveDate:" with (parseDate(data.immunizationRegistryStatusEffectiveDate) default "")
replace ":publicityCodeEffectiveDate:" with (parseDate(data.publicityCodeEffectiveDate) default "")
replace ":militaryBranch:" with (data.militaryBranch default "")
replace ":militaryRankGrade:" with (data.militaryRankGrade default "")
replace ":militaryStatus:" with (data.militaryStatus default "")
---
pd1(payload)