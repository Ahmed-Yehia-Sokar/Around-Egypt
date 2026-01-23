//
//  ExperienceView.swift
//  AroundEgypt
//
//  Created by Admin on 23/01/2026.
//

import SwiftUI
import Kingfisher

struct ExperienceView: View {
    @ObservedObject var viewModel: ExperienceViewModel
    var body: some View {
        VStack {
            coverPhotoView
            experienceDetailsView
        }
    }
    
    // MARK: - private properties
    private var coverPhotoView: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(viewModel.getExperienceCoverPhotoURL())
                .resizable()
                .frame(height: 200.0)
                .clipped()
                .cornerRadius(12.0)
            
            HStack {
                Image(systemName: "eye.fill")
                
                Text(viewModel.getExperienceViewsNumber())
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
        }
        .padding(.horizontal)
    }
    
    private var experienceDetailsView: some View {
        HStack {
            Text(viewModel.getExperienceTitle())
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Spacer()
            
            Text(viewModel.getExperienceLikesNumber())
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Button(action: {
            }) {
                Image(systemName: viewModel.isExperienceLiked() ? "heart.fill" : "heart")
                    .foregroundColor(Color.orange)
            }
        }
        .padding()
    }
}

#Preview {
    let experience = Experience(
        id: "1",
        title: "Egyptian Desert",
        coverPhoto: "https://fls-9ff553c9-95cd-4102-b359-74ad35cdc461.367be3a2035528943240074d0096e0cd.r2.cloudflarestorage.com/21/DBiLufkgRD42qnvG83yuJzXiaV2NVp-metad214aWhEdnY2T2dvTzRobXRNcThkRXZOTk5sMjh5SVZCMW5BV2ZsMi5qcGVn-.jpg?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=c1450316125e7da31ad41a64b276dcc3%2F20260123%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260123T083841Z&X-Amz-SignedHeaders=host&X-Amz-Expires=172800&X-Amz-Signature=c77f0b66effd96d286105ee96b874cf92700f9f76db562e378f31bf769b98195",
        description: "description",
        viewsNumber: 200,
        likesNumber: 45,
        recommended: 1,
        detailedDescription: "detailed description",
        address: "address",
        isLiked: false
    )
    let viewModel = ExperienceViewModelProvider.provide(experience: experience)
    ExperienceView(viewModel: viewModel)
}
