%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var SFT ="SFT|::organizationName:^:organizationNameTypeCode:^:idNumber:^:identifierCheckDigit:^:checkDigitScheme:^:assigningAuthority.namespaceId:&::assigningAuthority.universalId::assigningAuthority.universalIdType:^:organization.identifierTypeCode:^:assigningFacility:^:nameRepresentationCode:^:organizationIdentifier:|:softwareCertifiedVersionOrReleaseNumber:|:softwareProductName:|:softwareBinaryId:|:softwareProductInformation:|:softwareInstallDate:"

fun sft(data) = SFT
replace ":softwareVendorOrganization:" with (data.softwareVendorOrganization  default "")
replace "::organizationName:" with (data.organizationName  default "")
replace ":organizationNameTypeCode:" with (data.organizationNameTypeCode  default "")
replace ":idNumber:" with (data.idNumber  default "")
replace ":identifierCheckDigit:" with (data.identifierCheckDigit  default "")
replace ":checkDigitScheme:" with (data.checkDigitScheme  default "")
replace ":assigningAuthority.namespaceId:" with (data.assigningAuthority.namespaceId  default "")
replace "::assigningAuthority.universalId:" with (data.assigningAuthority.universalId  default "")
replace ":assigningAuthority.universalIdType:" with (data.assigningAuthority.universalIdType  default "")
replace ":organization.identifierTypeCode:" with (data.organization.identifierTypeCode  default "")
replace ":assigningFacility:" with (data.assigningFacility  default "")
replace ":nameRepresentationCode:" with (data.nameRepresentationCode  default "")
replace ":organizationIdentifier:" with (data.organizationIdentifier  default "")
replace ":softwareCertifiedVersionOrReleaseNumber:" with (data.softwareCertifiedVersionOrReleaseNumber  default "")
replace ":softwareProductName:" with (data.softwareProductName  default "")
replace ":softwareBinaryId:" with (data.softwareBinaryId  default "")
replace ":softwareProductInformation:" with (data.softwareProductInformation  default "")
replace ":softwareInstallDate:" with (parseDate(data.softwareInstallDate)  default "")
---
sft(payload)