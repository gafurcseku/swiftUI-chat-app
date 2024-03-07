//
//  ReceiverRow.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 8/3/24.
//

import SwiftUI

struct ReceiverRow: View {
    var text:String = ""
    var body: some View {
        Text(text)
            .modifier(PTSansRegularTextModifier(fontSize: 18))
            .modifier(Card())
            .padding(.trailing, 80)
    }
}

#Preview {
    ReceiverRow(text:"Hi John, Glad we matched. Your profile looks amazing! Looking forward to our date at Binge Bar DC - 506 H St NE LL, Washington, DC 20002 on Friday at 7:00 pm and getting to know you more :)")
}
