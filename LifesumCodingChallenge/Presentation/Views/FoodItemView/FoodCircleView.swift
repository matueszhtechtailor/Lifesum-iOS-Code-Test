//
//  FoodCircleView.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import SwiftUI

struct FoodCircleView: View {
    @ObservedObject var viewModel: FoodItemViewModel

    init(viewModel: FoodItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Constants.gradient)
                .shadow(color: Color("circleShadow"), radius: 24, x: 0, y: 8)

            VStack(alignment: .center, spacing: 0) {
                Text(viewModel.title)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .defaultFont(size: 30)
                    .underline()
                    .padding(.top, 30)
                Spacer()
            }
                .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: 50))
                .foregroundColor(.white)

            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Text(viewModel.caloriesValue)
                    .defaultFont(size: 55)
                Text(viewModel.caloriesDescription)
                    .italic()
                    .defaultFont(size: 20)
            }
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 50, trailing: 50))
                .foregroundColor(.white)
        }
            .frame(width: 300, height: 300, alignment: .center)
            .padding(.leading, 50)
            .padding(.trailing, 50)
    }
}

private extension FoodCircleView {
    enum Constants {
        static let gradient = RadialGradient(
            colors: [Color("gradientYellow"), Color("gradientRed")],
            center: UnitPoint(x: 0.25, y: 0.25),
            startRadius: 0.2,
            endRadius: 300
        )
    }
}
