import Foundation

struct Word {
    var isDone: Bool
    let word: String
    var isWrong: Bool = false
    var isSaid: Bool = true
}

struct YearWordSection {
    let title: String
    var index: Int = 0
    var words: [Word]
    var isDone: Bool {
        words.allSatisfy { $0.isDone }
    }
    var count: Int {
        words.count
    }
}

struct WordsData {
    var yearWordSection:[YearWordSection]
    var allWords: [String] {
        yearWordSection.flatMap { $0.words.map { $0.word } }
    }
    var count: Int {
        var cpt = 0
        yearWordSection.forEach { (section) in
            cpt += section.count
        }
        return cpt
    }
    
    init() {
        var tempSections: [YearWordSection] = []
        theYear5Words.forEach { (key: String, value: [String]) in
            let yearWordSection:YearWordSection = YearWordSection(title: key, words: value.map { Word(isDone: false, word: $0) })
            tempSections.append(yearWordSection)
        }
        self.yearWordSection = tempSections
    }
    
    let testDataShort = [
        "a",
        "b"
    ]
//        .replacingOccurrences(of: "’", with: "'")
    let testDataWho = [
        "who’s"
    ]
    
    let testDataMid = [
        "environment",
        "rhythm",
        "conscience",
        "thorough",
        "appreciate",
        "necessary",
        "muscle",
        "recognise"
    ]
    
    let testDataMidWrong = [
        "exxxnvironment",
        "rhxxxxythm",
        "cxxxonscience",
        "xxxthorough",
        "xxxappreciate",
        "xxxnecessary",
        "xxxmuscle",
        "xxxrecognise"
    ]
    
    let testDataMidMixWrong = [
        "environment",
        "rhythm",
        "conscience",
        "thorough",
        "xxxappreciate",
        "xxxnecessary",
        "xxxmuscle",
        "xxxrecognise"
    ]
    
    let testDataMidMix25Wrong = [
        "environment",
        "rhythm",
        "conscience",
        "thorough",
        "appreciate",
        "necessary",
        "xxxmuscle",
        "xxxrecognise"
    ]
    
    let testDataHomophones = [
        "prophet",
        "prophecy",
        "prophesy",
        "stationary",
        "stationery",
        "steal",
        "steel",
        "antoine"
    ]
    
    let highFrequencyWords: [String] = [
        "the", "that", "not", "look", "put", "and", "with", "then", "don't", "could",
        "a", "all", "were", "come", "house", "to", "we", "go", "will", "old",
        "said", "can", "little", "into", "too", "in", "are", "as", "back", "by",
        "he", "up", "no", "from", "day", "I", "had", "mum", "children", "made",
        "of", "my", "one", "him", "time", "it", "her", "them", "Mr", "I'm",
        "was", "what", "do", "get", "if", "you", "there", "me", "just", "help",
        "they", "out", "down", "now", "Mrs", "on", "this", "dad", "came", "called",
        "she", "have", "big", "oh", "here", "is", "went", "when", "about", "off",
        "for", "be", "it's", "got", "asked", "at", "like", "see", "their", "saw",
        "his", "some", "looked", "people", "make", "but", "so", "very", "your", "an"
    ]
    let yearOnewords10: [String] = [
        "vet",
        "jog",
        "week",
        "exit",
        "zebra",
        "queen",
        "check",
        "rush",
        "quiz",
        "quick",
        "rich"
        ]
    let yearOnewords: [String] = [
    "vet",
    "jog",
    "week",
    "exit",
    "zebra",
    "queen",
    "check",
    "rush",
    "quiz",
    "quick",
    "rich",
    "shock",
    "mix",
    "will",
    "jam",
    "wood",
    "cork",
    "cow",
    "dear",
    "cure",
    "night",
    "moon",
    "with",
    "night",
    "feel",
    "turn",
    "boil",
    "fair",
    "her",
    "hard",
    "this",
    "hang",
    "pain",
    "light",
    "zoom",
    "term",
    "pair",
    "bark",
    "burp",
    "foil",
    "cook",
    "song",
    "wait",
    "high",
    "load",
    "church",
    "cash",
    "teeth",
    "yes",
    "buzz",
    "wax",
    "van",
    "sharp",
    "jazz",
    "much",
    "rocker",
    "win",
    "yell",
    "them",
    "waiter",
    "deep",
    "soap",
    "root",
    "book",
    "born",
    "town",
    "fear",
    "sure",
    "farm"
    ]
    
    let wordsNotMastered = [
        "communicate",
        "twelfth",
        "interrupt",
        "community",
        "aggressive",
        "symbol",
        "sincerely",
        "determined"
    ]
    
    let allWordsString = [
    "average",
    "category",
    "community",
    "parliament",
    "temperature",
    "vegetable",
    "environment",
    "rhyme",
    "rhythm",
    "twelfth",
    "according",
    "attached",
    "determined",
    "sincerely",
    "achieve",
    "conscience",
    "soldier",
    "sufficient",
    "variety",
    "thorough",
    "competition",
    "accompany",
    "aggressive",
    "appreciate",
    "committee",
    "communicate",
    "community",
    "embarrass",
    "interrupt",
    "necessary",
    "occupy",
    "opportunity",
    "programme",
    "recommend",
    "suggest",
    "develop",
    "language",
    "lightning",
    "muscle",
    "persuade",
    "physical",
    "stomach",
    "criticise",
    "leisure",
    "neighbour",
    "recognise",
    "relevant",
    "signature",
    "sincere",
    "symbol",
    "system",
    "advice",
    "advise",
    "device",
    "devise",
    "farther",
    "father",
    "guessed",
    "guest",
    "heard",
    "herd",
    "led",
    "lead",
    "licence",
    "license",
    "morning",
    "mourning",
    "past",
    "passed",
    "practice",
    "practise",
    "principal",
    "principle",
    "proceed",
    "precede",
    "profit",
    "prophet",
    "prophecy",
    "prophesy",
    "stationary",
    "stationery",
    "steal",
    "steel",
    "who’s",
    "whose"
    ]
    
    let Homophones: [String: String] = [
        "advice": "(noun: 'My teacher gave me great advice on my project.' - suggestions for what to do)",
        "advise": "(verb: 'My dad will advise me on my homework.' - to suggest what should be done)",
        "device": "(noun: 'I read books on my electronic device.' - a gadget or machine made for a special purpose)",
        "devise": "(verb: 'We need to devise a plan for our school project.' - to come up with a plan or idea)",
        "farther": "(adverb: 'My friend lives farther away than the school.' - more distant or further away)",
        "father": "(noun: 'My father taught me how to ride a bike.' - a dad)",
        "guessed": "(verb: 'I guessed the answer to the riddle.' - tried to answer without being sure)",
        "guest": "(noun: 'We have a guest staying with us tonight.' - someone invited to a place or event)",
        "heard": "(verb: 'I heard my name being called.' - listened to or noticed a sound)",
        "herd": "(noun: 'A herd of cows was in the field.' - a group of animals)",
        "led": "(verb: 'The guide led us through the museum.' - guided or showed the way)",
        "lead": "(noun: 'The pencil is made of graphite, not lead.' - a heavy metal; pronounced 'led')",
        "licence": "(noun: 'You need a licence to fish here.' - a special paper that allows you to do or have something)",
        "license": "(verb: 'The city will license the new restaurant soon.' - to give permission)",
        "morning": "(noun: 'I eat breakfast in the morning.' - the first part of the day, after you wake up)",
        "mourning": "(noun: 'We were mourning the loss of our pet.' - feeling sad because someone has died)",
        "past": "(noun: 'Dinosaurs lived in the past.' - the time before now)",
        "passed": "(verb: 'She passed the ball to her teammate.' - went by or moved in a direction)",
        "practice": "(noun: 'Practice makes perfect in math.' - doing something again and again to get better at it)",
        "practise": "(verb: 'I will practise my spelling for the test.' - to do something regularly to improve)",
        "principal": "(noun: 'Our principal announced a holiday.' - the head of a school)",
        "principle": "(noun: 'Honesty is an important principle for everyone.' - an important rule or idea that guides how you act)",
        "proceed": "(verb: 'Please proceed to the next chapter of the book.' - to go forward or continue)",
        "precede": "(verb: 'Thunder usually precedes lightning.' - to come before something else)",
        "profit": "(noun: 'We made a profit from our lemonade stand.' - the money you make when you sell something for more than it costs)",
        "prophet": "(noun: 'The prophet predicted rain for tomorrow.' - someone who tells what will happen in the future)",
        "prophecy": "(noun: 'The old book contained a prophecy about the future.' - a prediction or guess about the future)",
        "prophesy": "(verb: 'The wizard will prophesy the kingdom’s fate.' - to predict or say what will happen in the future)",
        "stationary": "(adjective: 'The car remained stationary at the red light.' - not moving, staying in one place)",
        "stationery": "(noun: 'I bought new stationery for school.' - things you use for writing, like paper and pens)",
        "steal": "(verb: 'It's wrong to steal someone else's toys.' - to take something that doesn't belong to you)",
        "steel": "(noun: 'The bridge is made of strong steel.' - a very strong metal made from iron)",
        "who’s": "(contraction: 'who’s going to the party?' - who is or who has)",
        "whose": "(pronoun: 'Whose book is this on the table?' - shows who something belongs to)"
    ]
    
    private let theYear5Words = [
        "Unstressed vowels": [
            "average",
            "category",
            "definite",
            "dictionary",
            "parliament",
            "temperature",
            "vegetable",
            "develop",
            "language",
            "lightning",
            "muscle",
            "persuade",
            "physical",
            "stomach"
        ],
        "Suffixes and prefixes": [
            "according",
            "attached",
            "determined",
            "sincerely",
            "achieve",
            "conscience",
            "soldier",
            "sufficient",
            "variety",
            "thorough",
            "competition"
        ],
        "Double consonants": [
            "accompany",
            "aggressive",
            "appreciate",
            "committee",
            "communicate",
            "community",
            "embarrass",
            "interrupt",
            "necessary",
            "occupy",
            "opportunity",
            "programme",
            "recommend",
            "suggest"
        ],
        "Cross-curricular words": [
            "develop",
            "language",
            "lightning",
            "muscle",
            "persuade",
            "physical",
            "stomach"
        ],
        "Homophones": [
            "advice (noun: 'My teacher gave me great advice on my project.' - suggestions for what to do)",
            "advise (verb: 'My dad will advise me on my homework.' - to suggest what should be done)",
            "device (noun: 'I read books on my electronic device.' - a gadget or machine made for a special purpose)",
            "devise (verb: 'We need to devise a plan for our school project.' - to come up with a plan or idea)",
            "farther (adverb: 'My friend lives farther away than the school.' - more distant or further away)",
            "father (noun: 'My father taught me how to ride a bike.' - a dad)",
            "guessed (verb: 'I guessed the answer to the riddle.' - tried to answer without being sure)",
            "guest (noun: 'We have a guest staying with us tonight.' - someone invited to a place or event)",
            "heard (verb: 'I heard my name being called.' - listened to or noticed a sound)",
            "herd (noun: 'A herd of cows was in the field.' - a group of animals)",
            "led (verb: 'The guide led us through the museum.' - guided or showed the way)",
            "lead (noun: 'The pencil is made of graphite, not lead.' - a heavy metal; pronounced 'led')",
            "licence (noun: 'You need a licence to fish here.' - a special paper that allows you to do or have something)",
            "license (verb: 'The city will license the new restaurant soon.' - to give permission)",
            "morning (noun: 'I eat breakfast in the morning.' - the first part of the day, after you wake up)",
            "mourning (noun: 'We were mourning the loss of our pet.' - feeling sad because someone has died)",
            "past (noun: 'Dinosaurs lived in the past.' - the time before now)",
            "passed (verb: 'She passed the ball to her teammate.' - went by or moved in a direction)",
            "practice (noun: 'Practice makes perfect in math.' - doing something again and again to get better at it)",
            "practise (verb: 'I will practise my spelling for the test.' - to do something regularly to improve)",
            "principal (noun: 'Our principal announced a holiday.' - the head of a school)",
            "principle (noun: 'Honesty is an important principle for everyone.' - an important rule or idea that guides how you act)",
            "proceed (verb: 'Please proceed to the next chapter of the book.' - to go forward or continue)",
            "precede (verb: 'Thunder usually precedes lightning.' - to come before something else)",
            "profit (noun: 'We made a profit from our lemonade stand.' - the money you make when you sell something for more than it costs)",
            "prophet (noun: 'The prophet predicted rain for tomorrow.' - someone who tells what will happen in the future)",
            "prophecy (noun: 'The old book contained a prophecy about the future.' - a prediction or guess about the future)",
            "prophesy (verb: 'The wizard will prophesy the kingdom’s fate.' - to predict or say what will happen in the future)",
            "stationary (adjective: 'The car remained stationary at the red light.' - not moving, staying in one place)",
            "stationery (noun: 'I bought new stationery for school.' - things you use for writing, like paper and pens)",
            "steal (verb: 'It's wrong to steal someone else's toys.' - to take something that doesn't belong to you)",
            "steel (noun: 'The bridge is made of strong steel.' - a very strong metal made from iron)",
            "who's (contraction: 'Who's going to the party?' - who is or who has)",
            "whose (pronoun: 'Whose book is this on the table?' - shows who something belongs to)"
        ],
        
        "Unstressed consonants": [
            "environment",
            "rhyme",
            "rhythm",
            "twelfth"
        ],
        "Other words": [
            "criticise",
            "leisure",
            "neighbour",
            "recognise",
            "relevant",
            "signature",
            "sincere",
            "symbol",
            "system"
        ]
]
    
}
