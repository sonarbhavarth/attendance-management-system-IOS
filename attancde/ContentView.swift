//
//  ContentView.swift
//  attancde
//
//  Created by bhavarth on 16/09/25.
//

import SwiftUI

enum UserRole {
    case admin
    case user
}

struct ContentView: View {
    @State private var userRole: UserRole = .admin // Change to .user for testing
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hello,")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("John Doe")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                    if userRole == .admin {
                        NavigationLink(destination: MarkAttendanceView()) {
                            VStack(spacing: 10) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                                
                                Text("Mark Attendance")
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        
                        CardView(title: "View Records", icon: "list.bullet", color: .green) {
                            // Action
                        }
                        
                        CardView(title: "Events", icon: "calendar", color: .orange) {
                            // Action
                        }
                        
                        CardView(title: "Users", icon: "person.2.fill", color: .purple) {
                            // Action
                        }
                        
                        CardView(title: "Settings", icon: "gearshape.fill", color: .gray) {
                            // Action
                        }
                    } else {
                        CardView(title: "My Attendance", icon: "person.fill.checkmark", color: .blue) {
                            // Action
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct CardView: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

#Preview {
    ContentView()
}
