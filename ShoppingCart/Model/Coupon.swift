import Foundation

final class Coupon {
    let code: String
    let discountPercentage: Double
    let maxDiscount: Double
    var usageLimit: Int
    private(set) var usageCount: Int = 0
    
    init(code: String, discountPercentage: Double, maxDiscount: Double, usageLimit: Int) {
        self.code = code
        self.discountPercentage = discountPercentage
        self.maxDiscount = maxDiscount
        self.usageLimit = usageLimit
    }
    
    // Method to apply the coupon if usage limit not reached
    func apply(to total: Double) -> Double? {
        if usageCount >= usageLimit {
            return nil
        } else {
            let discount = min(total * (discountPercentage / 100.0), maxDiscount)
            usageCount += 1
            return discount
        }
    }
}
