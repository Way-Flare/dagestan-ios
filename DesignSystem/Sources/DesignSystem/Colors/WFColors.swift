//
//  WFColors.swift
//
//  Created by Abdulaev Ramazan on 07.06.2024.
//

import SwiftUI

public struct WFColor {

    // MARK: - Accent
    public static let accentActive: Color = .dsColor(named: "accentActive")
    public static let accentContainerActive: Color = .dsColor(named: "accentContainerActive")
    public static let accentContainerHover: Color = .dsColor(named: "accentContainerHover")
    public static let accentContainerInverted: Color = .dsColor(named: "accentContainerInverted")
    public static let accentContainerMuted: Color = .dsColor(named: "accentContainerMuted")
    public static let accentContainerPrimary: Color = .dsColor(named: "accentContainerPrimary")
    public static let accentContainerSoft: Color = .dsColor(named: "accentContainerSoft")
    public static let accentHover: Color = .dsColor(named: "accentHover")
    public static let accentInverted: Color = .dsColor(named: "accentInverted")
    public static let accentMuted: Color = .dsColor(named: "accentMuted")
    public static let accentPrimary: Color = .dsColor(named: "accentPrimary")
    public static let accentSoft: Color = .dsColor(named: "accentSoft")

    // MARK: - Background
    public static let backgroundHover: Color = .dsColor(named: "backgroundHover")
    public static let backgroundInverted: Color = .dsColor(named: "backgroundInverted")
    public static let backgroundModal: Color = .dsColor(named: "backgroundModal")
    public static let backgroundOverlay: Color = .dsColor(named: "backgroundOverlay")
    public static let backgroundPrimary: Color = .dsColor(named: "backgroundPrimary")
    public static let backgroundPrimaryElevated: Color = .dsColor(named: "backgroundPrimaryElevated")
    public static let backgroundSecondary: Color = .dsColor(named: "backgroundSecondary")
    public static let backgroundSecondaryElevated: Color = .dsColor(named: "backgroundSecondaryElevated")

    // MARK: - Border
    public static let borderMuted: Color = .dsColor(named: "borderMuted")
    public static let borderPrimary: Color = .dsColor(named: "borderPrimary")
    public static let borderSoft: Color = .dsColor(named: "borderSoft")

    // MARK: - Error
    public static let errorActive: Color = .dsColor(named: "errorActive")
    public static let errorContainerActive: Color = .dsColor(named: "errorContainerActive")
    public static let errorContainerHover: Color = .dsColor(named: "errorContainerHover")
    public static let errorContainerInverted: Color = .dsColor(named: "errorContainerInverted")
    public static let errorContainerMuted: Color = .dsColor(named: "errorContainerMuted")
    public static let errorContainerPrimary: Color = .dsColor(named: "errorContainerPrimary")
    public static let errorContainerSoft: Color = .dsColor(named: "errorContainerSoft")
    public static let errorHover: Color = .dsColor(named: "errorHover")
    public static let errorInverted: Color = .dsColor(named: "errorInverted")
    public static let errorMuted: Color = .dsColor(named: "errorMuted")
    public static let errorPrimary: Color = .dsColor(named: "errorPrimary")
    public static let errorSoft: Color = .dsColor(named: "errorSoft")

    // MARK: - Foreground
    public static let foregroundDisabled: Color = .dsColor(named: "foregroundDisabled")
    public static let foregroundInverted: Color = .dsColor(named: "foregroundInverted")
    public static let foregroundMuted: Color = .dsColor(named: "foregroundMuted")
    public static let foregroundPrimary: Color = .dsColor(named: "foregroundPrimary")
    public static let foregroundSoft: Color = .dsColor(named: "foregroundSoft")

    // MARK: - Info
    public static let infoActive: Color = .dsColor(named: "infoActive")
    public static let infoContainerActive: Color = .dsColor(named: "infoContainerActive")
    public static let infoContainerHover: Color = .dsColor(named: "infoContainerHover")
    public static let infoContainerInverted: Color = .dsColor(named: "infoContainerInverted")
    public static let infoContainerMuted: Color = .dsColor(named: "infoContainerMuted")
    public static let infoContainerPrimary: Color = .dsColor(named: "infoContainerPrimary")
    public static let infoContainerSoft: Color = .dsColor(named: "infoContainerSoft")
    public static let infoHover: Color = .dsColor(named: "infoHover")
    public static let infoInverted: Color = .dsColor(named: "infoInverted")
    public static let infoMuted: Color = .dsColor(named: "infoMuted")
    public static let infoPrimary: Color = .dsColor(named: "infoPrimary")
    public static let infoSoft: Color = .dsColor(named: "infoSoft")

    // MARK: - Success
    public static let successActive: Color = .dsColor(named: "successActive")
    public static let successContainerActive: Color = .dsColor(named: "successContainerActive")
    public static let successContainerHover: Color = .dsColor(named: "successContainerHover")
    public static let successContainerInverted: Color = .dsColor(named: "successContainerInverted")
    public static let successContainerMuted: Color = .dsColor(named: "successContainerMuted")
    public static let successContainerPrimary: Color = .dsColor(named: "successContainerPrimary")
    public static let successContainerSoft: Color = .dsColor(named: "successContainerSoft")
    public static let successHover: Color = .dsColor(named: "successHover")
    public static let successInverted: Color = .dsColor(named: "successInverted")
    public static let successMuted: Color = .dsColor(named: "successMuted")
    public static let successPrimary: Color = .dsColor(named: "successPrimary")
    public static let successSoft: Color = .dsColor(named: "successSoft")

    // MARK: - Warning
    public static let warningActive: Color = .dsColor(named: "warningActive")
    public static let warningContainerActive: Color = .dsColor(named: "warningContainerActive")
    public static let warningContainerHover: Color = .dsColor(named: "warningContainerHover")
    public static let warningContainerInverted: Color = .dsColor(named: "warningContainerInverted")
    public static let warningContainerMuted: Color = .dsColor(named: "warningContainerMuted")
    public static let warningContainerPrimary: Color = .dsColor(named: "warningContainerPrimary")
    public static let warningContainerSoft: Color = .dsColor(named: "warningContainerSoft")
    public static let warningHover: Color = .dsColor(named: "warningHover")
    public static let warningInverted: Color = .dsColor(named: "warningInverted")
    public static let warningMuted: Color = .dsColor(named: "warningMuted")
    public static let warningPrimary: Color = .dsColor(named: "warningPrimary")
    public static let warningSoft: Color = .dsColor(named: "warningSoft")

    // MARK: - Surface
    public static let surfacePrimary: Color = .dsColor(named: "surfacePrimary")
    public static let surfaceSecondary: Color = .dsColor(named: "surfaceSecondary")
    public static let surfaceTertiary: Color = .dsColor(named: "surfaceTertiary")
    public static let surfaceQuaternary: Color = .dsColor(named: "surfaceQuaternary")
    public static let surfaceFivefold: Color = .dsColor(named: "surfaceFivefold")

    // MARK: - Overlay
    public static let overlayPrimary: Color = .dsColor(named: "overlayPrimary")
    public static let overlaySecondary: Color = .dsColor(named: "overlaySecondary")
    public static let overlayTertiary: Color = .dsColor(named: "overlayTertiary")

    // MARK: - Info
    public static let iconPrimary: Color = .dsColor(named: "iconPrimary")
    public static let iconAccent: Color = .dsColor(named: "iconAccent")
    public static let iconOnAccent: Color = .dsColor(named: "iconOnAccent")
    public static let iconSoft: Color = .dsColor(named: "iconSoft")
    public static let iconMuted: Color = .dsColor(named: "iconMuted")
    public static let iconDisabled: Color = .dsColor(named: "iconDisabled")
    public static let iconInverted: Color = .dsColor(named: "iconInverted")
    
    // MARK: - Stars
    public static let starActive: Color = .dsColor(named: "starActive")
    public static let starPrimary: Color = .dsColor(named: "starPrimary")
}
