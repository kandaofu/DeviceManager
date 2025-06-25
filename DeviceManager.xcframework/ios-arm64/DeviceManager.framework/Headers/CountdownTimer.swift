//
//   CountdownTimer.swift
//   DeviceManager
//
//   Created by Apple on 2025/6/4
//   
//
   

import UIKit

public protocol CountdownDelegate: AnyObject {
    func countdownDidUpdate(hourSting: String, minuteSting: String, secondSting: String)
    func countdownDidUpdate(hourInt: Int, minuteInt: Int, secondInt: Int)
    func countdownDidFinish()
}

public class CountdownTimer: NSObject {
    public weak var delegate: CountdownDelegate?

    private var remainingSeconds: Int = 0
    private var timer: Timer?

    public init(delegate: CountdownDelegate?) {
        self.delegate = delegate
    }

    public func startCountdown(timeInt: Int) {
        stop()
        guard timeInt > 0 else { return }
        remainingSeconds = timeInt
        notifyUpdate()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }

    @objc private func updateTimer() {
        remainingSeconds -= 1
        notifyUpdate()

        if remainingSeconds <= 0 {
            timer?.invalidate()
            timer = nil
            delegate?.countdownDidFinish()
        }
    }

    private func notifyUpdate() {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        delegate?.countdownDidUpdate(hourInt: hours, minuteInt: minutes, secondInt: seconds)
        delegate?.countdownDidUpdate(hourSting: String(format: "%02d", hours), minuteSting: String(format: "%02d", minutes), secondSting: String(format: "%02d", seconds))
    }

    
}

