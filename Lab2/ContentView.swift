/*:
 
# Lab #2
# Group #15
## Andrew Yee
October 20, 2025

*/

import SwiftUI

struct ContentView: View {

    let images = ["flower1", "flower2", "flower3", "flower4", "flower5", "flower6", "flower7", "flower8", "flower9", "flower10", "flower11", "flower12"]

    var body: some View {
        ScrollView {
            Text("Flower Game")
                .font(.largeTitle)
                .foregroundColor(.pink)
                .opacity(0.8)
                .bold()

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100), spacing: 8)],
                spacing: 8
            ) {
                ForEach(images, id: \.self){ im in
                    FlowerCard(content: im)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
    }
}

struct FlowerCard: View {
    @State private var flipped = false  // state to control rotation
    
    let content: String

    var body: some View {
        ZStack {
            
            // FRONT SIDE of the card
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.pink)
                    .opacity(0.05)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.pink, lineWidth: 3)
                            .opacity(0.3)
                    )
                Text("🌸")
                    .font(.largeTitle)
            }
            .opacity(flipped ? 0.0 : 1.0)
            .rotation3DEffect(
                .degrees(flipped ? 180 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            
            // BACK SIDE of the card
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.pink, lineWidth: 3)
                            .opacity(0.3)
                    )
                
                Image(content)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            .opacity(flipped ? 1.0 : 0.0)
            .rotation3DEffect(
                .degrees(flipped ? 0 : -180),
                axis: (x: 0, y: 1, z: 0)
            )
        }
        .padding(.horizontal)
        .animation(.linear(duration: 0.2), value: flipped)
        .onTapGesture{flipped.toggle()}
    }
}

#Preview {
    ContentView()
}
