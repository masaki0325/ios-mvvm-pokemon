//
//  SearchView.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/16.
//

import SwiftUI

struct SearchView: View {
    @State private var searchName: String = ""
    @State private var searchID: String = ""
    @State private var showClearConfirmation = false
    @Environment(\.dismiss) var dismiss

    let onComplete: (String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("検索条件")) {
                    TextField("名前で検索", text: $searchName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.asciiCapable)
                        .autocapitalization(.none)
                    TextField("IDで検索", text: $searchID)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }
            }
            .navigationTitle("検索")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("クリア") {
                        showClearConfirmation = true
                    }
                    .confirmationDialog("検索条件をクリアしますか？", isPresented: $showClearConfirmation, titleVisibility: .visible) {
                        Button("クリア", role: .destructive) {
                            SearchCondition.shared.searchName = ""
                            SearchCondition.shared.searchID = ""
                            searchName = ""
                            searchID = ""
                        }
                        Button("キャンセル", role: .cancel) { }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("検索") {
                        SearchCondition.shared.searchName = searchName
                        SearchCondition.shared.searchID = searchID
                        onComplete(searchName, searchID)
                        dismiss()
                    }
                }
            }
            .onAppear {
                searchName = SearchCondition.shared.searchName
                searchID = SearchCondition.shared.searchID
            }
        }
    }
}

#Preview {
    SearchView(onComplete: { query, id in })
}
