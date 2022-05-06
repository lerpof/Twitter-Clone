//
//  TweetView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 06/05/22.
//

import SwiftUI
import Firebase

struct TweetView: View {
	
	private var tweet: Tweet
	
	init(_ tweet: Tweet) {
		self.tweet = tweet
	}
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				if let user = tweet.user {
					HStack(alignment: .top) {
						UserProfileImageView(url: user.profileImageURL)
							.frame(width: 50, height: 50)
						VStack(alignment: .leading) {
							HStack {
								Text(user.fullname)
									.font(.headline)
								Image(systemName: "checkmark.seal.fill")
									.font(.subheadline)
							}
							Text("@\(user.username)")
								.font(.caption)
						}
						Spacer()
					}
					Text(tweet.caption)
						.multilineTextAlignment(.leading)
						.font(.body)
						.padding(.vertical)
					TweetInteractionButtons(tweet)
						.padding(.horizontal)
					Spacer()
				}
			}
			.padding(.horizontal, 16)
		}
    }
}

struct TweetView_Previews: PreviewProvider {
    static var previews: some View {
		TweetView(Tweet(
					caption: "Michael Jeffrey Jordan, conosciuto anche con le sue iniziali MJ, è un ex cestista ed ex giocatore di baseball statunitense, nonché principale azionista e presidente della squadra di pallacanestro degli Charlotte Hornets. Soprannominato Air Jordan[8] e His Airness[10] per le sue qualità atletiche e tecniche, fu eletto nel 1999 il più grande atleta nordamericano del XX secolo dal canale televisivo sportivo ESPN.[11] La fama acquisita sul campo lo ha reso un'icona dello sport,[12] al punto da spingere la Nike a dedicargli una linea di scarpe da pallacanestro chiamata Air Jordan, introdotta nel 1984. Giocò per tre anni all'Università della Carolina del Nord a Chapel Hill, dove guidò la squadra alla vittoria del campionato nazionale NCAA nel 1982. Fu poi scelto per terzo al Draft NBA 1984 dai Chicago Bulls e diventò in breve tempo una delle stelle della lega, contribuendo a diffondere la NBA a livello mondiale negli anni '80 e '90.[14][15] Nel 1991 vinse il suo primo titolo NBA con i Bulls, per poi ripetersi con altri due successi nel 1992 e nel 1993, aggiudicandosi un three-peat, dopo il quale si ritirò per intraprendere una carriera nel baseball. Tornò ai Bulls nel 1995 e li condusse alla vittoria di un altro three-peat (1996, 1997 e 1998). Si ritirò una seconda volta nel 1999, per poi tornare come membro dei Washington Wizards dal 2001 al 2003, per poi ritirarsi definitivamente. I riconoscimenti ottenuti a livello individuale includono sei MVP delle finali,[16] dieci titoli di miglior marcatore (entrambi record), cinque MVP della regular season, dieci selezioni All-NBA First Team e nove nell'All-Defensive First Team, quattordici partecipazioni all'NBA All-Star Game, tre MVP dell'All-Star Game e un NBA Defensive Player of the Year Award. Detiene i record NBA per la media punti più alta nella storia della regular season (30,12 punti a partita) e nella storia dei playoffs (33,45 punti a partita). Fu introdotto due volte nella Naismith Memorial Basketball Hall of Fame: nel 2009[18] per la sua carriera individuale e nel 2010 come membro del Dream Team.[19] Diventò membro della FIBA Hall of Fame nel 2015.[20] Il 22 novembre 2016 fu insignito dal presidente USA Barack Obama della Presidential Medal of Freedom, la più alta onorificenza civile statunitense.[21]",
					likes: 0,
					timestamp: Timestamp(),
					uid: ""))
			.preferredColorScheme(.dark)
    }
}
