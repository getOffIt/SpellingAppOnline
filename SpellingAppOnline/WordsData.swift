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

public struct WordsData {
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
    
    public init() {
        var tempSections: [YearWordSection] = []
        theYear5WordsInFunnyFormat.forEach { (key: String, value: [String]) in
            let yearWordSection:YearWordSection = YearWordSection(title: key, words: value.map { Word(isDone: false, word: $0) })
            tempSections.append(yearWordSection)
        }
        self.yearWordSection = tempSections
    }
    
    let wordsNotMasteredYr6 = [
   "frequently",
   "explanation",
   "existence",
   "available"
    ]
    
    let wordsNotMasteredLeo = [
   "both",
   "echo",
   "going"
   ]
    
    let wordsNotMasteredLeo2 = [
   "caring",
   "hating",
   "hiking"
   ]
    
    let wordsNotMasteredYr5 = [
   "practice",
   "practise",
   "precede",
   "prophecy",
   "prophesy",
   "stationary",
   "stationery",
   "who's",
   "whose",
   "embarass",
   "interrupt",
   "language",
   "muscle",
   "criticise",
   "relevant"
   

      ]
    
    let wordsNotMastered2 = [
    "existence",
    "prejudice",
    "conscious",
    "marvellous",
    "available",
    "awkward",
    "curiosity",
    "secretary",
    "aloud",
    "allowed",
    "complement",
    "compliment"
  ]
    
    let wordsNotMastered = [
      "nuisance",
      "privilege",
      "restaurant",
      "foreign",
      "government",
      "correspond",
      "exaggerate",
      "amateurish",
      "especially",
      "accommodation",
      "preconception",
      "convenience",
      "existence",
      "prejudice",
      "conscious",
      "marvellous",
      "available",
      "awkward",
      "curiosity",
      "secretary",
      "aloud",
      "allowed",
      "complement",
      "compliment"
    ]
    
//    nuisance, privilege, restaurant, foreign, government, correspond, exaggerate, amateurish, especially, accommodation, preconception, convenience, existence, prejudice, conscious, marvellous, mischievous, available, awkward, curiosity, secretary, aloud, complement, compliment





    
    let allWordsYear6Part1DebugResponses = [
        "bruise", // Unstressed vowels
        "cemetery",
        "desperate",
        "guaranteeee",
        "nuisance",
        "privildege",
        "queue",
        "restaurant",
        "shoulderr"
    ]
    
    public let screenshots = [
        "accommodate", // Double consonants
        "apparent"
    ]
    
    let allWordsYear6Part1 = [
        "bruise", // Unstressed vowels
        "cemetery",
        "desperate",
        "guarantee",
        "nuisance",
        "privilege",
        "queue",
        "restaurant",
        "shoulder"
    ]
    
    public let allWordsYear6Part2 = [
        "foreign", // Unstressed consonants
        "government",
        "yacht",
        "accommodate", // Double consonants
        "apparent",
        "correspond",
        "equipped",
        "exaggerate",
        "excellent",
        "harass",
        "immediate",
        "profession"
    ]
    
    public let allWordsYear6Part3 = [
        "instantaneous",
        "marvellous",
        "mischievous",
        "amateur", // Other words 1
        "ancient",
        "available",
        "awkward",
        "bargain",
        "controversy",
        "brought"
    ]
    
    public let allWordsYear6Part4 = [
        "convenience", // Other words 2
        "existence",
        "hindrance",
        "prejudice",
        "sacrifice",
        "conscious",
        "disastrous"
    ]
    
    public let allWordsYear6Part5 = [
        "instantaneous",
        "marvellous",
        "mischievous",
        "amateur", // Other words 3
        "ancient",
        "available",
        "awkward",
        "bargain",
        "controversy",
        "curiosity"
    ]
    public let allWordsYear6Part6 = [
        "equipment", // Other words 4
        "familiar",
        "forty",
        "identity",
        "individual",
        "interfere",
        "obstinate",
        "secretary",
        "seldom"
    ]
    
    public let allWordsYear6Part7 = [
        "aisle", // homophones
        "isle",
        "aloud",
        "allowed",
        "affect",
        "effect",
        "altar",
        "alter",
        "ascent",
        "assent"
    ]
    public let allWordsYear6Part8 = [
        "bridal", // more homophones
        "bridle",
        "cereal",
        "serial",
        "complement",
        "compliment",
        "descent",
        "dissent",
        "desert",
        "dessert",
        "draft",
        "draught"
    ]
    
    let allWordsYear6 = [
        "bruise", // Unstressed vowels
        "cemetery",
        "desperate",
        "guarantee",
        "nuisance",
        "privilege",
        "queue",
        "restaurant",
        "shoulder",
        "foreign", // Unstressed consonants
        "government",
        "yacht",
        "accommodate", // Double consonants
        "apparent",
        "correspond",
        "equipped",
        "exaggerate",
        "excellent",
        "harass",
        "immediate",
        "profession",
        "amateurish", // Suffixes
        "apparently",
        "especially",
        "frequently",
        "immediately",
        "accommodation", // -tion words
        "explanation",
        "preconception",
        "pronunciation",
        "convenience", // 's' sound spelt as 'c'
        "existence",
        "hindrance",
        "prejudice",
        "sacrifice",
        "conscious", // -ous words
        "disastrous",
        "instantaneous",
        "marvellous",
        "mischievous",
        "amateur", // Other words
        "ancient",
        "available",
        "awkward",
        "bargain",
        "controversy",
        "curiosity",
        "equipment",
        "familiar",
        "forty",
        "identity",
        "individual",
        "interfere",
        "obstinate",
        "secretary",
        "seldom",
        "aisle", // homophones
        "isle",
        "aloud",
        "allowed",
        "affect",
        "effect",
        "altar",
        "alter",
        "ascent",
        "assent",
        "bridal",
        "bridle",
        "cereal",
        "serial",
        "complement",
        "compliment",
        "descent",
        "dissent",
        "desert",
        "dessert",
        "draft",
        "draught"
        
    ]
    
    let allWordsYear5 = [
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
    
    let homophonesDescriptionForLearningView: [String: String] = [
        "advice"    : "Advice, (noun: 'My teacher gave me great advice on my project.' - suggestions for what to do)",
        "advise"    : "advise (verb: 'My dad will advise me on my homework.' - to suggest what should be done)",
        "device"    : "device (noun: 'I read books on my electronic device.' - a gadget or machine made for a special purpose)",
        "devise"    : "Devise (verb: 'We need to devise a plan for our school project.' - to come up with a plan or idea)",
        "farther"   : "Farther (adverb: 'My friend lives farther away than the school.' - more distant or further away)",
        "father"    : "Father (noun: 'My father taught me how to ride a bike.' - a dad)",
        "guessed"   : "Guessed (verb: 'I guessed the answer to the riddle.' - tried to answer without being sure)",
        "guest"     : "Guest (noun: 'We have a guest staying with us tonight.' - someone invited to a place or event)",
        "heard"     : "heard (verb: 'I heard my name being called.' - listened to or noticed a sound)",
        "herd"      : "herd (noun: 'A herd of cows was in the field.' - a group of animals)",
        "led"       : "Led (verb): This is the past tense of “lead.” It means you already showed the way or were in charge before.",
        "lead"      : "Lead (verb): This means to show the way or be in charge. It is something happening now or in the future.",
        "licence"   : "Licence (noun: 'You need a licence to fish here.' - a special paper that allows you to do or have something)",
        "license"   : "license (verb: 'The city will license the new restaurant soon.' - to give permission)",
        "morning"   : "morning (noun: 'I eat breakfast in the morning.' - the first part of the day, after you wake up)",
        "mourning"  : "Mourning (noun: 'We were mourning the loss of our pet.' - feeling sad because someone has died)",
        "past"      : "Past (noun: 'Dinosaurs lived in the past.' - the time before now)",
        "passed"    : "Passed (verb: 'She passed the ball to her teammate.' - went by or moved in a direction)",
        "practice"  : "Practise (verb): This is an action. It’s when you are doing the thing to get better. Example: “I need to practise my spelling for the test.",
        "practise"  : "Practise (verb: 'I will practise my spelling for the test.' - to do something regularly to improve)",
        "principal" : "Principal (noun): This is the person in charge of a school, like the head teacher. Example: “The principal of the school gave a speech.” Principal (adjective): It can also mean the most important or main thing. Example: “The principal reason for the meeting was to discuss homework.",
        "principle" : "Principle (noun): A principle is a rule, belief, or idea that you live by. Example: “Honesty is a good principle to follow.”",
        "proceed"   : "Proceed (verb): To move forward or continue with something. Example: “After the break, we will proceed with the game.”",
        "precede"   : "Precede (verb): To come before something else. Example: “The introduction will precede the main event.”",
        "profit"    : "Profit (noun: 'We made a profit from our lemonade stand.' - the money you make when you sell something for more than it costs)",
        "prophet"   : "Prophet (noun: 'The prophet predicted rain for tomorrow.' - someone who tells what will happen in the future)",
        "prophecy"  : "Prophecy noun: 'The old book contained a prophecy about the future.' - a prediction or guess about the future)",
        "prophesy"  : "Prophesy (verb): The act of predicting or telling the future.",
        "stationary": "Stationary (adjective): Means not moving, staying still.",
        "stationery": "Stationery (noun): Refers to writing materials like paper, envelopes, and pens.",
        "steal"     : "steal (verb: 'It's wrong to steal someone else's toys.' - to take something that doesn't belong to you)",
        "steel"     : "steel (noun: 'The bridge is made of strong steel.' - a very strong metal made from iron)",
        "who’s"     : "who’s (contraction: 'who’s going to the party?' - who is or who has)",
        "whose"     : "Whose. (pronoun: 'Whose book is this on the table?' - shows who something belongs to)",
        "aisle"     : "aisle (noun): 'We walked down the grocery store aisle looking for cereal.' - a passage between rows of seats in a building such as a church or theater, an airplane, or a train.", // year 6 words
        "isle"      : "isle, (noun): 'The deserted isle was a perfect spot for a day of exploration.' - an island, especially a small one.",
        "aloud"     : "aloud, (adverb): 'She read the book aloud to the class.' - audibly; not silently or in a whisper.",
        "allowed"   : "allowed, (verb): 'The teacher allowed the class to leave early.' - permitted.",
        "affect"    : "affect (verb): 'The weather can greatly affect our mood.' - to have an effect on; make a difference to.",
        "effect"    : "effect (noun): 'The effect of the new law was immediately noticeable.' - a change which is a result or consequence of an action or other cause.",
        "altar"     : "altar (noun): 'The couple stood before the altar to exchange vows.' - a table or flat-topped block used as the focus for a religious ritual, especially for making sacrifices or offerings to a deity.",
        "alter"     : "alter (verb): 'He decided to alter his plans based on the weather forecast.' - to change or cause to change in character or composition, typically in a comparatively small but significant way.",
        "ascent"    : "ascent (noun): 'The first ascent of Mount Everest was a historic achievement.' - a climb or walk to the summit of a mountain or hill.",
        "assent"    : "assent (noun/verb): 'The board gave its assent to the proposal.' - the expression of approval or agreement.",
        "bridal"    : "bridal, (adjective): 'The bridal gown was stunning in its simplicity.' - relating to a bride or a wedding.",
        "bridle"    : "bridle, (noun/verb): 'She put the bridle on her horse carefully.' - the headgear used to control a horse, consisting of buckled straps to which a bit and reins are attached.",
        "cereal"    : "cereal (noun): 'For breakfast, I prefer cereal with milk.' - a grain used for food, such as wheat, oats, or corn.",
        "serial"    : "serial (adjective/noun): 'The police were searching for a serial offender.' - occurring in a series rather than simultaneously.",
        "complement": "Complement (noun/verb): Means something that completes or goes well with something else. Example: “The red shoes complement her dress.",
        "compliment": "Compliment (noun/verb): Means a nice or kind thing you say to someone to praise them. Example: “He gave her a compliment on her new haircut.",
        "descent"   : "descent (noun): 'The plane began its descent towards the airport.' - an action of moving downward, dropping, or falling.",
        "dissent"   : "dissent (noun/verb): 'There was considerable dissent among the members of the committee.' - the expression or holding of opinions at variance with those previously, commonly, or officially held.",
        "desert"    : "desert A large, hot, dry area of land with very little rain and few plants. Example: “Camels live in the desert.",
        "dessert"   : "dessert: 'For dessert, we had chocolate cake.' - the sweet course eaten at the end of a meal.",
        "draft"     : "draft (noun/verb): 'The author completed the first draft of her novel.' - a preliminary version of a piece of writing.",
        "draught"   : "draught (noun): 'He enjoyed a draught of cold beer on a hot day.' - a single act of drinking or inhaling; also refers to beer served from a keg rather than from a bottle or can."
    ]
    
    
    let Homophones: [String: String] = [
        //TODO: Remove capital from this var, it is not a Class
        "asdf":"asdf"
        //        "advice"    : "Advice, (noun: 'My teacher gave me great advice on my project.' - suggestions for what to do)",
        //        "advise"    : "advise (verb: 'My dad will advise me on my homework.' - to suggest what should be done)",
        //        "device"    : "device (noun: 'I read books on my electronic device.' - a gadget or machine made for a special purpose)",
        //        "devise"    : "Devise (verb: 'We need to devise a plan for our school project.' - to come up with a plan or idea)",
        //        "farther"   : "Farther (adverb: 'My friend lives farther away than the school.' - more distant or further away)",
        //        "father"    : "Father (noun: 'My father taught me how to ride a bike.' - a dad)",
        //        "guessed"   : "Guessed (verb: 'I guessed the answer to the riddle.' - tried to answer without being sure)",
        //        "guest"     : "Guest (noun: 'We have a guest staying with us tonight.' - someone invited to a place or event)",
        //        "heard"     : "heard (verb: 'I heard my name being called.' - listened to or noticed a sound)",
        //        "herd"      : "herd (noun: 'A herd of cows was in the field.' - a group of animals)",
        //        "led"       : "Led (verb): This is the past tense of “lead.” It means you already showed the way or were in charge before.",
        //        "lead"      : "Lead (verb): This means to show the way or be in charge. It is something happening now or in the future.",
        //        "licence"   : "Licence (noun: 'You need a licence to fish here.' - a special paper that allows you to do or have something)",
        //        "license"   : "license (verb: 'The city will license the new restaurant soon.' - to give permission)",
        //        "morning"   : "morning (noun: 'I eat breakfast in the morning.' - the first part of the day, after you wake up)",
        //        "mourning"  : "Mourning (noun: 'We were mourning the loss of our pet.' - feeling sad because someone has died)",
        //        "past"      : "Past (noun: 'Dinosaurs lived in the past.' - the time before now)",
        //        "passed"    : "Passed (verb: 'She passed the ball to her teammate.' - went by or moved in a direction)",
        //        "practice"  : "Practise (verb): This is an action. It’s when you are doing the thing to get better. Example: “I need to practise my spelling for the test.",
        //        "practise"  : "Practise (verb: 'I will practise my spelling for the test.' - to do something regularly to improve)",
        //        "principal" : "Principal (noun): This is the person in charge of a school, like the head teacher. Example: “The principal of the school gave a speech.” Principal (adjective): It can also mean the most important or main thing. Example: “The principal reason for the meeting was to discuss homework.",
        //        "principle" : "Principle (noun): A principle is a rule, belief, or idea that you live by. Example: “Honesty is a good principle to follow.”",
        //        "proceed"   : "Proceed (verb): To move forward or continue with something. Example: “After the break, we will proceed with the game.”",
        //        "precede"   : "Precede (verb): To come before something else. Example: “The introduction will precede the main event.”",
        //        "profit"    : "Profit (noun: 'We made a profit from our lemonade stand.' - the money you make when you sell something for more than it costs)",
        //        "prophet"   : "Prophet (noun: 'The prophet predicted rain for tomorrow.' - someone who tells what will happen in the future)",
        //        "prophecy"  : "Prophecy noun: 'The old book contained a prophecy about the future.' - a prediction or guess about the future)",
        //        "prophesy"  : "Prophesy (verb): The act of predicting or telling the future.",
        //        "stationary": "Stationary (adjective): Means not moving, staying still.",
        //        "stationery": "Stationery (noun): Refers to writing materials like paper, envelopes, and pens.",
        //        "steal"     : "steal (verb: 'It's wrong to steal someone else's toys.' - to take something that doesn't belong to you)",
        //        "steel"     : "steel (noun: 'The bridge is made of strong steel.' - a very strong metal made from iron)",
        //        "who’s"     : "who’s (contraction: 'who’s going to the party?' - who is or who has)",
        //        "whose"     : "Whose. (pronoun: 'Whose book is this on the table?' - shows who something belongs to)",
        //        "aisle"     : "aisle (noun): 'We walked down the grocery store aisle looking for cereal.' - a passage between rows of seats in a building such as a church or theater, an airplane, or a train.", // year 6 words
        //        "isle"      : "isle, (noun): 'The deserted isle was a perfect spot for a day of exploration.' - an island, especially a small one.",
        //        "aloud"     : "aloud, (adverb): 'She read the book aloud to the class.' - audibly; not silently or in a whisper.",
        //        "allowed"   : "allowed, (verb): 'The teacher allowed the class to leave early.' - permitted.",
        //        "affect"    : "affect (verb): 'The weather can greatly affect our mood.' - to have an effect on; make a difference to.",
        //        "effect"    : "effect (noun): 'The effect of the new law was immediately noticeable.' - a change which is a result or consequence of an action or other cause.",
        //        "altar"     : "altar (noun): 'The couple stood before the altar to exchange vows.' - a table or flat-topped block used as the focus for a religious ritual, especially for making sacrifices or offerings to a deity.",
        //        "alter"     : "alter (verb): 'He decided to alter his plans based on the weather forecast.' - to change or cause to change in character or composition, typically in a comparatively small but significant way.",
        //        "ascent"    : "ascent (noun): 'The first ascent of Mount Everest was a historic achievement.' - a climb or walk to the summit of a mountain or hill.",
        //        "assent"    : "assent (noun/verb): 'The board gave its assent to the proposal.' - the expression of approval or agreement.",
        //        "bridal"    : "bridal, (adjective): 'The bridal gown was stunning in its simplicity.' - relating to a bride or a wedding.",
        //        "bridle"    : "bridle, (noun/verb): 'She put the bridle on her horse carefully.' - the headgear used to control a horse, consisting of buckled straps to which a bit and reins are attached.",
        //        "cereal"    : "cereal (noun): 'For breakfast, I prefer cereal with milk.' - a grain used for food, such as wheat, oats, or corn.",
        //        "serial"    : "serial (adjective/noun): 'The police were searching for a serial offender.' - occurring in a series rather than simultaneously.",
        //        "complement": "Complement (noun/verb): Means something that completes or goes well with something else. Example: “The red shoes complement her dress.",
        //        "compliment": "Compliment (noun/verb): Means a nice or kind thing you say to someone to praise them. Example: “He gave her a compliment on her new haircut.",
        //        "descent"   : "descent (noun): 'The plane began its descent towards the airport.' - an action of moving downward, dropping, or falling.",
        //        "dissent"   : "dissent (noun/verb): 'There was considerable dissent among the members of the committee.' - the expression or holding of opinions at variance with those previously, commonly, or officially held.",
        //        "desert"    : "desert A large, hot, dry area of land with very little rain and few plants. Example: “Camels live in the desert.",
        //        "dessert"   : "dessert: 'For dessert, we had chocolate cake.' - the sweet course eaten at the end of a meal.",
        //        "draft"     : "draft (noun/verb): 'The author completed the first draft of her novel.' - a preliminary version of a piece of writing.",
        //        "draught"   : "draught (noun): 'He enjoyed a draught of cold beer on a hot day.' - a single act of drinking or inhaling; also refers to beer served from a keg rather than from a bottle or can."
    ]
    
    private let theYear5WordsInFunnyFormat = [
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
    
    // test data
    
    let testDataShort = [
        "a",
        "b"
    ]
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
    
    // year 1 words
    
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
    
    // french words
    
    let wordsFrench = [
        "je",
        "tu",
        "il",
        "elle",
        "on",
        "nous",
        "vous",
        "ils",
        "elles",
        "j'ai",
        "tu as",
        "il a",
        "elle a",
        "on a",
        "nous avons",
        "vous avez",
        "ils ont",
        "elles ont"
    ]
    
    public let allWordsYear2Part1 = [
        "behind",
        "children",
        "door",
        "find",
        "floor",
        "kind",
        "mind",
        "money",
        "poor",
        "wild"
    ]
}
