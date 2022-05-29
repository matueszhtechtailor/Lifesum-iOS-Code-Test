//
//  FoodTableView.swift
//  LifesumCodingChallenge
//
//  Created by Mateusz Holubowski on 28/05/2022.
//

import SwiftUI

struct FoodTableView: View {
    @ObservedObject var viewModel: FoodItemViewModel

    init(viewModel: FoodItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
            HStack(spacing: 20) {
                ForEach(viewModel.nutrients) { item in
                    VStack(spacing: 20) {
                        Text(item.displayName)
                            .defaultFont(size: 17)
                            .frame(maxWidth: .infinity)
                            .underline()
                            .foregroundColor(Color("subtitleGrey"))
                        Text(item.displayValue)
                            .defaultFont(size: 17)
                            .foregroundColor(Color("subtitleGrey"))
                    }
                }
            }
            .padding(EdgeInsets(top: 40, leading: 60, bottom: 20, trailing: 60))
    }
}
