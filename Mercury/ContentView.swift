//
//  ContentView.swift
//  Mercury
//
//  Created by Daniel Correia on 20.06.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    NavigationLink {
                        AlgorithmsView()
                    } label: {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Algorithms")
                                    .padding()
                                    .padding(.vertical)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                        .panel()
                    }
                    NavigationLink {
                        DataStructuresView()
                    } label: {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Data Structures")
                                    .padding()
                                    .padding(.vertical)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                        .panel()
                    }
                    NavigationLink {
                        DesignPatternsView()
                    } label: {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Design Patterns")
                                    .padding()
                                    .padding(.vertical)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                        .panel()
                    }
                    NavigationLink {
                        ProgrammingLanguageView()
                    } label: {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Programming Languages")
                                    .padding()
                                    .padding(.vertical)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                        .panel()
                    }
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
