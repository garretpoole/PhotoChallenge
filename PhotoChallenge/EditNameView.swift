//
//  EditNameView.swift
//  PhotoChallenge
//
//  Created by Garret Poole on 4/27/22.
//

import SwiftUI

struct EditNameView: View {
    @Environment(\.dismiss) var dismiss
    
    let image: Image?
    @Binding var name: String
    @Binding var saveName: Bool
    @Binding var choosingName: Bool
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
            TextField("Name", text: $name)
                .padding(.horizontal)
                .font(.title)
            HStack {
                Button("Save") {
                    saveName = true
                    dismiss()
                }
                .frame(width: 100, height: 40)
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                
                Button("Cancel") {
                    saveName = false
                    choosingName = false
                    name = ""
                    dismiss()
                }
                .frame(width: 100, height: 40)
                .background(.red)
                .clipShape(Capsule())
                .foregroundColor(.white)
            }
            
        }
        .padding([.horizontal, .vertical])
    }
}

