import Foundation

class Calculator {
    var total: Double
    var operation: String
    var operand: Double?
    var validOps = "+-*/^"

    init() {
        total = 0.0
        operation = ""
        operand = 0.0
    }

    func run() {
        while(true) {
            print("Enter an operator: " + validOps)
            if let input = readLine() {
                let trimInput = input.trimmingCharacters(in: .whitespacesAndNewlines)

                if trimInput.count == 1 {
                    let op = trimInput[trimInput.startIndex]
                
                    if checkOperation(input: op) {
                        operation = String(op)
                        break
                    }
                }
            } else {
                print("Hit Ctl+C to exit.")
            }
        }

        while(true) {
            print("Enter an operand:")
            if let input = readLine() {
                let operand = NumberFormatter().number(from: input)?.doubleValue

                if operand != nil {
                    let result =  calculate(input: operand!)
                    if result.0 {
                       print(result.1)
                       break
                    } else {
                       print(result.2)
                    }
                }
            } else {
                print("Hit Ctl+C to exit.")
            }
        }
    }

    func checkOperation(input: Character) -> Bool {
        for char in validOps {
            if (input == char) {
                return true
            }
        }
        return false
    }

    func calculate(input: Double) -> (Bool, Double, String) {
        switch operation {
        case "+":
            total = self.total + input
            break
        case "-":
            total = self.total - input
            break
        case "*":
            total = self.total * input
            break
        case "/":
            let temp = total / input
            if temp.isNaN || temp.isInfinite {
                return (false, 0.0, "Error cannot divide by zero")
            } else {
                total = temp
                break
            }
        case "^":
            if input < 0 {
                return (false, 0.0, "Error cannot use negative exponents")
            } else {
                total = pow(self.total, input)
                break
            }
        default:
            break
        }
        return (true, total, "success")
    }
}

print("Welcome to Matt's Basic Calculator in Swift")
print("Hit Ctrl+C to exit.")
let main = Calculator()
while (true) {
    main.run()
}

