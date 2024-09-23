%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var SFT ="SFT|::organizationName:^:organizationNameTypeCode:^:idNumber:^:identifierCheckDigit:^:checkDigitScheme:^:assigningAuthority.namespaceId:&::assigningAuthority.universalId::assigningAuthority.universalIdType:^:organization.identifierTypeCode:^:assigningFacility:^:nameRepresentationCode:^:organizationIdentifier:|:softwareCertifiedVersionOrReleaseNumber:|:softwareProductName:|:softwareBinaryId:|:softwareProductInformation:|:softwareInstallDate:"

var result = {
    (mapping.softwareVendorOrganization): payload.softwareVendorOrganization,
    (mapping.organizationName): payload.organizationName,
    (mapping.organizationNameTypeCode): payload.organizationNameTypeCode,
    (mapping.idNumber): payload.idNumber,
    (mapping.identifierCheckDigit): payload.identifierCheckDigit,
    (mapping.checkDigitScheme): payload.checkDigitScheme,
    assigningAuthority : {
        (mapping.assigningAuthority.namespaceId): payload.assigningAuthority.namespaceId,
        (mapping.assigningAuthority.universalId): payload.assigningAuthority.universalId,
        (mapping.assigningAuthority.universalIdType): payload.assigningAuthority.universalIdType
    },
    organization: {
        (mapping.organization.identifierTypeCode): payload.organization.identifierTypeCode
    },
    (mapping.assigningFacility): payload.assigningFacility,
    (mapping.nameRepresentationCode): payload.nameRepresentationCode,
    (mapping.organizationIdentifier): payload.organizationIdentifier,
    (mapping.softwareCertifiedVersionOrReleaseNumber): payload.softwareCertifiedVersionOrReleaseNumber,
    (mapping.softwareProductName): payload.softwareProductName,
    (mapping.softwareBinaryId): payload.softwareBinaryId,
    (mapping.softwareProductInformation): payload.softwareProductInformation,
    (mapping.softwareInstallDate): payload.softwareInstallDate
}

fun sft(data) = SFT
replace ":softwareVendorOrganization:" with (data."1"  default "")
replace "::organizationName:" with (data."2"  default "")
replace ":organizationNameTypeCode:" with (data."3"  default "")
replace ":idNumber:" with (data."4"  default "")
replace ":identifierCheckDigit:" with (data."5"  default "")
replace ":checkDigitScheme:" with (data."6"  default "")
replace ":assigningAuthority.namespaceId:" with (data.assigningAuthority."7.1"  default "")
replace "::assigningAuthority.universalId:" with (data.assigningAuthority."7.2"  default "")
replace ":assigningAuthority.universalIdType:" with (data.assigningAuthority."7.3"  default "")
replace ":organization.identifierTypeCode:" with (data.organization."8.1"  default "")
replace ":assigningFacility:" with (data."9"  default "")
replace ":nameRepresentationCode:" with (data."10"  default "")
replace ":organizationIdentifier:" with (data."11"  default "")
replace ":softwareCertifiedVersionOrReleaseNumber:" with (data."12"  default "")
replace ":softwareProductName:" with (data."13"  default "")
replace ":softwareBinaryId:" with (data."14"  default "")
replace ":softwareProductInformation:" with (data."15"  default "")
replace ":softwareInstallDate:" with (parseDate(data."16")  default "")
---
sft(result)