//
//  ContentView.swift
//  Puzzle15Game
//
//  Created by Babypowder on 11/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TileViewModel()
    
    @State private var showingWinAlert = false

    
    let spacing = 4 as CGFloat
    let aspectRatio = 1 as CGFloat
    
    
    var body: some View {
        VStack{
            
            Text("15 PUZZLE")
                .font(.custom("HelveticaNeue-Bold", size: 50))
                .foregroundColor(.black)
            
            HStack{
                Button("New Game"){
                    withAnimation {
                        viewModel.shuffle()
                    }
                }.foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.black)
                    )
                    
                    .font(.custom("HelveticaNeue-Bold", size: 20))
                Spacer()
                VStack{
                    Text("Moves")
                    Text("\(viewModel.countMove)")
                }.padding()
                 .cornerRadius(12)
                 .font(.custom("HelveticaNeue-Bold", size: 17))
                
            }

            
            
            AspectVGrid(items: viewModel.tiles, aspectRatio: aspectRatio) {
                tile in TileView(tile)
                    .padding(spacing)
                    .onTapGesture {
                        viewModel.choose(tile)
                        if viewModel.checkGameWin() {
                            showingWinAlert = true
                        }
                    }
                    .animation(.default, value: viewModel.tiles)
            }
            Spacer()
            
            .alert(isPresented: $showingWinAlert) {
                Alert(
                    title: Text("Congratulations!"),
                    message: Text("You won the game!"),
                    dismissButton: .default(Text("OK")) {
                        viewModel.shuffle()
                    }
                )
            }
            
                
            
        }.padding()
            .background(Color(red: 216 / 255, green: 191 / 255, blue: 216 / 255))

    }
}

struct TileView: View{
    var tile: Puzzle15GameModel<Int>.Tile
    init(_ tile: Puzzle15GameModel<Int>.Tile) {
        self.tile = tile
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                if !tile.isSpace {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                    
                    Text(tile.content.description)
                }
                
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
