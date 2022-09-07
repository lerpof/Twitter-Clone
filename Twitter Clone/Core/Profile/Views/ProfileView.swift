//
//  ProfileView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
	
    // MARK: - Variable declaration section
    
    /// @ObservedObject for profile view model
	@ObservedObject private var profileViewModel: ProfileViewModel
    
    /// selected tab inside profile view
    @State private var selectedTab: TweetFilterViewModel = .tweets
    
    // MARK: @State property for geometry transformation
    /// offset value that change when user scroll inside profile view
    @State private var offset: CGFloat = 0
    /// state property of tweet filter tabs height, useful for footer height
    @State private var tweetFilterTabsHeight: CGFloat = .zero
    /// state property for tweets view section height that change every time user change tab section, useful for footer height
    @State private var tweetsViewHeight: CGFloat = .zero
    
    // MARK: @State property for edit profile button and message button
    /// true when user click "Message" button, only for other profile
    @State private var goToChat: Bool = false
    /// true when user click on "Edit Profile", only for personal profile
    @State private var goToEditProfile: Bool = false
    
	@Environment(\.presentationMode) var presentationMode
    
    /// environment object useful to determine when an account is mine or not
	@EnvironmentObject var viewModel: AuthViewModel
    
	@Namespace var animation
    
    private let minHeight: CGFloat
    private let baseHeight = (UIScreen.main.bounds.width / 21) * 9
    private let topEdge: CGFloat
    private var footerHeight: CGFloat {
        let footerHeight = UIScreen.main.bounds.height - tweetFilterTabsHeight - tweetsViewHeight
        return footerHeight > 0 ? footerHeight : 0
    }
	
    /// True when profile view is presenting logged user profile, False otherwise
	private var isMyProfile: Bool {
        self.profileViewModel.user?.email == viewModel.currentUser?.email
	}
	
    private var user: User {
        profileViewModel.user!
    }
    
    // MARK: - function declaration section
    init(userID: String, topEdge: CGFloat) {
		profileViewModel = ProfileViewModel(userID: userID)
        self.topEdge = topEdge
        self.minHeight = 45 + self.topEdge
	}
    
    private func getHeaderHeigth() -> CGFloat {
        let topHeight = baseHeight + offset
        
        return topHeight > minHeight ? topHeight : minHeight
    }
    
    private func topBarTitleOpacity() -> CGFloat {
        let progress = -(offset + 60) / (baseHeight - minHeight)
        return progress
    }
    
    private func getBodyOffset() -> CGFloat {
        let offset: CGFloat = -25 + (-offset < minHeight + topEdge ? -offset : minHeight + topEdge)
        return offset
    }
    
    private func getProfileImageDimension() -> CGFloat {
        let difference = baseHeight - minHeight
        var dimension = -offset / difference
        dimension = dimension > 0 ? dimension : 0
        return 60 / (1 + dimension)
    }
    
    private func getBlur() -> CGFloat {
        let blur = offset / 10
        return blur > 0 ? (blur < 1 ? blur : 1) : 0
    }
	
    // MARK: - body definition section
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    headerView
                        .zIndex(getHeaderHeigth() > minHeight ? 1 : 2)

                    Group {
                        profileButtons
                            .zIndex(getHeaderHeigth() > minHeight ? 2 : 1)
                        
                        userInfo
                            .zIndex(0)
                        
                        tweetFilterTabs
                            .zIndex(1)
                        
                        ScrollView(.vertical) {
                            ForEach(profileViewModel.tweets) { tweet in
                                TweetRowView(tweet)
                                Divider()
                            }
                            .background(
                                CustomColor.background
                                    .measureSize(perform: { size in
                                        tweetsViewHeight = size.height
                                        print("SIZE: \(tweetsViewHeight)")
                                    })
                            )
                        }
                        .zIndex(0)
                        
                        
                        Rectangle()
                            .fill(Color.clear)
                            .if(profileViewModel.tweets.count == 0, transform: { view in
                                view
                                    .overlay(alignment: .top) {
                                        Text("No tweets yet in this section")
                                            .foregroundColor(CustomColor.ligthGray)
                                            .offset(y: 60)
                                    }
                            })
                            .frame(
                                height: footerHeight
                            )
                            
                            
                    }
                    .offset(y: getBodyOffset())
                }
                .modifier(OffsetModifier(offset: $offset))
            }
            .onChange(of: offset, perform: { _ in
                print("ProfileView: offset value: \(offset)")
            })
            .coordinateSpace(name: "SCROLL")
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            .padding(.leading)
            .padding(.top, topEdge + 20)
        }
        .frame(width: rect.width, height: rect.height)
        .ignoresSafeArea(.all, edges: .top)
    }
    
}

// MARK: - ProfileView Components
extension ProfileView {
    
    var headerView: some View {
        Color.blue
            .frame(width: rect.width, height: getHeaderHeigth())
            .blur(radius: getBlur())
            .offset(y: -offset)
    }
	
	var profileButtons: some View {
        HStack(alignment: .bottom) {
            VStack {
                Spacer()
                    .frame(minHeight: 0)
                    .foregroundColor(.yellow)
                UserProfileImageView(url: user.profileImageURL)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color("background"))
                    )
                    .frame(width: getProfileImageDimension(), height: getProfileImageDimension())
            }
            .frame(width: 60, height: 60)
            
            Spacer()
            
			Button {
				
			} label: {
				ZStack {
					Image(systemName: "bell.badge")
						.font(.title2)
						.foregroundColor(.primary)
					Circle()
						.stroke()
						.foregroundColor(.gray)
				}
			}
			.frame(width: 35, height: 30)
            
            Button {
                if isMyProfile {
                    goToEditProfile.toggle()
                } else {
                    goToChat.toggle()
                }
            } label: {
                ZStack {
                    Text(isMyProfile ? "Edit Profile" : "Message")
                        .fontWeight(.bold)
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    RoundedRectangle(cornerRadius: 22)
                        .stroke()
                        .foregroundColor(.gray)
                }
                .frame(width: 110, height: 30)
            }
            .sheet(isPresented: $goToEditProfile, onDismiss: {
                profileViewModel.refreshUser()
            }, content: {
                EditProfileView(user)
            })

            
            NavigationLink(isActive: $goToChat) {
                ChatView(recipient: user)
                    .navigationBarHidden(true)
            } label: {
                EmptyView()
            }

		}
        .frame(maxHeight: 60)
		.padding(.horizontal)
	}
	
	var userInfo: some View {
		VStack(alignment: .leading, spacing: 10) {
			VStack(alignment: .leading) {
				HStack {
					Text(user.fullname)
						.font(.title2)
						.fontWeight(.bold)
					Image(systemName: "checkmark.seal.fill")
						.foregroundColor(.blue)
				}
				Text("@\(user.username)")
					.font(.caption)
					.foregroundColor(.gray)
			}
            if !user.bio.isEmpty {
                Text(user.bio)
            }
			HStack {
                if !user.location.isEmpty {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text(user.location)
                            .font(.caption)
                    }
                }
                if !user.website.isEmpty {
                    HStack {
                        Image(systemName: "link")
                        Text(user.website)
                            .font(.caption)
                    }
                }
			}
			ProfileFollowView()
		}
		.padding(.horizontal)
	}
	
	var tweetFilterTabs: some View {
        GeometryReader { proxy in
            let y = proxy.frame(in: .named("SCROLL")).origin.y
            HStack {
                ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
                    VStack {
                        let isSelected = selectedTab == item
                        Text(item.title)
                            .font(.subheadline)
                            .fontWeight(isSelected ? .semibold : .regular)
                            .foregroundColor(isSelected ? .primary : .gray)
                        if isSelected {
                            Capsule()
                                .foregroundColor(.blue)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "filter", in: animation)
                        }
                        else {
                            Capsule()
                                .foregroundColor(.clear)
                                .frame(height: 3)
                        }
                        
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedTab = item
                            self.profileViewModel.fetchTweets(tweetFilter: item)
                        }
                    }
                }
            }
            .overlay {
                Divider()
                    .offset(y: 16)
            }
            .padding(.top)
            .background(
                Color("background")
                    .measureSize(perform: { size in
                        tweetFilterTabsHeight = size.height
                    })
            )
            .if(y < minHeight) { view in
                view
                    .offset(y:  -y + minHeight)
            }
        }
        .padding(.bottom, 40)
	}
	
}

// MARK: - offset modifier for scroll view
struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return .clear
                },
                alignment: .top
            )
    }
    
}
