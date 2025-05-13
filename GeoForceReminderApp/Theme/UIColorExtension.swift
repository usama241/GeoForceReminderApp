//
//  UIColorExtension.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 12/07/2023.
//

import Foundation
import UIKit

fileprivate enum AppColor: String {
    case appFailureColor = "AppFailureColor"
    case appGrayTextColor = "AppGrayTextColor"
    case appGreenTextColor = "AppGreenTextColor"
    case appHelpingTextColor = "AppHelpingTextColor"
    case appPendingColor = "AppPendingColor"
    case appPlaceHolderColor = "AppPlaceHolderColor"
    case appPrimaryColor = "AppPrimaryColor"
    case appSuccessColor = "AppSuccessColor"
    case appTextColor = "AppTextColor"
    case appBorderThemeColor = "AppBordorThemeColor"
    case appShadowColor = "AppShadowColor"
    case appLightThemeColor = "AppLightThemeColor"
    case appDisabledButtonColor = "AppDisabledButtonColor"
    case appButtonBorderColor = "AppButtonBorderColor"
    case appBackgroundColor = "AppBackgroundColor"
    case appTabBarUnselectedColor = "AppTabBarUnselectedColor"
    case appGrayButtonBorderColor = "AppGrayButtonBorderColor"
    case appHeadingTextColor = "AppHeadingTextColor"
    case appWhiteTextColor = "AppWhiteTextColor"
    case appPinkBorderColor = "AppPinkBorderColor"
    case appPinkColor = "AppPinkColor"
    case appPageSelectedColor = "AppPageSelectedColor"
    case appPageUnselectedColor = "AppPageUnselectedColor"
    case appBadgeColor = "AppBadgeColor"
    case appCellBorderColor = "AppCellBorderColor"
    case appSegmentedBackgroundColor = "AppSegmentedBackgroundColor"
    case appSegmentedBorderColor = "AppSegmentedBorderColor"
    case appAccountBackgroundColor = "AppAccountBackgroundColor"
    case appAccountBorderColor = "AppAccountBorderColor"
    case appSearchTextBackgroundColor = "AppSearchTextBackgroundColor"
    case appPrimaryButtonBorderColor = "AppPrimaryButtonBorderColor"
    case appSecondaryButtonColor = "AppSecondaryButtonColor"
    case appSupportButtonBorderColor = "AppSupportButtonBorderColor"
    case appToggleoffTintColor = "AppToggleoffTintColor"
    case appChangeLanguageButtonColor = "AppChangeLanguageButtonColor"
    case appSwitchOffThumbTintColor = "AppSwitchOffThumbTintColor"
    case appSwitchTintColor = "AppSwitchTintColor"
    case appHomeTransTitleColor = "AppHomeTransTitleColor"
    case appHomeOrderTextColor = "AppHomeOrderTextColor"
    case appTextfieldColor = "appTextfieldColor"
    case appLightOrangeColor = "AppLightOrange"
    case appLightBlueColor = "AppLightBlue"
    case appTextLinkColor = "AppTextLinkColor"
    case appTextFieldPlaceholderColor = "AppTextFieldPlaceholderColor"
    case appOverlayColor = "AppOverlayColor"
    case appBackgroundReverseColor = "AppBackgroundReverseColor"
    case appFilterButtonColor = "AppFilterButtonColor"
    case appFilterButtonSelectedColor = "AppFilterButtonSelectedColor"
    case appTransactionLimitTextColor = "AppTransactionLimitTextColor"
    case appNotificationCellBackgroundColor = "AppNotificationCellBackgroundColor"
    case appPostpaidAmountButtonBackgroundColor = "AppPostpaidAmountButtonBackgroundColor"
    case chartLineColor = "ChartLineColor"
    case chartLineGradient1Color = "ChartLineGradient1Color"
    case chartLineGradient2Color = "ChartLineGradient2Color"
    case chartLineCircleColor = "ChartLineCircleColor"
    case appProfileCopyButtonColor = "AppProfileCopyButtonColor"
    case appDebitOnboardingButtonTextColor = "AppDebitOnboardingButtonTextColor"
    case appGrayLabelColor = "AppGrayLabelColor"
    case appHighlightedLabelColor = "AppHighlightedLabelColor"

    case mFundsCashoutButtonSelectBackColor = "MFundsCashoutButtonSelectBackColor"
    case mFundsCashoutButtonSelectBorderColor = "MFundsCashoutButtonSelectBorderColor"
    case mFundsCashoutButtonUnselectBackColor = "MFundsCashoutButtonUnselectBackColor"
    case mFundsCashoutButtonUnselectBorderColor = "MFundsCashoutButtonUnselectBorderColor"
    
    case mFundsInvestButtonDisableBGcolor = "MFundsInvestButtonDisableBGcolor"
    case mFundsInvestButtonDisableBorderColor = "MFundsInvestButtonDisableBorderColor"

    case appCellBadgeBorderColor = "AppCellBadgeBorderColor"
    case appSliderDefaultColor = "AppSliderDefaultColor"
    case appBlueIconColor = "AppBlueIconColor"
    case appPendingLightColor = "AppPendingLightColor"
    case tint1 = "tint1"
    case ColorA5A5A5 = "ColorA5A5A5"
    case primaryColor = "ColorBorder"
    case TextFieldBorderColor = "TextFieldBorderColor"
    case errorColor = "errorColor"
    case secondaryColor = "secondaryColor"
    case tint4 = "tint4"
    case Color868686 = "Color868686"
//    case ColorBorder = "ColorBorder"
    case TextColor1 = "textColor1"
    case ColorFFFFFF = "ColorFFFFFF"
    case AppBgColor = "AppBgColor"
    case ColorTabbar = "ColorTabbar"
    case Color444444 = "Color444444"
    case Color4A943C = "Color4A943C"
    case Color111941 = "Color111941"
    case Color7CAF17 = "Color7CAF17"
    case TFPlaceHolderColor = "TFPlaceHolderColor"
    case GradientStart = "GradientStart"
    case Gradientend = "Gradientend"
    case Color2B2B32 = "Color2B2B32"
    case ColorA4CB39 = "ColorA4CB39"
    case Color99D81C = "Color99D81C"

}


extension UIColor {
    static var appLightOrangeColor: UIColor {
        return UIColor(named: AppColor.appLightOrangeColor.rawValue)!
    }
    static var appBackgroundReverseColor: UIColor {
        return UIColor(named: AppColor.appBackgroundReverseColor.rawValue)!
    }
    static var appLightBlueColor: UIColor {
        return UIColor(named: AppColor.appLightBlueColor.rawValue)!
    }
    static var appFailureColor: UIColor {
        return UIColor(named: AppColor.appFailureColor.rawValue)!
    }
    static var appTextfieldColor: UIColor {
        return UIColor(named: AppColor.appTextfieldColor.rawValue)!
    }
    static var appGrayTextColor: UIColor {
        return UIColor(named: AppColor.appGrayTextColor.rawValue)!
    }
    
    static var appGreenTextColor: UIColor {
        return UIColor(named: AppColor.appGreenTextColor.rawValue)!
    }
    
    static var appHelpingTextColor: UIColor {
        return UIColor(named: AppColor.appHelpingTextColor.rawValue)!
    }
    
    static var appPendingColor: UIColor {
        return UIColor(named: AppColor.appPendingColor.rawValue)!
    }
    
    static var appPlaceHolderColor: UIColor {
        return UIColor(named: AppColor.appPlaceHolderColor.rawValue)!
    }
    
    static var appPrimaryColor: UIColor {
        let color = UIColor(named: AppColor.appPrimaryColor.rawValue)!
        return color
    }
    
    static var appSuccessColor: UIColor {
        return UIColor(named: AppColor.appSuccessColor.rawValue)!
    }
    
    static var chartLineColor: UIColor {
        return UIColor(named: AppColor.chartLineColor.rawValue)!
    }
    
    static var ChartLineGradient1Color: UIColor {
        return UIColor(named: AppColor.chartLineGradient1Color.rawValue)!
    }
    
    static var ChartLineGradient2Color: UIColor {
        return UIColor(named: AppColor.chartLineGradient2Color.rawValue)!
    }
    
    static var chartLineCircleColor: UIColor {
        return UIColor(named: AppColor.chartLineCircleColor.rawValue)!
    }
    
    static var appTextColor: UIColor {
        return UIColor(named: AppColor.appTextColor.rawValue)!
    }
    
    static var appBorderThemeColor: UIColor {
        return UIColor(named: AppColor.appBorderThemeColor.rawValue)!
    }
    
    static var appShadowColor: UIColor {
        return UIColor(named: AppColor.appShadowColor.rawValue)!
    }
    
    static var appLightThemeColor: UIColor {
        return UIColor(named: AppColor.appLightThemeColor.rawValue)!
    }
    static var appDisabledButtonColor: UIColor {
        return UIColor(named: AppColor.appDisabledButtonColor.rawValue)!
    }
    static var appButtonBorderColor: UIColor {
        return UIColor(named: AppColor.appButtonBorderColor.rawValue)!
    }
    
    static var appBackgroundColor: UIColor {
        return UIColor(named: AppColor.appBackgroundColor.rawValue)!
    }
    
    static var appTabBarUnselectedColor: UIColor {
        return UIColor(named: AppColor.appTabBarUnselectedColor.rawValue)!
    }
    
    static var appGrayButtonBorderColor: UIColor {
        return UIColor(named: AppColor.appGrayButtonBorderColor.rawValue)!
    }
    
    static var appHeadingTextColor: UIColor {
        return UIColor(named: AppColor.appHeadingTextColor.rawValue)!
    }
    
    static var appWhiteTextColor: UIColor {
        return UIColor(named: AppColor.appWhiteTextColor.rawValue)!
    }
    static var appPinkBorderColor: UIColor {
        return UIColor(named: AppColor.appPinkBorderColor.rawValue)!
    }
    static var appPinkColor: UIColor {
        return UIColor(named: AppColor.appPinkColor.rawValue)!
    }
    static var appPageSelectedColor: UIColor {
        return UIColor(named: AppColor.appPageSelectedColor.rawValue)!
    }
    
    static var appPageUnselectedColor: UIColor {
        return UIColor(named: AppColor.appPageUnselectedColor.rawValue)!
    }
    
    static var appSegmentedBackgroundColor: UIColor {
        return UIColor(named: AppColor.appSegmentedBackgroundColor.rawValue)!
    }
    
    static var appSegmentedBorderColor: UIColor {
        return UIColor(named: AppColor.appSegmentedBorderColor.rawValue)!
    }
    
    static var appBadgeColor: UIColor {
        return UIColor(named: AppColor.appBadgeColor.rawValue)!
    }
    
    static var appCellBorderColor: UIColor {
        return UIColor(named: AppColor.appCellBorderColor.rawValue)!
    }
    static var appAccountBackgroundColor: UIColor {
        return UIColor(named: AppColor.appAccountBackgroundColor.rawValue)!
    }
    static var appAccountBorderColor: UIColor {
        return UIColor(named: AppColor.appAccountBorderColor.rawValue)!
    }
    static var appSearchTextBackgroundColor: UIColor {
        return UIColor(named: AppColor.appSearchTextBackgroundColor.rawValue)!
    }
    
    static var appPrimaryButtonBorderColor: UIColor {
        return UIColor(named: AppColor.appPrimaryButtonBorderColor.rawValue)!
    }
    
    static var appSecondaryButtonColor: UIColor {
        return UIColor(named: AppColor.appSecondaryButtonColor.rawValue)!
    }

    static var appSupportButtonBorderColor: UIColor {
        return UIColor(named: AppColor.appSupportButtonBorderColor.rawValue)!
    }
    static var appToggleoffTintColor: UIColor {
        return UIColor(named: AppColor.appToggleoffTintColor.rawValue)!
    }
    static var appChangeLanguageButtonColor: UIColor {
        return UIColor(named: AppColor.appChangeLanguageButtonColor.rawValue)!
    }
    static var appSwitchOffThumbTintColor: UIColor {
        return UIColor(named: AppColor.appSwitchOffThumbTintColor.rawValue)!
    }
    static var appSwitchTintColor: UIColor {
        return UIColor(named: AppColor.appSwitchTintColor.rawValue)!
    }
    static var appHomeTransTitleColor: UIColor {
        return UIColor(named: AppColor.appHomeTransTitleColor.rawValue)!
    }
    static var appHomeOrderTextColor: UIColor {
        return UIColor(named: AppColor.appHomeOrderTextColor.rawValue)!
    }
    static var appFilterButtonColor: UIColor {
        return UIColor(named: AppColor.appFilterButtonColor.rawValue)!
    }
    static var appFilterButtonSelectedColor: UIColor {
        return UIColor(named: AppColor.appFilterButtonSelectedColor.rawValue)!
    }
    
    static var appTextLinkColor: UIColor {
        return UIColor(named: AppColor.appTextLinkColor.rawValue)!
    }
    static var appTextFieldPlaceholderColor: UIColor {
        return UIColor(named: AppColor.appTextFieldPlaceholderColor.rawValue)!
    }
    static var appOverlayColor: UIColor {
        return UIColor(named: AppColor.appOverlayColor.rawValue)!
    }
    static var appTransactionLimitTextColor: UIColor {
        return UIColor(named: AppColor.appTransactionLimitTextColor.rawValue)!
    }
    static var appNotificationCellBackgroundColor: UIColor {
        return UIColor(named: AppColor.appNotificationCellBackgroundColor.rawValue)!
    }
    static var appPostpaidAmountButtonBackgroundColor: UIColor {
        return UIColor(named: AppColor.appPostpaidAmountButtonBackgroundColor.rawValue)!
    }
    
    static var appProfileCopyButtonColor: UIColor {
        return UIColor(named: AppColor.appProfileCopyButtonColor.rawValue)!
    }
    
    static var appDebitOnboardingButtonTextColor: UIColor {
        return UIColor(named: AppColor.appDebitOnboardingButtonTextColor.rawValue)!
    }
    
    static var appGrayLabelColor: UIColor {
        return UIColor(named: AppColor.appGrayLabelColor.rawValue)!
    }
    
    static var appHighlightedLabelColor: UIColor {
        return UIColor(named: AppColor.appHighlightedLabelColor.rawValue)!
    }
    
    static var mFundsCashoutButtonSelectBackColor: UIColor {
        return UIColor(named: AppColor.mFundsCashoutButtonSelectBackColor.rawValue)!
    }
    
    static var mFundsCashoutButtonSelectBorderColor: UIColor {
        return UIColor(named: AppColor.mFundsCashoutButtonSelectBorderColor.rawValue)!
    }
    
    static var mFundsCashoutButtonUnselectBackColor: UIColor {
        return UIColor(named: AppColor.mFundsCashoutButtonUnselectBackColor.rawValue)!
    }
    
    static var mFundsCashoutButtonUnselectBorderColor: UIColor {
        return UIColor(named: AppColor.mFundsCashoutButtonUnselectBorderColor.rawValue)!
    }
    
//    static var mFundsInvestButtonDisableBGcolor: UIColor {
//        return UIColor(named: AppColor.mFundsInvestButtonDisableBGcolor.rawValue)!
//    }
    
    static var mFundsInvestButtonDisableBorderColor: UIColor {
        return UIColor(named: AppColor.mFundsInvestButtonDisableBorderColor.rawValue)!
    }
    
    static var appCellBadgeBorderColor: UIColor {
        return UIColor(named: AppColor.appCellBadgeBorderColor.rawValue)!
    }
    
    static var appSliderDefaultColor: UIColor {
        return UIColor(named: AppColor.appSliderDefaultColor.rawValue)!
    }
    
    static var appBlueIconColor: UIColor {
        return UIColor(named: AppColor.appBlueIconColor.rawValue)!
    }
    
    static var appPendingLightColor: UIColor {
        return UIColor(named: AppColor.appPendingLightColor.rawValue)!
    }
    
    static var tint1: UIColor {
        return UIColor(named: AppColor.tint1.rawValue)!
    }

    static var ColorA5A5A5: UIColor {
        return UIColor(named: AppColor.ColorA5A5A5.rawValue)!
    }

    static var primaryColor: UIColor {
        return UIColor(named: AppColor.primaryColor.rawValue)!
    }

    static var TextFieldBorderColor: UIColor {
        return UIColor(named: AppColor.TextFieldBorderColor.rawValue)!
    }

    static var errorColor: UIColor {
        return UIColor(named: AppColor.errorColor.rawValue)!
    }

    static var secondaryColor: UIColor {
        return UIColor(named: AppColor.secondaryColor.rawValue)!
    }

    static var tint4: UIColor {
        return UIColor(named: AppColor.tint4.rawValue)!
    }

    static var Color868686: UIColor {
        return UIColor(named: AppColor.Color868686.rawValue)!
    }

//    static var ColorBorder: UIColor {
//        return UIColor(named: AppColor.ColorBorder.rawValue)!
//    }

    static var TextColor1: UIColor {
        return UIColor(named: AppColor.TextColor1.rawValue)!
    }

    static var ColorFFFFFF: UIColor {
        return UIColor(named: AppColor.ColorFFFFFF.rawValue)!
    }

    static var AppBgColor: UIColor {
        return UIColor(named: AppColor.AppBgColor.rawValue)!
    }

    static var ColorTabbar: UIColor {
        return UIColor(named: AppColor.ColorTabbar.rawValue)!
    }

    static var Color444444: UIColor {
        return UIColor(named: AppColor.Color444444.rawValue)!
    }

    static var Color4A943C: UIColor {
        return UIColor(named: AppColor.Color4A943C.rawValue)!
    }

    static var Color111941: UIColor {
        return UIColor(named: AppColor.Color111941.rawValue)!
    }

    static var Color7CAF17: UIColor {
        return UIColor(named: AppColor.Color7CAF17.rawValue)!
    }

    static var TFPlaceHolderColor: UIColor {
        return UIColor(named: AppColor.TFPlaceHolderColor.rawValue)!
    }

    static var GradientStart: UIColor {
        return UIColor(named: AppColor.GradientStart.rawValue)!
    }

    static var Gradientend: UIColor {
        return UIColor(named: AppColor.Gradientend.rawValue)!
    }

    static var Color2B2B32: UIColor {
        return UIColor(named: AppColor.Color2B2B32.rawValue)!
    }

    static var ColorA4CB39: UIColor {
        return UIColor(named: AppColor.ColorA4CB39.rawValue)!
    }

    static var Color99D81C: UIColor {
        return UIColor(named: AppColor.Color99D81C.rawValue)!
    }

}

extension UIColor {
    public convenience init?(rgbaHex: String) {
        let r, g, b, a: CGFloat
        if rgbaHex.hasPrefix("#") {
            let start = rgbaHex.index(rgbaHex.startIndex, offsetBy: 1)
            var hexColor = String(rgbaHex[start...])
            if hexColor.count == 6 {
                hexColor = "\(hexColor)FF"
            }
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    
    func hexString() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
     }
}
