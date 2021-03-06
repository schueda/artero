//
//  ImageView.swift
//  Artero
//
//  Created by Felipe Seolin Bento on 25/06/21.
//

import SwiftUI

struct ImageView: View {
    let image: UIImage
    @State private var hideNavigation = false
    @State private var scale: CGFloat = 1.0
    @State private var isTapped: Bool = false
    @State private var pointTapped: CGPoint = CGPoint.zero
    @State private var draggedSize: CGSize = CGSize.zero
    @State private var previousDragged: CGSize = CGSize.zero
    private let maximumZoom: CGFloat = 5.0
    
    private func shareImage() {
        guard var data = image.jpegData(compressionQuality: 1) else { return }
        if data.isEmpty {
            guard let pngdata = image.pngData() else { return }
            data = pngdata
        }
        presentActivityController(with: data)
    }
    
    private func presentActivityController(with data: Data) {
        let controller = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .animation(.default)
                    .onTapGesture(count: 1) {
                        self.hideNavigation.toggle()
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
                                                    self.hideNavigation = true
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
                                self.hideNavigation = true
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
            .statusBar(hidden: hideNavigation)
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: hideNavigation)
            .edgesIgnoringSafeArea(hideNavigation ? [.top, .bottom] : [])
            .navigationBarHidden(hideNavigation)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: { self.shareImage() }) {
                        Image(systemName: "square.and.arrow.up")
                    }
            )
            .background(self.hideNavigation ? Color.black.ignoresSafeArea() : Color.clear.ignoresSafeArea())
            .onTapGesture {
                withAnimation() {
                    self.hideNavigation.toggle()
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
