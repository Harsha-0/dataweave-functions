%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date


var IN1="IN1|:setId:|:insurancePlanId:|:insuranceCompanyId:|:insuranceCompanyName:|:insuranceCompanyAddress:|:insuranceCoContactPerson:|:insuranceCoPhoneNumber:|:groupNumber:|:groupName:|:insuredsGroupEmpId:|:insuredsGroupEmpName:|:planEffectiveDate:|:planExpirationDate:|:authorizationInformation:|:planType:|:nameOfInsured:|:insuredsRelationshipToPatient:|:insuredDateOfBirth:|:insuredsAddress:|:assignmentOfBenefits:|:coordinationOfBenefits:|:coordOfBenPriority:|:noticeOfAdmissionFlag:|:noticeOfAdmissionDate:|:reportOfEligibilityFlag:|:reportOfEligibilityDate:|:releaseInformationCode:|:preAdmitCert:|:verificationDateTime:|:verificationBy:|:typeOfAgreementCode:|:billingStatus:|:lifetimeReserveDays:|:delayBeforeLRDay:|:companyPlanCode:|:policyNumber:|:policyDeductible:|:policyLimitAmount:|:roomRateSemiPrivate:|:roomRatePrivate:|:insuredsEmploymentStatus:|:insuredsAdministrativeSex:|:insuredsEmployersAddress:|:verificationStatus:|:priorInsurancePlanID:|:coverageType:|:handicap:|:insuredsIDNumber:|:signatureCode:|:signatureCodeDate:|:insuredsBirthPlace:|:vipIndicator:|"

fun in1(data) =IN1 
replace ":setId:" with (data.setId default "")
replace ":insurancePlanId:" with (data.insurancePlanId default "")
replace ":insuranceCompanyId:" with (data.insuranceCompanyId default "")
replace ":insuranceCompanyName:" with (data.insuranceCompanyName default "")
replace ":insuranceCompanyAddress:" with (data.insuranceCompanyAddress default "")
replace ":insuranceCoContactPerson:" with (data.insuranceCoContactPerson default "")
replace ":insuranceCoPhoneNumber:" with (data.insuranceCoPhoneNumber default "")
replace ":groupNumber:" with (data.groupNumber default "")
replace ":groupName:" with (data.groupName default "")
replace ":insuredsGroupEmpId:" with (data.insuredsGroupEmpId default "")
replace ":insuredsGroupEmpName:" with (data.insuredsGroupEmpNam default "")
replace ":planEffectiveDate:" with (parseDate(data.planEffectiveDate) default "")
replace ":planExpirationDate:" with (parseDate(data.planExpirationDate) default "")
replace ":authorizationInformation:" with (data.authorizationInformation default "")
replace ":planType:" with (data.planType  default "")
replace ":nameOfInsured:" with (data.nameOfInsured default "")
replace ":insuredsRelationshipToPatient:" with (data.insuredsRelationshipToPatient default "")
replace ":insuredDateOfBirth:" with (data.insuredDateOfBirth default "")
replace ":insuredsAddress:" with (data.insuredsAddress default "")
replace ":assignmentOfBenefits:" with (data.assignmentOfBenefits default "")
replace ":coordinationOfBenefits:" with (data.coordinationOfBenefits default "")
replace ":coordOfBenPriority:" with (data.coordOfBenPriority default "")
replace ":noticeOfAdmissionFlag:" with (data.noticeOfAdmissionFlag default "")
replace ":noticeOfAdmissionDate:" with (parseDate(data.noticeOfAdmissionDate) default "")
replace ":reportOfEligibilityFlag:" with (data.reportOfEligibilityFlag default "")
replace ":reportOfEligibilityDate:" with (parseDate(data.reportOfEligibilityDate) default "")
replace ":releaseInformationCode:" with (data.releaseInformationCode default "")
replace ":preAdmitCert:" with (data.preAdmitCert default "")
replace ":verificationDateTime:" with (parseDate(data.verificationDateTime) default "")
replace ":verificationBy:" with (data.verificationBy default "")
replace ":typeOfAgreementCode:" with (data.typeOfAgreementCode default "")
replace ":billingStatus:" with (data.billingStatus default "")
replace ":lifetimeReserveDays:" with (data.lifetimeReserveDays default "")
replace ":delayBeforeLRDay:" with (data.delayBeforeLRDay default "")
replace ":companyPlanCode:" with (data.companyPlanCode default "")
replace ":policyNumber:" with (data.policyNumber default "")
replace ":policyDeductible:" with (data.policyDeductible default "")
replace ":policyLimitAmount:" with (data.policyLimitAmount default "")
replace ":policyLimitDays:" with (data.policyLimitDays default "")
replace ":roomRateSemiPrivate:" with (data.roomRateSemiPrivate default "")
replace ":roomRatePrivate:" with (data.roomRatePrivate default "")
replace ":insuredsEmploymentStatus:" with (data.insuredsEmploymentStatus default "")
replace ":insuredsAdministrativeSex:" with (data.insuredsAdministrativeSex default "")
replace ":insuredsEmployersAddress:" with (data.insuredsEmployersAddress default "")
replace ":verificationStatus:" with (data.verificationStatus default "")
replace ":priorInsurancePlanID:" with (data.priorInsurancePlanID default "")
replace ":coverageType:" with (data.coverageType default "")
replace ":handicap:" with (data.handicap default "")
replace ":insuredsIDNumber:" with (data.insuredsIDNumber default "")
replace ":signatureCode:" with (data.signatureCode default "")
replace ":signatureCodeDate:" with (data.signatureCodeDate default "")
replace ":insuredsBirthPlace:" with (data.insuredsBirthPlace default "")
replace ":vipIndicator:" with (data.vipIndicator default "")
---
in1(payload)