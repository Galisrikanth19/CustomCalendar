//
//  ContentView.swift
//  Created by GaliSrikanth on 19/04/24.

import SwiftUI

struct ContentView: View {
   @StateObject var viewModel = ViewModel()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack (spacing: 0) {
            HStack (spacing: 10) {
                Text(viewModel.monthTitle)
                    .font(.system(size: 20))
                
                Button {
                    viewModel.leftArrowClicked()
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                        .font(.system(size: 18))
                }
                .disabled(viewModel.disableBackBtn)
                
                Button {
                    viewModel.rightArrowClicked()
                } label: {
                    Image(systemName: "arrowshape.forward.fill")
                        .font(.system(size: 18))
                }
                
                Spacer()
                    .background(Color.red)
                
                Button {
                    viewModel.showFullCalendar.toggle()
                } label: {
                    Image(systemName: "calendar")
                        .font(.system(size: 30))
                }
            }
            .padding(.horizontal, 10)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.dates, id: \.self) { date in
                        Text(dateFormatter.string(from: date))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
}
