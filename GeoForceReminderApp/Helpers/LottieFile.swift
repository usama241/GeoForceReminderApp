//
//  Lottie.swift
//  JSZindigi
//
//  Created by Anis Ur Rehman on 25/07/2023.
//

import Foundation

enum LottieFile: String {
    case homeIcon = "HomeIconAnimation"
    case promotionIcon = "PromotionIconAnimation"
    case cardIcon = "CardIconAnimation"
    case moreIcon = "MoreIconAnimation"
    case delete = "DeleteAnimation"
    case error = "ErrorAnimation"
    case success = "SuccessAnimation"
    case successfulTick = "SuccessfulTick"
    case successLottie = "successLottie"
    case enterOTP = "EnterOTP"
    case enterPin = "EnterPin"
    case rewardEarn = "RewardEarn"
    case loader = "CircleLoader"
}

extension LottieFile: CaseIterable {
    static var allCases: [LottieFile] {
        return [.homeIcon, .promotionIcon, /*.cardIcon,*/ .moreIcon]
    }
}
