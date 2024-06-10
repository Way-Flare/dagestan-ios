//
//  TimerViewModel.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 10.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Combine
import Foundation

class TimerViewModel: ObservableObject {
    @Published var remainingSeconds = 59
    @Published var subtitle: String?
    @Published var timerIsActive = false
    var timer: AnyCancellable?

    func startTimer() {
        if !timerIsActive {
            timerIsActive = true
            remainingSeconds = 59
            updateSubtitle()
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                    self.updateSubtitle()
                } else {
                    self.stopTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timerIsActive = false
        timer?.cancel()
        subtitle = nil
    }

    private func updateSubtitle() {
        subtitle = "Через \(formatTime(remainingSeconds))"
    }

    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
