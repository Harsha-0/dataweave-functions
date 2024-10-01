%dw 2.0
output application/json
import * from dw::core::Strings
import try from dw::Runtime

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

fun segmentBuild(data) = data match  {
   case is Object -> valuesOf(data) joinBy "^"
   case is Array -> (data reduce ((item, acc = "") -> (acc) ++ "~" ++ segmentBuild(item) ))substringAfter "~"
   case is String -> data
   else -> ""
}

fun hl7(header,details) = header ++ "|" ++ ((valuesOf(details)) map (segmentBuild ($)) joinBy "|")

var result = {
    "IN1": {
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
    (mapping.planEffectiveDate): parseDate(payload.planEffectiveDate),
    (mapping.planExpirationDate): parseDate(payload.planExpirationDate),
    (mapping.authorizationInformation): payload.authorizationInformation,
    (mapping.planType): payload.planType,
    (mapping.nameOfInsured): payload.nameOfInsured,
    (mapping.insuredsRelationshipToPatient): payload.insuredsRelationshipToPatient,
    (mapping.insuredDateOfBirth): parseDate(payload.insuredDateOfBirth),
    (mapping.insuredsAddress): payload.insuredsAddress,
    (mapping.assignmentOfBenefits): payload.assignmentOfBenefits,
    (mapping.coordinationOfBenefits): payload.coordinationOfBenefits,
    (mapping.coordOfBenPriority): payload.coordOfBenPriority,
    (mapping.noticeOfAdmissionFlag): payload.noticeOfAdmissionFlag,
    (mapping.noticeOfAdmissionDate): parseDate(payload.noticeOfAdmissionDate),
    (mapping.reportOfEligibilityFlag): payload.reportOfEligibilityFlag,
    (mapping.reportOfEligibilityDate): parseDate(payload.reportOfEligibilityDate),
    (mapping.releaseInformationCode): payload.releaseInformationCode,
    (mapping.preAdmitCert): payload.preAdmitCert,
    (mapping.verificationDateTime): parseDate(payload.verificationDateTime),
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
    (mapping.signatureCodeDate): parseDate(payload.signatureCodeDate),
    (mapping.insuredsBirthPlace): payload.insuredsBirthPlace,
    (mapping.vipIndicator): payload.vipIndicator
}
}

var inputData = {
  "2": result.IN1."2" default "",
  "3": result.IN1."3" default "",
  "4": result.IN1."4" default "",
  "5": result.IN1."5" default "",
  "6": result.IN1."6" default "",
  "7": result.IN1."7" default "",
  "8": result.IN1."8" default "",
  "9": result.IN1."9" default "",
  "10": result.IN1."10" default "",
  "11": result.IN1."11" default "",
  "12": result.IN1."12" default "",
  "13": result.IN1."13" default "",
  "14": result.IN1."14" default "",
  "15": result.IN1."15" default "",
  "16": result.IN1."16" default "",
  "17": result.IN1."17" default "",
  "18": result.IN1."18" default "",
  "19": result.IN1."19" default "",
  "20": result.IN1."20" default "",
  "21": result.IN1."21" default "",
  "22": result.IN1."22" default "",
  "23": result.IN1."23" default "",
  "24": result.IN1."24" default "",
  "25": result.IN1."25" default "",
  "26": result.IN1."26" default "",
  "27": result.IN1."27" default "",
  "28": result.IN1."28" default "",
  "29": result.IN1."29" default "",
  "30": result.IN1."30" default "",
  "31": result.IN1."31" default "",
  "32": result.IN1."32" default "",
  "33": result.IN1."33" default "",
  "34": result.IN1."34" default "",
  "35": result.IN1."35" default "",
  "36": result.IN1."36" default "",
  "37": result.IN1."37" default "",
  "38": result.IN1."38" default "",
  "39": result.IN1."39" default "",
  "40": result.IN1."40" default "",
  "41": result.IN1."41" default "",
  "42": result.IN1."42" default "",
  "43": result.IN1."43" default "",
  "44": result.IN1."44" default "",
  "45": result.IN1."45" default "",
  "46": result.IN1."46" default "",
  "47": result.IN1."47" default "",
  "48": result.IN1."48" default "",
  "49": result.IN1."49" default "",
  "50": result.IN1."50" default "",
  "51": result.IN1."51" default "",
  "52": result.IN1."52" default "",
  "53": result.IN1."53" default "",
  "54": result.IN1."54" default ""
}
---
hl7("IN1",inputData)