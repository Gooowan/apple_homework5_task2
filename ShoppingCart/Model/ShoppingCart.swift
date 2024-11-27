import Foundation

final class ShoppingCart {
    private(set) var items: [Item] = []
    private var appliedCoupons: [Coupon] = []
    
    // Adds an item to the cart
    func addItem(_ item: Item) {
        items.append(item)
    }
    
    // Removes an item from the cart
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.name == item.name }) {
            items.remove(at: index)
        }
    }
    
    // Calculates the total price without discount
    func calculateTotalPrice() -> Double {
        var totalPrice: Double = 0.0
        
        for item in items {
            totalPrice += item.price * Double(item.quantity)
        }
        
        return totalPrice
    }
    
    // Calculates the final price after applying discount
    @discardableResult
    func applyCoupon(_ coupon: Coupon) -> Bool {
        if appliedCoupons.contains(where: { $0.code == coupon.code }) {
                return false
            }
        if let _ = coupon.apply(to: calculateTotalPrice()) {
                appliedCoupons.append(coupon)
                return true
            } else {
                return false
            }
    }
    
    // Calculate final price with coupon discounts
    func calculateFinalPrice() -> Double {
        var finalPrice: Double = 0.0
        let total = calculateTotalPrice()
        finalPrice = total
        
        for coupon in appliedCoupons {
            if (coupon.maxDiscount < total) {
                let discount = min(total * (coupon.discountPercentage / 100.0), coupon.maxDiscount)
                finalPrice -= discount
            }
        }
        
        return finalPrice
    }

}
