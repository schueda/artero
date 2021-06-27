//
//  ImageView.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 25/06/21.
//

import SwiftUI

struct ImageView: View {
        var activity: Activity
        @State var showNavigation = true
        @State var scale: CGFloat = 1.0
        @State var isTapped: Bool = false
        @State var pointTapped: CGPoint = CGPoint.zero
        @State var draggedSize: CGSize = CGSize.zero
        @State var previousDragged: CGSize = CGSize.zero
        private var maximumZoom: CGFloat = 5.0
    
        func shareImage() {
            guard let image = activity.image,
                  let data = image.pngData() else { return }
            presentActivityController(with: data)
        }
    
        func presentActivityController(with data: Data) {
            let controller = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true, completion: nil)
        }
    
        var body: some View {
            GeometryReader { reader in
                VStack {
                    Image("art10")
                        .resizable()
                        .scaledToFit()
                        .animation(.default)
                        .padding(.top, self.showNavigation ? 9.5 : 0)
                        .onTapGesture(count: 1) {
                            self.showNavigation.toggle()
                        }
                        .offset(x: self.draggedSize.width, y: 0)
                        .scaleEffect(self.scale)
                        .scaleEffect(self.isTapped ? 2 : 1,
                                     anchor: UnitPoint(
                                        x: self.pointTapped.x / reader.frame(in: .global).maxX,
                                        y: self.pointTapped.y / reader.frame(in: .global).maxY
                                     )
                        )
                        .gesture(
                            TapGesture(count: 2)
                                .onEnded({
                                    if self.scale <= 1.0 {
                                        self.isTapped = !self.isTapped
                                    } else {
                                        self.scale = 1.0
                                        self.pointTapped = CGPoint.zero
                                        self.draggedSize = CGSize.zero
                                    }
                                })
                                .simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                                    .onChanged({ (value) in
                                                        self.pointTapped = value.startLocation
                                                        self.draggedSize = CGSize(
                                                            width: value.translation.width + self.previousDragged.width,
                                                            height: value.translation.height + self.previousDragged.height)
                                                    })
                                                    .onEnded({ (value) in
                                                        let globalMaxX = reader.frame(in: .global).maxX
                                                        let offsetWidth = ((globalMaxX * self.scale) - globalMaxX) / 2
                                                        let newDraggedWidth = self.draggedSize.width * self.scale
                                                        
                                                        if (newDraggedWidth > offsetWidth) {
                                                            self.draggedSize = CGSize(
                                                                width: offsetWidth / self.scale,
                                                                height: value.translation.height + self.previousDragged.height
                                                            )
                                                        } else if (newDraggedWidth < -offsetWidth) {
                                                            self.draggedSize = CGSize(
                                                                width: -offsetWidth / self.scale,
                                                                height: value.translation.height + self.previousDragged.height
                                                            )
                                                        } else {
                                                            self.draggedSize = CGSize(
                                                                width: value.translation.width + self.previousDragged.width,
                                                                height: value.translation.height + self.previousDragged.height
                                                            )
                                                        }
                                                        self.previousDragged = self.draggedSize
                                                    }))
                        )
                        .gesture(
                            MagnificationGesture()
                                .onChanged({ (scale) in
                                    self.scale = (self.scale - 1.0) + scale.magnitude
                                })
                                .onEnded({ (scaleFinal) in
                                    if self.scale <= 1.0 {
                                        self.scale = 1.0
                                        self.pointTapped = CGPoint.zero
                                        self.draggedSize = CGSize.zero
                                    } else if self.scale >= self.maximumZoom  {
                                        self.scale = self.maximumZoom
                                    } else  {
                                        self.scale = (self.scale - 1.0) + scaleFinal.magnitude
                                    }
                                })
                        )
                }
                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
                .statusBar(hidden: showNavigation)
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: showNavigation)
                .edgesIgnoringSafeArea(showNavigation ? [.top, .bottom] : [])
                .navigationBarHidden(showNavigation)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button(action: {}) {
                            Text("ok")
                                .textCase(.uppercase)
                                .font(.headline)
                        }
                )
                .toolbar {
                    ToolbarItemGroup(placement: self.showNavigation ? .destructiveAction: .bottomBar) {
                        Button(action: { self.shareImage() }) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "trash")
                        }
                    }
                }
                .background(self.showNavigation ? Color.black.ignoresSafeArea() : Color.clear.ignoresSafeArea())
                .onTapGesture {
                    withAnimation() {
                        self.showNavigation.toggle()
                    }
                }
            }
        }

}

//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
        //        NavigationView {
//        ImageView()
        //        }
//    }
//}
