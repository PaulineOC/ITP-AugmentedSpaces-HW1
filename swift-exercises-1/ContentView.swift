//
//  ContentView.swift
//  SwiftExercises1
//
//  Created by Nien Lam on 9/8/21.
//  Copyright © 2021 Line Break, LLC. All rights reserved.
//

import SwiftUI


class ViewModel: ObservableObject {
    @Published var counterEven: Int  = 0
    @Published var cycle: Int        = 5
    @Published var fibonacci: Int    = 0
    @Published var student: String   = "Jane"
    
    // EDIT CODE HERE: ////////////////////////////////////////////////

    // Add any local variables here.
    var myLocalVar: Int = 0
    
    // Add logic to list even numbers.
    func didPressCounterNext() {
        print("🔺 Did press counter next")
        print("Value: ", counterEven)

        counterEven += 2
    }

    // Add logic to cycle integers 5 to 0.
    // 5, 4, 3, 2, 1, 0, 5, 4, 3, 2, 1, 0, 5, ...
    func didPressCycleNext() {
        print("🔺 Did press cycle next")
        print("Value: ", cycle)
        
        cycle-=1
        if cycle < 0 {
            cycle = 5
        }
    }
    
    var prevVal: Int = 0
    // Add logic to list Fibonacci Sequence.
    func didPressFibonacciNext() {
        print("🔺 Did press Fibonacci next")
        print("Value: ", fibonacci)
      
        let finalSum = prevVal + fibonacci
        prevVal = fibonacci
        fibonacci = finalSum
        
        if(fibonacci == 0){
            prevVal = 0
            fibonacci = 1
        }
    }
    // Added Jane to the list so that the reset matches the initial value
    var students = ["Jane", "Morgan", "Lauren", "Don", "Eamon", "Eric", "Zack", "Divya", "Pauline", "Brandon", "Rajshree","Echo", "Tinrey", "Lucas", "Mingxi", "Allie", "Yihan","Philip", "Henry", "Wei Wei"];
    
    var indx: Int = 0;
    // Add logic to list Augmented Spaces students.
    func didPressStudentNext() {
        print("🔺 Did press Student next")
        print("Value: ", student)
        
        print(indx);
        indx = (indx+1) % students.count
        student = students[indx];

    }
    
    // Reset any variables used.
    func didResetVariables() {
        print("🔺 Did reset variables")

        counterEven   = 0
        cycle         = 5
        fibonacci     = 0
        indx          = 0
        student       = students[indx]
    }

    ///////////////////////////////////////////////////////////////////
}


struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            Text("Swift Exercises I")
                .font(.largeTitle)
                .padding(.top, 80)
            
            VStack {
                // 1.
                lineItem(title: "1. List even numbers", text: "\(viewModel.counterEven)", buttonColor: .blue) {
                    viewModel.didPressCounterNext()
                }
                Divider()

                // 2.
                lineItem(title: "2. Cycle integers 5 to 0", text: "\(viewModel.cycle)", buttonColor: .green) {
                    viewModel.didPressCycleNext()
                }
                Divider()

                // 3.
                lineItem(title: "3. Fibonacci sequence", text: "\(viewModel.fibonacci)", buttonColor: .red) {
                    viewModel.didPressFibonacciNext()
                }
                Divider()

                // 4.
                lineItem(title: "4. List students", text: "\(viewModel.student)", buttonColor: .purple) {
                    viewModel.didPressStudentNext()
                }
                Divider()
                
                // Reset button
                Button {
                    viewModel.didResetVariables()
                } label: {
                    resetLabel()
                }
                .padding(.top, 20)
            }
            .padding()
            .padding(.top, 20)
        }
    }
    
    // Helper function to line item.
    func lineItem(title: String, text: String, buttonColor: Color, action: @escaping () -> Void) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(text)
                .bold()
            
            Button {
                action()
            } label: {
                actionLabel(color: buttonColor)
            }
            .padding(.leading, 20)
        }
    }
    
    // Helper function to render action label.
    func actionLabel(color: Color) -> some View {
        Label("", systemImage: "chevron.forward.square")
            .font(.system(.title))
            .foregroundColor(.white)
            .labelStyle(IconOnlyLabelStyle())
            .frame(width: 44, height: 44)
            .background(color)
            .cornerRadius(4)
    }
    
    // Helper function to render reset label.
    func resetLabel() -> some View {
        Label("Reset", systemImage: "gobackward")
            .font(.system(.headline))
            .foregroundColor(.white)
            .frame(width: 120, height: 44)
            .background(Color.gray)
            .cornerRadius(4)
    }
}
