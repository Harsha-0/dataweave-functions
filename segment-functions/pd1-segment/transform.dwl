%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var PD1="PD1|:livingDependency:|:livingArrangement:|:patientPrimaryFacility:|:patientPrimaryCareProvider:|:studentIndicator:|:handicap:|:livingWillCode:|:organDonorCode:|:separateBill:|:duplicatePatient:|:publicityCode.id:^:publicityCode.description:^:publicityCode.code:|::protectionIndicator:|:protectionIndicatorEffectiveDate:|:placeOfWorship:|:advanceDirectiveCode:|::immunizationRegistryStatus:|:immunizationRegistryStatusEffectiveDate:|:publicityCodeEffectiveDate:|:militaryBranch:|:militaryRankGrade:|:militaryStatus:|"

var result = {
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
    publicityCode :{
        (mapping.publicityCode.id): payload.publicityCode.id,
        (mapping.publicityCode.description): payload.publicityCode.description,
        (mapping.publicityCode.code): payload.publicityCode.code
    },
    (mapping.protectionIndicator): payload.protectionIndicator,
    (mapping.protectionIndicatorEffectiveDate): payload.protectionIndicatorEffectiveDate,
    (mapping.placeOfWorship): payload.placeOfWorship,
    (mapping.advanceDirectiveCode): payload.advanceDirectiveCode,
    (mapping.immunizationRegistryStatus): payload.immunizationRegistryStatus,
    (mapping.immunizationRegistryStatusEffectiveDate): payload.immunizationRegistryStatusEffectiveDate,
    (mapping.publicityCodeEffectiveDate): payload.publicityCodeEffectiveDate,
    (mapping.militaryBranch): payload.militaryBranch,
    (mapping.militaryRankGrade): payload.militaryRankGrade,
    (mapping.militaryStatus): payload.militaryStatus
}

fun pd1(data) = PD1
replace ":livingDependency:" with (data."2" default "")
replace ":livingArrangement:" with (data."3" default "")
replace ":patientPrimaryFacility:" with (data."4" default "")
replace ":patientPrimaryCareProvider:" with (data."5" default "")
replace ":studentIndicator:" with (data."6" default "")
replace ":handicap:" with (data."7" default "")
replace ":livingWillCode:" with (data."8" default "")
replace ":organDonorCode:" with (data."9" default "")
replace ":separateBill:" with (data."10" default "")
replace ":duplicatePatient:" with (data."11" default "")
replace ":publicityCode.id:" with (data.publicityCode."12.1" default "")
replace ":publicityCode.description:" with (data.publicityCode."12.2" default "")
replace ":publicityCode.code:" with (data.publicityCode."12.3" default "")
replace "::protectionIndicator:" with (data."13" default "")
replace ":protectionIndicatorEffectiveDate:" with (parseDate(data."14") default "")
replace ":placeOfWorship:" with (data."15" default "")
replace ":advanceDirectiveCode:" with (data."16" default "")
replace "::immunizationRegistryStatus:" with (data."17" default "")
replace ":immunizationRegistryStatusEffectiveDate:" with (parseDate(data."18") default "")
replace ":publicityCodeEffectiveDate:" with (parseDate(data."19") default "")
replace ":militaryBranch:" with (data."20" default "")
replace ":militaryRankGrade:" with (data."21" default "")
replace ":militaryStatus:" with (data."22" default "")
---
pd1(result)