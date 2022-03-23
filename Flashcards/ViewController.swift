import UIKit

// creating one thing that represents the entire Flashcard
struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // create an array to store flashcards
    var flashcards = [Flashcard]()
    
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // read saved flashcards
        readSavedFlashcards()
        
        // add initial flashcard if needed
        if flashcards.count == 0 {
        updateFlashcard(question: "What is an array?", answer: "A data structure that stores a fixed-size collection of elements that are identified by at least one array index or key")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }
        else if (frontLabel.isHidden == false){
            frontLabel.isHidden = true
        }
        }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex + 1
        
        // update labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // decrement current index
        currentIndex = currentIndex - 1
        
        //update labels
        updateLabels()
        
        //update buttons
        updateNextPrevButtons()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // We know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // we know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    // update the flashcard each time a new one is added
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        
        // add flashcards to flashcard array
        flashcards.append(flashcard)
        
        // logging to console
        print("ADDED NEW FLASHCARD")
        print("We now have \(flashcards.count) flashcards")
        
        // Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // Update the prev and next buttons
        updateNextPrevButtons()
        
        // update labels
        updateLabels()
        
        // save flashcards
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons() {
        // disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // disable prev button is at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        // get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        print(currentFlashcard)
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk() {
        // from flashcard array to disctionary array
        let dictionaryArray = flashcards.map{ (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
//        dictionaryArray = []
        
        // save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // log it
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        // read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // put all these cards in flashcard array
            flashcards.append(contentsOf: savedCards)
        }
        
    }
}
