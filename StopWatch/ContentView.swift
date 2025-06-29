//
//  ContentView.swift
//  StopWatch
//
//  Created by 生越冴恵 on 2025/06/28.
//

import SwiftUI
import UIKit



struct ContentView: View {
    
    @State private var timer: Timer?
    @State private var vibrationTimer: Timer?
    @State private var secondsElapsed: Double = 0.0
    @State private var isRunning = false
    @State private var gameFinished = false
    @State private var resultMessage = ""
    @State private var vibrationInterval: Double = 1.0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("10秒ピッタリゲーム")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if gameFinished {
                Text(String(format: "%.2f", secondsElapsed))
                    .font(.system(size: 60, weight: .bold, design: .monospaced))
                    .foregroundColor(.red)
            } else {
                Text("？？？")
                    .font(.system(size: 60, weight: .bold, design: .monospaced))
                    .foregroundColor(.gray)
            }
            
            if !resultMessage.isEmpty {
                Text(resultMessage)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .padding()
            }
            
            HStack(spacing: 30) {
                if !isRunning && !gameFinished {
                    Button("スタート") {
                        start()
                    }
                    .font(.title2)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                } else if isRunning {
                    Button("ストップ") {
                        stop()
                    }
                    .font(.title2)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
                
                if gameFinished {
                    Button("リスタート") {
                        restart()
                    }
                    .font(.title2)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
            }
        }
        .padding()
    }
    
    func start() {
        vibrationInterval = Double.random(in: 0.5...2.5)
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            secondsElapsed += 0.01
        }
        startVibrations()
        isRunning = true
        gameFinished = false
        resultMessage = ""
    }
    
    func stop() {
        timer?.invalidate()
        vibrationTimer?.invalidate()
        isRunning = false
        gameFinished = true
        
        let difference = abs(secondsElapsed - 10.0)
        
        if difference <= 0.05 {
            resultMessage = "完璧！！"
        } else if difference <= 0.2 {
            resultMessage = "素晴らしい！"
        } else if difference <= 0.5 {
            resultMessage = "惜しい！"
        } else if difference <= 1.0 {
            resultMessage = "まだまだ！"
        } else {
            resultMessage = "もっと頑張って！"
        }
    }
    
    func restart() {
        timer?.invalidate()
        vibrationTimer?.invalidate()
        secondsElapsed = 0.0
        isRunning = false
        gameFinished = false
        resultMessage = ""
    }
    
    func startVibrations() {
        vibrationTimer = Timer.scheduledTimer(withTimeInterval: vibrationInterval, repeats: true) { _ in
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
        }
    }
}

#Preview {
    ContentView()
}
