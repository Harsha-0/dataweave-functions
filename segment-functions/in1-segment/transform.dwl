%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date


var IN1="IN1|:setId:|:insurancePlanId:|:insuranceCompanyId:|:insuranceCompanyName:|:insuranceCompanyAddress:|:insuranceCoContactPerson:|:insuranceCoPhoneNumber:|:groupNumber:|:groupName:|:insuredsGroupEmpId:|:insuredsGroupEmpName:|:planEffectiveDate:|:planExpirationDate:|:authorizationInformation:|:planType:|:nameOfInsured:|:insuredsRelationshipToPatient:|:insuredDateOfBirth:|:insuredsAddress:|:assignmentOfBenefits:|:coordinationOfBenefits:|:coordOfBenPriority:|:noticeOfAdmissionFlag:|:noticeOfAdmissionDate:|:reportOfEligibilityFlag:|:reportOfEligibilityDate:|:releaseInformationCode:|:preAdmitCert:|:verificationDateTime:|:verificationBy:|:typeOfAgreementCode:|:billingStatus:|:lifetimeReserveDays:|:delayBeforeLRDay:|:companyPlanCode:|:policyNumber:|:policyDeductible:|:policyLimitAmount:|:roomRateSemiPrivate:|:roomRatePrivate:|:insuredsEmploymentStatus:|:insuredsAdministrativeSex:|:insuredsEmployersAddress:|:verificationStatus:|:priorInsurancePlanID:|:coverageType:|:handicap:|:insuredsIDNumber:|:signatureCode:|:signatureCodeDate:|:insuredsBirthPlace:|:vipIndicator:|"

var result ={
    (mapping.setId): payload.setId,
    (mapping.insurancePlanId): payload.insurancePlanId,
    (mapping.insuranceCompanyId): payload.insuranceCompanyId,
    (mapping.insuranceCompanyName): payload.insuranceCompanyName,
    (mapping.insuranceCompanyAddress): payload.insuranceCompanyAddress,
    (mapping.insuranceCoContactPerson): payload.insuranceCoContactPerson,
    (mapping.insuranceCoPhoneNumber): payload.insuranceCoPhoneNumber,
    (mapping.groupNumber): payload.groupNumber,
    (mapping.groupName): payload.groupName,
    (mapping.insuredsGroupEmpId): payload.insuredsGroupEmpId,
    (mapping.insuredsGroupEmpNam): payload.insuredsGroupEmpNam,
    (mapping.planEffectiveDate): payload.planEffectiveDate,
    (mapping.planExpirationDate): payload.planExpirationDate,
    (mapping.authorizationInformation): payload.authorizationInformation,
    (mapping.planType): payload.planType,
    (mapping.nameOfInsured): payload.nameOfInsured,
    (mapping.insuredsRelationshipToPatient): payload.insuredsRelationshipToPatient,
    (mapping.insuredDateOfBirth): payload.insuredDateOfBirth,
    (mapping.insuredsAddress): payload.insuredsAddress,
    (mapping.assignmentOfBenefits): payload.assignmentOfBenefits,
    (mapping.coordinationOfBenefits): payload.coordinationOfBenefits,
    (mapping.coordOfBenPriority): payload.coordOfBenPriority,
    (mapping.noticeOfAdmissionFlag): payload.noticeOfAdmissionFlag,
    (mapping.noticeOfAdmissionDate): payload.noticeOfAdmissionDate,
    (mapping.reportOfEligibilityFlag): payload.reportOfEligibilityFlag,
    (mapping.reportOfEligibilityDate): payload.reportOfEligibilityDate,
    (mapping.releaseInformationCode): payload.releaseInformationCode,
    (mapping.preAdmitCert): payload.preAdmitCert,
    (mapping.verificationDateTime): payload.verificationDateTime,
    (mapping.verificationBy): payload.verificationBy,
    (mapping.typeOfAgreementCode): payload.typeOfAgreementCode,
    (mapping.billingStatus): payload.billingStatus,
    (mapping.lifetimeReserveDays): payload.lifetimeReserveDays,
    (mapping.delayBeforeLRDay): payload.delayBeforeLRDay,
    (mapping.companyPlanCode): payload.companyPlanCode,
    (mapping.policyNumber): payload.policyNumber,
    (mapping.policyDeductible): payload.policyDeductible,
    (mapping.policyLimitAmount): payload.policyLimitAmount,
    (mapping.policyLimitDays): payload.policyLimitDays,
    (mapping.roomRateSemiPrivate): payload.roomRateSemiPrivate,
    (mapping.roomRatePrivate): payload.roomRatePrivate,
    (mapping.insuredsEmploymentStatus): payload.insuredsEmploymentStatus,
    (mapping.insuredsAdministrativeSex): payload.insuredsAdministrativeSex,
    (mapping.insuredsEmployersAddress): payload.insuredsEmployersAddress,
    (mapping.verificationStatus): payload.verificationStatus,
    (mapping.priorInsurancePlanID): payload.priorInsurancePlanID,
    (mapping.coverageType): payload.coverageType,
    (mapping.handicap): payload.handicap,
    (mapping.insuredsIDNumber): payload.insuredsIDNumber,
    (mapping.signatureCode): payload.signatureCode,
    (mapping.signatureCodeDate): payload.signatureCodeDate,
    (mapping.insuredsBirthPlace): payload.insuredsBirthPlace,
    (mapping.vipIndicator): payload.vipIndicator
}



fun in1(data) =IN1 
replace ":setId:" with (data."2" default "")
replace ":insurancePlanId:" with (data."3" default "")
replace ":insuranceCompanyId:" with (data."4" default "")
replace ":insuranceCompanyName:" with (data."5" default "")
replace ":insuranceCompanyAddress:" with (data."6" default "")
replace ":insuranceCoContactPerson:" with (data."7" default "")
replace ":insuranceCoPhoneNumber:" with (data."8" default "")
replace ":groupNumber:" with (data."9" default "")
replace ":groupName:" with (data."10" default "")
replace ":insuredsGroupEmpId:" with (data."11" default "")
replace ":insuredsGroupEmpName:" with (data."12" default "")
replace ":planEffectiveDate:" with (parseDate(data."13") default "")
replace ":planExpirationDate:" with (parseDate(data."14") default "")
replace ":authorizationInformation:" with (data."15" default "")
replace ":planType:" with (data."16"  default "")
replace ":nameOfInsured:" with (data."17" default "")
replace ":insuredsRelationshipToPatient:" with (data."18" default "")
replace ":insuredDateOfBirth:" with (data."19" default "")
replace ":insuredsAddress:" with (data."20" default "")
replace ":assignmentOfBenefits:" with (data."21" default "")
replace ":coordinationOfBenefits:" with (data."22" default "")
replace ":coordOfBenPriority:" with (data."23" default "")
replace ":noticeOfAdmissionFlag:" with (data."24" default "")
replace ":noticeOfAdmissionDate:" with (parseDate(data."25") default "")
replace ":reportOfEligibilityFlag:" with (data."26" default "")
replace ":reportOfEligibilityDate:" with (parseDate(data."27") default "")
replace ":releaseInformationCode:" with (data."28" default "")
replace ":preAdmitCert:" with (data."29" default "")
replace ":verificationDateTime:" with (parseDate(data."30") default "")
replace ":verificationBy:" with (data."31" default "")
replace ":typeOfAgreementCode:" with (data."32" default "")
replace ":billingStatus:" with (data."33" default "")
replace ":lifetimeReserveDays:" with (data."34" default "")
replace ":delayBeforeLRDay:" with (data."35" default "")
replace ":companyPlanCode:" with (data."36" default "")
replace ":policyNumber:" with (data."37" default "")
replace ":policyDeductible:" with (data."38" default "")
replace ":policyLimitAmount:" with (data."39" default "")
replace ":policyLimitDays:" with (data."40" default "")
replace ":roomRateSemiPrivate:" with (data."41" default "")
replace ":roomRatePrivate:" with (data."42" default "")
replace ":insuredsEmploymentStatus:" with (data."43" default "")
replace ":insuredsAdministrativeSex:" with (data."44" default "")
replace ":insuredsEmployersAddress:" with (data."45" default "")
replace ":verificationStatus:" with (data."46" default "")
replace ":priorInsurancePlanID:" with (data."47" default "")
replace ":coverageType:" with (data."48" default "")
replace ":handicap:" with (data."49" default "")
replace ":insuredsIDNumber:" with (data."50" default "")
replace ":signatureCode:" with (data."51" default "")
replace ":signatureCodeDate:" with (data."52" default "")
replace ":insuredsBirthPlace:" with (data."53" default "")
replace ":vipIndicator:" with (data."54" default "")
---
in1(result)