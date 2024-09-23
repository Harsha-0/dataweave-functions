%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var NK1 ="NK1|:setId:|:name.firstName:^:name.lastName:|:relationship.code:^:relationship.name:^:relationship.id:|:addressArray:|:phoneNumber:|:businessPhoneNumber:|:contactRole:|:startDate:|:endDate:|:nextOfKinAssociatedPartiesJobTitle:|:nextOfKinAssociatedPartiesJobCodeClass:|:nextOfKinAssociatedPartiesEmployeeNumber:|:nextOfKinAssociatedPartysIdentifiers:|:nextOfKinBirthPlace:|:organizationName:|:maritalStatus:|:administrativeSex:|:dateTimeOfBirth:|:livingDependency:|:ambulatoryStatus:|:citizenship:|:primaryLan:|:livingArrangement:|:publicityCode:|:protectionIndicator:|:studentIndicator:|:religion:|:mothersMaidenName:|:nationality:|:ethnicGroup:|:contactReason:|:contactPersonsName:|:contactPersonsTelephoneNumber:|:contactPersonsAddress:|:jobStatus:|:race:|:handicap:|:contactPersonSocialSecurityNumber:|:vipIndicator:|"

var result = {
    (mapping.setId): payload.setId,
    name: {
        (mapping.name.firstName): payload.name.firstName,
        (mapping.name.lastName): payload.name.lastName
    },
    relationship: {
        (mapping.relationship.code): payload.relationship.code,
        (mapping.relationship.name): payload.relationship.name,
        (mapping.relationship.id): payload.relationship.id
    },
    (mapping.businessPhoneNumber): payload.businessPhoneNumber,
    (mapping.contactRole): payload.contactRole,
    (mapping.startDate): payload.startDate,
    (mapping.endDate): payload.endDate,
    (mapping.nextOfKinAssociatedPartiesJobTitle): payload.nextOfKinAssociatedPartiesJobTitle,
    (mapping.nextOfKinAssociatedPartiesJobCodeClass): payload.nextOfKinAssociatedPartiesJobCodeClass,
    (mapping.nextOfKinAssociatedPartiesEmployeeNumber): payload.nextOfKinAssociatedPartiesEmployeeNumber,
    (mapping.nextOfKinAssociatedPartysIdentifiers): payload.nextOfKinAssociatedPartysIdentifiers,
    (mapping.nextOfKinBirthPlace): payload.nextOfKinBirthPlace,
    (mapping.organizationName): payload.organizationName,
    (mapping.maritalStatus): payload.maritalStatus,
    (mapping.administrativeSex): payload.administrativeSex,
    (mapping.dateTimeOfBirth): payload.dateTimeOfBirth,
    (mapping.livingDependency): payload.livingDependency,
    (mapping.ambulatoryStatus): payload.ambulatoryStatus,
    (mapping.citizenship): payload.citizenship,
    (mapping.primaryLan): payload.primaryLan,
    (mapping.livingArrangement): payload.livingArrangement,
    (mapping.publicityCode): payload.publicityCode,
    (mapping.protectionIndicator): payload.protectionIndicator,
    (mapping.studentIndicator): payload.studentIndicator,
    (mapping.religion): payload.religion,
    (mapping.mothersMaidenName): payload.mothersMaidenName,
    (mapping.nationality): payload.nationality,
    (mapping.ethnicGroup): payload.ethnicGroup,
    (mapping.contactReason): payload.contactReason,
    (mapping.contactPersonsName): payload.contactPersonsName,
    (mapping.contactPersonsTelephoneNumber): payload.contactPersonsTelephoneNumber,
    (mapping.contactPersonsAddress): payload.contactPersonsAddress,
    (mapping.jobStatus): payload.jobStatus,
    (mapping.race): payload.race,
    (mapping.handicap): payload.handicap,
    (mapping.contactPersonSocialSecurityNumber): payload.contactPersonSocialSecurityNumber,
    (mapping.vipIndicator): payload.vipIndicator
}


fun nk1(data) =NK1
replace ":setId:" with (data."2"  default "")
replace ":name.firstName:" with (data.name."3.1" default "")
replace ":name.lastName:" with (data.name."3.2" default "")
replace ":relationship.code:" with (data.relationship."4.1" default "")
replace ":relationship.name:" with (data.relationship."4.2" default "")
replace ":relationship.id:" with (data.relationship."4.3" default "")
replace ":addressArray:" with address(payload.address  default [])
replace ":phoneNumber:" with telephone((payload.phoneNumber  default []))
replace ":businessPhoneNumber:" with (data."7" default "")
replace ":contactRole:" with (data."8" default "")
replace ":startDate:" with (parseDate(data."9" default "") )
replace ":endDate:" with (parseDate(data."10" default ""))
replace ":nextOfKinAssociatedPartiesJobTitle:" with (data."11" default "")
replace ":nextOfKinAssociatedPartiesJobCodeClass:" with (data."12" default "")
replace ":nextOfKinAssociatedPartiesEmployeeNumber:" with (data."13" default "")
replace ":nextOfKinAssociatedPartysIdentifiers:" with (data."14" default "")
replace ":nextOfKinBirthPlace:" with (data."15" default "")
replace ":organizationName:" with (data."16" default "")
replace ":maritalStatus:" with (data."17" default "")
replace ":administrativeSex:" with (data."18" default "")
replace ":dateTimeOfBirth:" with (parseDate(data."19" default "") )
replace ":livingDependency:" with (data."20" default "")
replace ":ambulatoryStatus:" with (data."21" default "")
replace ":citizenship:" with (data."22" default "")
replace ":primaryLan:" with (data."23" default "")
replace ":livingArrangement:" with (data."24" default "")
replace ":publicityCode:" with (data."25" default "")
replace ":protectionIndicator:" with (data."26" default "")
replace ":studentIndicator:" with (data."27" default "")
replace ":religion:" with (data."28" default "")
replace ":mothersMaidenName:" with (data."29" default "")
replace ":nationality:" with (data."30" default "")
replace ":ethnicGroup:" with (data."31" default "")
replace ":contactReason:" with (data."32" default "")
replace ":contactPersonsName:" with (data."33" default "")
replace ":contactPersonsTelephoneNumber:" with (data."34" default "")
replace ":contactPersonsAddress:" with (data."35" default "")
replace ":jobStatus:" with (data."36" default "")
replace ":race:" with (data."37" default "")
replace ":handicap:" with (data."38" default "")
replace ":contactPersonSocialSecurityNumber:" with (data."39" default "")
replace ":vipIndicator:" with (data."40" default "")
---
nk1(result)