//
//  ContentView.swift
//  calculator
//
//  Created by jangmi on 2020/07/15.
//  Copyright © 2020 jangmi. All rights reserved.
//

import SwiftUI

enum CalculatorButton {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equal, plus, minus, multiply, divide
    case ac, plusMinus, percent
    case decimal
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .divide: return "/"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .equal: return "="
        case .decimal: return "."
        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
}

class GlobalEnvironment: ObservableObject {
    
    
    @Published var display = "0"
    
    
    
    
    func receiveInput(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            if display == "0" && calculatorButton == .zero {
                break;
            }
            else if display.contains(".") && calculatorButton == .decimal {
                break;
            }
            else {
                if display == "0" {display = calculatorButton.title}
                else {
                    var temp = ""
                    temp = display
                    temp.append(calculatorButton.title)
                    display = temp
                }
            }
        case .ac:
            display = "0"
        case .plus:
            var temp = display
            display = "0"
        default:
            display.append(calculatorButton.title)
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 12){
                
                HStack (spacing : 12) {
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                
                ForEach(buttons, id: \.self) { row in HStack {
                    ForEach(row, id: \.self) { button in
                        
                        Button(action: {
                            
                            self.env.receiveInput(calculatorButton: button)
                            
                        }) {
                            Text(button.title)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 4 * 12) / 4)
                                .foregroundColor(.white)
                                .background(button.backgroundColor)
                                .cornerRadius(self.buttonWidth(button: button))
                        }
                        
                        
                    }
                    }
                }
            }.padding(.bottom)
        }
    }
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero{
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
