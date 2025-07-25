//
//  Glur.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 09/02/24.
//

import SwiftUI

public struct Glur {
   let radius: CGFloat
   let offset: CGFloat
   let interpolation: CGFloat
   let direction: BlurDirection
   
   public init(
       radius: CGFloat = 8.0,
       offset: CGFloat = 0.3,
       interpolation: CGFloat = 0.4,
       direction: BlurDirection = .down
   ) {
       assert(radius >= 0.0, "Radius must be greater than or equal to 0")
       assert(offset >= 0.0 && offset <= 1.0, "Offset must be between 0 and 1")
       assert(interpolation >= 0.0 && interpolation <= 1.0, "Interpolation must be between 0 and 1")
       
       self.radius = radius
       self.offset = offset
       self.interpolation = interpolation
       self.direction = direction
   }
}

extension View {
    /// A modifier that applies a gradient blur effect to the view.
    ///
    /// - Parameters:
    ///   - radius: The total radius of the blur effect when fully applied.
    ///   - offset: The distance from the view's edge to where the effect begins, relative to the view's size.
    ///   - interpolation: The distance from the offset to where the effect is fully applied, relative to the view's size.
    ///   - direction: The direction in which the effect is applied.
    public func glur(radius: CGFloat = 8.0,
                     offset: CGFloat = 0.3,
                     interpolation: CGFloat = 0.4,
                     direction: BlurDirection = .down) -> some View {
        assert(radius >= 0.0, "Radius must be greater than or equal to 0")
        assert(offset >= 0.0 && offset <= 1.0, "Offset must be between 0 and 1")
        assert(interpolation >= 0.0 && interpolation <= 1.0, "Interpolation must be between 0 and 1")
        
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, *) {
            return modifier(GlurModifier(radius: radius,
                                         offset: offset,
                                         interpolation: interpolation,
                                         direction: direction))
        } else {
            return modifier(CompatibilityModifier(radius: radius,
                                                  offset: offset,
                                                  interpolation: interpolation,
                                                  direction: direction))
        }
    }

    /// A modifier that applies a gradient blur effect to the view.
    ///
    /// - Parameters:
    ///   - config: A `Glur` configuration object containing radius, offset, interpolation, and direction settings.
    public func glur(_ config: Glur) -> some View {
        return glur(radius: config.radius,
                    offset: config.offset,
                    interpolation: config.interpolation,
                    direction: config.direction)
    }
}
