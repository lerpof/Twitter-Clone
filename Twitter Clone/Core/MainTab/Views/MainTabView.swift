//
//  MainTabView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
    
    @State private var selectedIndex: MainTabViewModels = .feed
    
    private let sideMenuWidth: Double = UIScreen.main.bounds.width * 0.7
    @State private var offset: Double = 0
    
    @State var showProfileView: Bool = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationView {
                SideBarStack(sidebarWidth: sideMenuWidth, offset: $offset) {
                    SideMenuView(showProfileView: $showProfileView)
                } content: {
                    VStack {
                        NavigationBar {
                            Button {
                                withAnimation(.easeInOut) {
                                    offset = sideMenuWidth
                                }
                            } label: {
                                UserProfileImageView(url: user.profileImageURL)
                                    .frame(width: 40, height: 40)
                            }
                        } titleView: {
                            Image("icon")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.primary)
                                .frame(width: 30, height: 30)
                        } trailingView: {
                            Spacer()
                                .frame(width: 30, height: 30)
                        }
                        
                        NavigationLink(isActive: $showProfileView) {
                            GeometryReader { proxy in
                                ProfileView(userID: user.id!, topEdge: proxy.safeAreaInsets.top)
                                    .navigationBarHidden(true)
                            }
                        } label: {
                            EmptyView()
                        }
                        
                        TabView(selection: $selectedIndex) {
                            ForEach(MainTabViewModels.allCases, id: \.rawValue) { mainTabOption in
                                mainTabOption.view
                                    .navigationTitle("")
                                    .navigationBarHidden(true)
                                    .onTapGesture {
                                        self.selectedIndex = mainTabOption
                                    }
                                    .tabItem {
                                        Image(systemName: mainTabOption.imageName)
                                    }
                                    .tag(mainTabOption)
                            }
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
}
