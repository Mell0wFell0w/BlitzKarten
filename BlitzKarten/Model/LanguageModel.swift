//
//  LanguageModel.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/25/24.
//

import Foundation

protocol LessonPlan {
    var languageName: String { get }
    var topics: [Language.Topic] { get }
    var progress: [Language.Progress] { get set }
    
    mutating func toggleLessonRead(for title: String);
}

struct Language {
    struct Topic: Identifiable, Hashable, Equatable {
        let id = UUID()
        let title: String
        let htmlFileName: String
        let vocabulary: [Term]
        let quiz: [QuizItem]
    }
    
    struct Term: Hashable, Equatable {
        let infinitive: String
        let translation: String
        let presentTense: String
        let imperfectTense: String
        let pastParticiple: String
    }
    
    struct QuizItem: Hashable, Equatable {
        let question: String
        let answers: [String]
        let correctAnswer: String
    }
    
    struct Progress {
        let topicTitle: String
        var lessonRead = false
        let vocabularyStudied = false
        let quizPassed = false
        let quizHighScore: Int = 0
    }
}

extension Language.Progress: Identifiable {
    var id: String { topicTitle }
}

private func key(for title: String, type: String) -> String {
    "\(title).\(type)"
}

struct GermanLessonPlan: LessonPlan {
    
    let languageName = "German"
    
    let topics = Data.germanTopics
    
    //MARK: - Mutable props
    
    var progress: [Language.Progress] = GermanLessonPlan.readProgressRecords()
    
    //MARK: - Helpers
    
    mutating func toggleLessonRead(for title: String) {
        if let index = progress.firstIndex(where: { $0.topicTitle == title }) {
            progress[index].lessonRead.toggle()
            UserDefaults.standard.set(progress[index].lessonRead, forKey: key(for: title, type: Key.lessonRead))
        } else {
            progress.append(Language.Progress(topicTitle: title))
            toggleLessonRead(for: title)
        }
    }
    
    private static func readProgressRecords() -> [Language.Progress] {
        var progressRecords = [Language.Progress]()
        
        Data.germanTopics.forEach { topic in
            var progressRecord = Language.Progress(topicTitle: topic.title)
            
            progressRecord.lessonRead = UserDefaults.standard.bool(forKey: key(for: topic.title, type: Key.lessonRead))
            
            //NEEDSWORK: implement this for the other three progress items
            
            progressRecords.append(progressRecord)
        }
        
        return progressRecords
    }
    
    //MARK: - Constants
    
    private struct Key {
        static let lessonRead = "lesson"
        static let vocabylaryStudied = "vocab"
        static let quizPassed = "quiz"
        static let highScore = "score"
    }
    
    private struct Data {
        static let germanTopics = [
            Language.Topic(
                title: "Irregular(strong) verbs",
                htmlFileName: "IrregularVerbs",
                vocabulary: [
                    Language.Term(infinitive: "backen", translation: "bake", presentTense: "backt", imperfectTense: "backte", pastParticiple: "gebacken"),
                    Language.Term(infinitive: "befehlen", translation: "command, order", presentTense: "befiehlt", imperfectTense: "befahl", pastParticiple: "befohlen"),
                    Language.Term(infinitive: "beginnen", translation: "begin", presentTense: "beginnt", imperfectTense: "begann", pastParticiple: "begonnen"),
                    Language.Term(infinitive: "beißen", translation: "bite", presentTense: "beißt", imperfectTense: "biss", pastParticiple: "gebissen"),
                    Language.Term(infinitive: "betrügen", translation: "deceive, cheat", presentTense: "betrügt", imperfectTense: "betrog", pastParticiple: "betrogen"),
                    Language.Term(infinitive: "bewegen", translation: "move", presentTense: "bewegt", imperfectTense: "bewog", pastParticiple: "bewogen"),
                    Language.Term(infinitive: "bieten", translation: "offer", presentTense: "bietet", imperfectTense: "bot", pastParticiple: "geboten"),
                    Language.Term(infinitive: "binden", translation: "tie", presentTense: "bindet", imperfectTense: "band", pastParticiple: "gebunden"),
                    Language.Term(infinitive: "bitten", translation: "ask, request", presentTense: "bittet", imperfectTense: "bat", pastParticiple: "gebeten"),
                    Language.Term(infinitive: "blasen", translation: "blow", presentTense: "bläst", imperfectTense: "blies", pastParticiple: "geblasen"),
                    Language.Term(infinitive: "bleiben", translation: "stay", presentTense: "bleibt", imperfectTense: "blieb", pastParticiple: "geblieben"),
                    Language.Term(infinitive: "braten", translation: "fry, roast", presentTense: "brät", imperfectTense: "briet", pastParticiple: "gebraten"),
                    Language.Term(infinitive: "brechen", translation: "break", presentTense: "bricht", imperfectTense: "brach", pastParticiple: "gebrochen"),
                    Language.Term(infinitive: "brennen", translation: "burn", presentTense: "brennt", imperfectTense: "brannte", pastParticiple: "gebrannt"),
                    Language.Term(infinitive: "bringen", translation: "bring", presentTense: "bringt", imperfectTense: "brachte", pastParticiple: "gebracht"),
                    Language.Term(infinitive: "denken", translation: "think", presentTense: "denkt", imperfectTense: "dachte", pastParticiple: "gedacht"),
                    Language.Term(infinitive: "dürfen", translation: "be allowed", presentTense: "darf", imperfectTense: "durfte", pastParticiple: "gedurft"),
                    Language.Term(infinitive: "empfehlen", translation: "recommend", presentTense: "empfiehlt", imperfectTense: "empfahl", pastParticiple: "empfohlen"),
                    Language.Term(infinitive: "erschrecken", translation: "frighten", presentTense: "erschrickt", imperfectTense: "erschrak", pastParticiple: "erschrocken"),
                    Language.Term(infinitive: "essen", translation: "eat", presentTense: "isst", imperfectTense: "aß", pastParticiple: "gegessen"),
                    Language.Term(infinitive: "fahren", translation: "drive, travel", presentTense: "fährt", imperfectTense: "fuhr", pastParticiple: "gefahren"),
                    Language.Term(infinitive: "fallen", translation: "fall", presentTense: "fällt", imperfectTense: "fiel", pastParticiple: "gefallen"),
                    Language.Term(infinitive: "fangen", translation: "catch", presentTense: "fängt", imperfectTense: "fing", pastParticiple: "gefangen"),
                    Language.Term(infinitive: "finden", translation: "find", presentTense: "findet", imperfectTense: "fand", pastParticiple: "gefunden"),
                    Language.Term(infinitive: "fliegen", translation: "fly", presentTense: "fliegt", imperfectTense: "flog", pastParticiple: "geflogen"),
                    Language.Term(infinitive: "fliehen", translation: "flee", presentTense: "flieht", imperfectTense: "floh", pastParticiple: "geflohen"),
                    Language.Term(infinitive: "fließen", translation: "flow", presentTense: "fließt", imperfectTense: "floss", pastParticiple: "geflossen"),
                    Language.Term(infinitive: "fressen", translation: "eat (animals)", presentTense: "frisst", imperfectTense: "fraß", pastParticiple: "gefressen"),
                    Language.Term(infinitive: "frieren", translation: "freeze", presentTense: "friert", imperfectTense: "fror", pastParticiple: "gefroren"),
                    Language.Term(infinitive: "geben", translation: "give", presentTense: "gibt", imperfectTense: "gab", pastParticiple: "gegeben"),
                    Language.Term(infinitive: "gehen", translation: "go", presentTense: "geht", imperfectTense: "ging", pastParticiple: "gegangen"),
                    Language.Term(infinitive: "gelingen", translation: "succeed", presentTense: "gelingt", imperfectTense: "gelang", pastParticiple: "gelungen"),
                    Language.Term(infinitive: "gelten", translation: "apply, be valid", presentTense: "gilt", imperfectTense: "galt", pastParticiple: "gegolten"),
                    Language.Term(infinitive: "genießen", translation: "enjoy", presentTense: "genießt", imperfectTense: "genoss", pastParticiple: "genossen"),
                    Language.Term(infinitive: "geschehen", translation: "happen", presentTense: "geschieht", imperfectTense: "geschah", pastParticiple: "geschehen"),
                    Language.Term(infinitive: "gewinnen", translation: "win", presentTense: "gewinnt", imperfectTense: "gewann", pastParticiple: "gewonnen"),
                    Language.Term(infinitive: "gießen", translation: "pour", presentTense: "gießt", imperfectTense: "goss", pastParticiple: "gegossen"),
                    Language.Term(infinitive: "gleichen", translation: "resemble", presentTense: "gleicht", imperfectTense: "glich", pastParticiple: "geglichen"),
                    Language.Term(infinitive: "gleiten", translation: "glide", presentTense: "gleitet", imperfectTense: "glitt", pastParticiple: "geglitten"),
                    Language.Term(infinitive: "graben", translation: "dig", presentTense: "gräbt", imperfectTense: "grub", pastParticiple: "gegraben"),
                    Language.Term(infinitive: "greifen", translation: "grasp", presentTense: "greift", imperfectTense: "griff", pastParticiple: "gegriffen"),
                    Language.Term(infinitive: "halten", translation: "hold", presentTense: "hält", imperfectTense: "hielt", pastParticiple: "gehalten"),
                    Language.Term(infinitive: "hängen", translation: "hang", presentTense: "hängt", imperfectTense: "hing", pastParticiple: "gehangen"),
                    Language.Term(infinitive: "heben", translation: "lift", presentTense: "hebt", imperfectTense: "hob", pastParticiple: "gehoben"),
                    Language.Term(infinitive: "heißen", translation: "be called", presentTense: "heißt", imperfectTense: "hieß", pastParticiple: "geheißen"),
                    Language.Term(infinitive: "helfen", translation: "help", presentTense: "hilft", imperfectTense: "half", pastParticiple: "geholfen"),
                    Language.Term(infinitive: "kennen", translation: "know (someone)", presentTense: "kennt", imperfectTense: "kannte", pastParticiple: "gekannt"),
                    Language.Term(infinitive: "klingen", translation: "sound", presentTense: "klingt", imperfectTense: "klang", pastParticiple: "geklungen"),
                    Language.Term(infinitive: "kommen", translation: "come", presentTense: "kommt", imperfectTense: "kam", pastParticiple: "gekommen"),
                    Language.Term(infinitive: "können", translation: "be able", presentTense: "kann", imperfectTense: "konnte", pastParticiple: "gekonnt"),
                    Language.Term(infinitive: "laden", translation: "load", presentTense: "lädt", imperfectTense: "lud", pastParticiple: "geladen"),
                    Language.Term(infinitive: "lassen", translation: "let, allow", presentTense: "lässt", imperfectTense: "ließ", pastParticiple: "gelassen"),
                    Language.Term(infinitive: "laufen", translation: "run", presentTense: "läuft", imperfectTense: "lief", pastParticiple: "gelaufen"),
                    Language.Term(infinitive: "leiden", translation: "suffer", presentTense: "leidet", imperfectTense: "litt", pastParticiple: "gelitten"),
                    Language.Term(infinitive: "leihen", translation: "lend", presentTense: "leiht", imperfectTense: "lieh", pastParticiple: "geliehen"),
                    Language.Term(infinitive: "lesen", translation: "read", presentTense: "liest", imperfectTense: "las", pastParticiple: "gelesen"),
                    Language.Term(infinitive: "liegen", translation: "lie (down)", presentTense: "liegt", imperfectTense: "lag", pastParticiple: "gelegen"),
                    Language.Term(infinitive: "lügen", translation: "lie (not tell the truth)", presentTense: "lügt", imperfectTense: "log", pastParticiple: "gelogen"),
                    Language.Term(infinitive: "messen", translation: "measure", presentTense: "misst", imperfectTense: "maß", pastParticiple: "gemessen"),
                    Language.Term(infinitive: "mögen", translation: "like", presentTense: "mag", imperfectTense: "mochte", pastParticiple: "gemocht"),
                    Language.Term(infinitive: "müssen", translation: "must", presentTense: "muss", imperfectTense: "musste", pastParticiple: "gemusst"),
                    Language.Term(infinitive: "nehmen", translation: "take", presentTense: "nimmt", imperfectTense: "nahm", pastParticiple: "genommen"),
                    Language.Term(infinitive: "nennen", translation: "name, call", presentTense: "nennt", imperfectTense: "nannte", pastParticiple: "genannt"),
                    Language.Term(infinitive: "pfeifen", translation: "whistle", presentTense: "pfeift", imperfectTense: "pfiff", pastParticiple: "gepfiffen"),
                    Language.Term(infinitive: "raten", translation: "advise, guess", presentTense: "rät", imperfectTense: "riet", pastParticiple: "geraten"),
                    Language.Term(infinitive: "reiben", translation: "rub", presentTense: "reibt", imperfectTense: "rieb", pastParticiple: "gerieben"),
                    Language.Term(infinitive: "reißen", translation: "tear", presentTense: "reißt", imperfectTense: "riss", pastParticiple: "gerissen"),
                    Language.Term(infinitive: "reiten", translation: "ride", presentTense: "reitet", imperfectTense: "ritt", pastParticiple: "geritten"),
                    Language.Term(infinitive: "rennen", translation: "run", presentTense: "rennt", imperfectTense: "rannte", pastParticiple: "gerannt"),
                    Language.Term(infinitive: "riechen", translation: "smell", presentTense: "riecht", imperfectTense: "roch", pastParticiple: "gerochen"),
                    Language.Term(infinitive: "rufen", translation: "call", presentTense: "ruft", imperfectTense: "rief", pastParticiple: "gerufen"),
                    Language.Term(infinitive: "schaffen", translation: "create", presentTense: "schafft", imperfectTense: "schuf", pastParticiple: "geschaffen"),
                    Language.Term(infinitive: "scheiden", translation: "separate", presentTense: "scheidet", imperfectTense: "schied", pastParticiple: "geschieden"),
                    Language.Term(infinitive: "scheinen", translation: "seem, shine", presentTense: "scheint", imperfectTense: "schien", pastParticiple: "geschienen"),
                    Language.Term(infinitive: "schieben", translation: "push", presentTense: "schiebt", imperfectTense: "schob", pastParticiple: "geschoben"),
                    Language.Term(infinitive: "schießen", translation: "shoot", presentTense: "schießt", imperfectTense: "schoss", pastParticiple: "geschossen"),
                    Language.Term(infinitive: "schlafen", translation: "sleep", presentTense: "schläft", imperfectTense: "schlief", pastParticiple: "geschlafen"),
                    Language.Term(infinitive: "schlagen", translation: "hit", presentTense: "schlägt", imperfectTense: "schlug", pastParticiple: "geschlagen"),
                    Language.Term(infinitive: "schleichen", translation: "creep", presentTense: "schleicht", imperfectTense: "schlich", pastParticiple: "geschlichen"),
                    Language.Term(infinitive: "schließen", translation: "close", presentTense: "schließt", imperfectTense: "schloss", pastParticiple: "geschlossen"),
                    Language.Term(infinitive: "schlingen", translation: "gulp", presentTense: "schlingt", imperfectTense: "schlang", pastParticiple: "geschlungen"),
                    Language.Term(infinitive: "schmeißen", translation: "throw", presentTense: "schmeißt", imperfectTense: "schmiss", pastParticiple: "geschmissen"),
                    Language.Term(infinitive: "schmelzen", translation: "melt", presentTense: "schmilzt", imperfectTense: "schmolz", pastParticiple: "geschmolzen"),
                    Language.Term(infinitive: "schneiden", translation: "cut", presentTense: "schneidet", imperfectTense: "schnitt", pastParticiple: "geschnitten"),
                    Language.Term(infinitive: "schreiben", translation: "write", presentTense: "schreibt", imperfectTense: "schrieb", pastParticiple: "geschrieben"),
                    Language.Term(infinitive: "schreien", translation: "scream", presentTense: "schreit", imperfectTense: "schrie", pastParticiple: "geschrien"),
                    Language.Term(infinitive: "schweigen", translation: "be silent", presentTense: "schweigt", imperfectTense: "schwieg", pastParticiple: "geschwiegen"),
                    Language.Term(infinitive: "schwimmen", translation: "swim", presentTense: "schwimmt", imperfectTense: "schwamm", pastParticiple: "geschwommen"),
                    Language.Term(infinitive: "sehen", translation: "see", presentTense: "sieht", imperfectTense: "sah", pastParticiple: "gesehen"),
                    Language.Term(infinitive: "sein", translation: "be", presentTense: "ist", imperfectTense: "war", pastParticiple: "gewesen"),
                    Language.Term(infinitive: "senden", translation: "send", presentTense: "sendet", imperfectTense: "sandte", pastParticiple: "gesandt"),
                    Language.Term(infinitive: "singen", translation: "sing", presentTense: "singt", imperfectTense: "sang", pastParticiple: "gesungen"),
                    Language.Term(infinitive: "sinken", translation: "sink", presentTense: "sinkt", imperfectTense: "sank", pastParticiple: "gesunken"),
                    Language.Term(infinitive: "sitzen", translation: "sit", presentTense: "sitzt", imperfectTense: "saß", pastParticiple: "gesessen"),
                    Language.Term(infinitive: "sprechen", translation: "speak", presentTense: "spricht", imperfectTense: "sprach", pastParticiple: "gesprochen"),
                    Language.Term(infinitive: "springen", translation: "jump", presentTense: "springt", imperfectTense: "sprang", pastParticiple: "gesprungen"),
                    Language.Term(infinitive: "stehen", translation: "stand", presentTense: "steht", imperfectTense: "stand", pastParticiple: "gestanden"),
                    Language.Term(infinitive: "stehlen", translation: "steal", presentTense: "stiehlt", imperfectTense: "stahl", pastParticiple: "gestohlen"),
                    Language.Term(infinitive: "steigen", translation: "climb", presentTense: "steigt", imperfectTense: "stieg", pastParticiple: "gestiegen"),
                    Language.Term(infinitive: "sterben", translation: "die", presentTense: "stirbt", imperfectTense: "starb", pastParticiple: "gestorben"),
                    Language.Term(infinitive: "stinken", translation: "stink", presentTense: "stinkt", imperfectTense: "stank", pastParticiple: "gestunken"),
                    Language.Term(infinitive: "stoßen", translation: "push", presentTense: "stößt", imperfectTense: "stieß", pastParticiple: "gestoßen"),
                    Language.Term(infinitive: "streichen", translation: "paint, stroke", presentTense: "streicht", imperfectTense: "strich", pastParticiple: "gestrichen"),
                    Language.Term(infinitive: "streiten", translation: "argue", presentTense: "streitet", imperfectTense: "stritt", pastParticiple: "gestritten"),
                    Language.Term(infinitive: "tragen", translation: "carry, wear", presentTense: "trägt", imperfectTense: "trug", pastParticiple: "getragen"),
                    Language.Term(infinitive: "treffen", translation: "meet", presentTense: "trifft", imperfectTense: "traf", pastParticiple: "getroffen"),
                    Language.Term(infinitive: "treiben", translation: "drive, push", presentTense: "treibt", imperfectTense: "trieb", pastParticiple: "getrieben"),
                    Language.Term(infinitive: "treten", translation: "step", presentTense: "tritt", imperfectTense: "trat", pastParticiple: "getreten"),
                    Language.Term(infinitive: "trinken", translation: "drink", presentTense: "trinkt", imperfectTense: "trank", pastParticiple: "getrunken"),
                    Language.Term(infinitive: "tun", translation: "do", presentTense: "tut", imperfectTense: "tat", pastParticiple: "getan"),
                    Language.Term(infinitive: "verderben", translation: "spoil", presentTense: "verdirbt", imperfectTense: "verdarb", pastParticiple: "verdorben"),
                    Language.Term(infinitive: "vergessen", translation: "forget", presentTense: "vergisst", imperfectTense: "vergaß", pastParticiple: "vergessen"),
                    Language.Term(infinitive: "verlieren", translation: "lose", presentTense: "verliert", imperfectTense: "verlor", pastParticiple: "verloren"),
                    Language.Term(infinitive: "wachsen", translation: "grow", presentTense: "wächst", imperfectTense: "wuchs", pastParticiple: "gewachsen"),
                    Language.Term(infinitive: "waschen", translation: "wash", presentTense: "wäscht", imperfectTense: "wusch", pastParticiple: "gewaschen"),
                    Language.Term(infinitive: "weichen", translation: "yield", presentTense: "weicht", imperfectTense: "wich", pastParticiple: "gewichen"),
                    Language.Term(infinitive: "weisen", translation: "point", presentTense: "weist", imperfectTense: "wies", pastParticiple: "gewiesen"),
                    Language.Term(infinitive: "wenden", translation: "turn", presentTense: "wendet", imperfectTense: "wandte", pastParticiple: "gewandt"),
                    Language.Term(infinitive: "werben", translation: "advertise", presentTense: "wirbt", imperfectTense: "warb", pastParticiple: "geworben"),
                    Language.Term(infinitive: "werden", translation: "become", presentTense: "wird", imperfectTense: "wurde", pastParticiple: "geworden"),
                    Language.Term(infinitive: "werfen", translation: "throw", presentTense: "wirft", imperfectTense: "warf", pastParticiple: "geworfen"),
                    Language.Term(infinitive: "wiegen", translation: "weigh", presentTense: "wiegt", imperfectTense: "wog", pastParticiple: "gewogen"),
                    Language.Term(infinitive: "wissen", translation: "know (a fact)", presentTense: "weiß", imperfectTense: "wusste", pastParticiple: "gewusst"),
                    Language.Term(infinitive: "ziehen", translation: "pull", presentTense: "zieht", imperfectTense: "zog", pastParticiple: "gezogen"),
                    Language.Term(infinitive: "zwingen", translation: "force", presentTense: "zwingt", imperfectTense: "zwang", pastParticiple: "gezwungen")
                ],
                quiz: [
                    Language.QuizItem(
                        question: "",
                        answers: ["True", "False"],
                        correctAnswer: "False"
                    ),
                    Language.QuizItem(
                        question: "",
                        answers: ["True", "False"],
                        correctAnswer: "False"
                    )
                ]
            ),
            Language.Topic(
                title: "Prefix Verbs",
                htmlFileName: "PrefixVerbs",
                vocabulary: [
                    Language.Term(infinitive: "anfangen", translation: "to begin", presentTense: "fängt an", imperfectTense: "fing an", pastParticiple: "angefangen"),
                    Language.Term(infinitive: "aufhören", translation: "to stop", presentTense: "hört auf", imperfectTense: "hörte auf", pastParticiple: "aufgehört"),
                    Language.Term(infinitive: "besuchen", translation: "to visit", presentTense: "besucht", imperfectTense: "besuchte", pastParticiple: "besucht"),
                    Language.Term(infinitive: "empfehlen", translation: "to recommend", presentTense: "empfiehlt", imperfectTense: "empfahl", pastParticiple: "empfohlen"),
                    Language.Term(infinitive: "entdecken", translation: "to discover", presentTense: "entdeckt", imperfectTense: "entdeckte", pastParticiple: "entdeckt"),
                    Language.Term(infinitive: "erklären", translation: "to explain", presentTense: "erklärt", imperfectTense: "erklärte", pastParticiple: "erklärt"),
                    Language.Term(infinitive: "vergessen", translation: "to forget", presentTense: "vergisst", imperfectTense: "vergaß", pastParticiple: "vergessen"),
                    Language.Term(infinitive: "zusammenarbeiten", translation: "to collaborate", presentTense: "arbeitet zusammen", imperfectTense: "arbeitete zusammen", pastParticiple: "zusammengearbeitet"),
                    Language.Term(infinitive: "mitkommen", translation: "to come along", presentTense: "kommt mit", imperfectTense: "kam mit", pastParticiple: "mitgekommen")
                ],
                quiz: [
                    // Define quiz questions focusing on understanding separable and inseparable prefixes
                ]
            )
            
        ]
    }
}
