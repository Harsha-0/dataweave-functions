%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date



var ORC = "ORC|::orderControl:|:placerOrderNumber:^:placerOrderId:^:placerOrderCode:^:placerOrderIdentifier:|:fillerOrderNumber.entityIdentifier:^:fillerOrderNumber.name:^:fillerOrderNumber.universalId:^:fillerOrderNumber.uidType:|:placerGroupNumber:|::orderStatus:|:responseFlag:|:quantityTiming:|:parent:|:dateTimeOfTransaction:|:enteredBy.id:^:enteredBy.firstName:^:enteredBy.lastName:|:verifiedBy:|:provider.id:^:provider.firstName:^:provider.lastName:|:enterersLocation:|:callBackPhoneNumber:|:orderEffectiveDateTime:|:orderControlCodeReason:|:enteringOrganization:|:enteringDevice:|:actionBy:|:advancedBeneficiaryNoticeCode:|:orderingFacilityName.name:^:orderingFacilityName.codeType:^:orderingFacilityName.code:^:orderingFacilityName.uidType:^:orderingFacilityName.universalId:|:orderingFacilityAddressArray:|:orderingFacilityPhoneNumber:|:orderingProviderAddress:|:orderStatusModifier:|:advancedBeneficiaryNoticeOverrideReason:|:fillersExpectedAvailabilityDateTime:|:confidentialityCode:|:orderType:|:entererAuthorizationMode:|:universalServiceidentifier:|"

fun orc(data) = ORC
replace "::orderControl:" with (data.orderControl default "")
replace ":placerOrderNumber:" with (data.placerOrderNumber.number default "")
replace ":placerOrderId:" with (data.placerOrderNumber.id default "")
replace ":placerOrderCode:" with (data.placerOrderNumber.code default "")
replace ":placerOrderIdentifier:" with (data.placerOrderNumber.identifier default "")
replace ":fillerOrderNumber.entityIdentifier:" with (data.fillerOrderNumber.entityIdentifier default "")
replace ":fillerOrderNumber.name:" with (data.fillerOrderNumber.name default "")
replace ":fillerOrderNumber.universalId:" with (data.fillerOrderNumber.universalId default "")
replace ":fillerOrderNumber.uidType:" with (data.fillerOrderNumber.uidType default "")
replace ":placerGroupNumber:" with (data.placerGroupNumber default "")
replace "::orderStatus:" with (data.orderStatus default "")
replace ":responseFlag:" with (data.responseFlag default "")
replace ":quantityTiming:" with (data.quantityTiming default "")
replace ":parent:" with (data.parent default "")
replace ":dateTimeOfTransaction:" with (parseDate(data.dateTimeOfTransaction default ""))
replace ":enteredBy.id:" with  (data.enteredBy.id default "")
replace ":enteredBy.firstName:" with (data.enteredBy.firstName default "")
replace ":enteredBy.lastName:" with (data.enteredBy.lastName default "")
replace ":verifiedBy:" with  (data.verifiedBy default "")
replace ":provider.id:" with (data.provider.id default "")
replace ":provider.firstName:" with (data.provider.firstName default "")
replace ":provider.lastName:" with (data.provider.lastName default "")
replace ":enterersLocation:" with (data.enterersLocation default "")
replace ":callBackPhoneNumber:" with telephone((data.callBackPhoneNumber default []))
replace ":orderEffectiveDateTime:" with (parseDate(data.orderEffectiveDateTime default ""))
replace ":orderControlCodeReason:" with (data.orderControlCodeReason default "")
replace ":enteringOrganization:" with (data.enteringOrganization default "")
replace ":enteringDevice:" with (data.enteringDevice default "")
replace ":actionBy:" with (data.actionBy default "")
replace ":advancedBeneficiaryNoticeCode:" with  (data.advancedBeneficiaryNoticeCode default "")
replace ":orderingFacilityName.name:" with  (data.orderingFacilityName.name default "")
replace ":orderingFacilityName.codeType:" with  (data.orderingFacilityName.codeType default "")
replace ":orderingFacilityName.code:" with  (data.orderingFacilityName.code default "")
replace ":orderingFacilityName.uidType:" with  (data.orderingFacilityName.uidType default "")
replace ":orderingFacilityName.universalId:" with  (data.orderingFacilityName.universalId default "")
replace ":orderingFacilityAddressArray:" with address((data.orderingFacilityAddress default []))
replace ":orderingFacilityPhoneNumber:" with (data.orderingFacilityPhoneNumber default "")
replace ":orderingProviderAddress:" with (data.orderingProviderAddress default "")
replace ":orderStatusModifier:" with (data.orderStatusModifier default "")
replace ":advancedBeneficiaryNoticeOverrideReason:" with (data.advancedBeneficiaryNoticeOverrideReason default "")
replace ":fillersExpectedAvailabilityDateTime:" with (parseDate(data.fillersExpectedAvailabilityDateTime default ""))
replace ":confidentialityCode:" with (data.confidentialityCode default "")
replace ":orderType:" with (data.orderType default "")
replace ":entererAuthorizationMode:" with (data.entererAuthorizationMode default "")
replace ":universalServiceidentifier:" with (data.universalServiceidentifier default "")

---
orc(payload)