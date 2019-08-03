//
//  ViewController.swift
//  LanguageTutor
//
//  Created by TEC424 on 6/22/16.
//
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate {

    var synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    var englishArray = [String]()
    var frenchArray = [String]()
    
    var selectedPhrase = ""
    var selectedIndex = 0
    var rightCount = 0
    var wrongCount = 0
    var tryCount = 0
    var numberEntries: Int = 10
    var newArrayIndex: Int = 10
    var frenchLength: Int = 0
    var correctWord: String = ""
    
    
    
    
    
    
    //output labels
    @IBOutlet weak var lblShowEnglish: UILabel!
    @IBOutlet weak var lblDisplayGuessResult: UILabel!
    @IBOutlet weak var lblDisplayPhrase: UILabel!
    
    
    //text view
    @IBOutlet weak var tvOutput: UITextView!
    
    
    //picker
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    //buttons
    @IBOutlet weak var btnSpeak: UIButton!
    @IBAction func btnSpeak(_ sender: UIButton) {
        myUtterance = AVSpeechUtterance(string: lblDisplayPhrase.text!)
        myUtterance.rate = 0.5
        myUtterance.postUtteranceDelay = 0.08
        myUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        synth.speak(myUtterance)
      
        
        
    }
    
    
    @IBOutlet weak var btnGuess: UIButton!
    @IBAction func btnGuess(_ sender: UIButton) {
        if selectedIndex == newArrayIndex {
            responsesCorrect()
        } else {
            responsesIncorrect()
            
            
        }

        
    }
    
    
    @IBAction func btnReset(_ sender: UIButton) {
        selectedIndex = 0
        rightCount = 0
        wrongCount = 0
        tryCount = 0
        frenchLength = 0
        correctWord = ""
        newArrayIndex = 0
        numberEntries = 10
        lblDisplayPhrase.text! = ""
        lblDisplayGuessResult.text! = ""
        tvOutput.text! = ""
        lblShowEnglish.text! = ""
        
        viewDidLoad()
        
    }
    
    //array functions
    func createArrays()
    {
        frenchArray.removeAll()
        englishArray.removeAll()
        frenchArray.insert("", at:0)
        frenchArray.insert("こんにちは", at:1)
        frenchArray.insert("わたしは、あなたを愛しています",at:2)
        frenchArray.insert("映画はいつ始まりますか？",at:3)
        frenchArray.insert("私は気にしない",at:4)
        frenchArray.insert("その大丈夫",at:5)
        frenchArray.insert("さようなら",at:6)
        frenchArray.insert("こんにちは",at:7)
        frenchArray.insert("じゃあまたね",at:8)
        frenchArray.insert("はい",at:9)
        frenchArray.insert("いいえ",at:10)
        frenchArray.insert("アニメはどこですか？", at:11)
        frenchArray.insert("あなたは漫画を読んでいますか？", at:12)
        frenchArray.insert("私はいくつかの寿司を注文したい", at:13)
        frenchArray.insert("アメリカ人が私たちからラーメンを盗んだ", at:14)
        frenchArray.insert("どこで食べ物を入手できますか？", at:15)
        
        
        englishArray.insert(" ",at:0)
        englishArray.insert("Hello",at:1)
        englishArray.insert("I love you",at:2)
        englishArray.insert("When is the movie?",at:3)
        englishArray.insert("I dont care",at:4)
        englishArray.insert("It's alright",at:5)
        englishArray.insert("Goodbye",at:6)
        englishArray.insert("Hi",at:7)
        englishArray.insert("See you later",at:8)
        englishArray.insert("Yes",at:9)
        englishArray.insert("No",at:10)
        englishArray.insert("Where is the anime?",at:11)
        englishArray.insert("Do you read manga?",at:12)
        englishArray.insert("I would like to order some sushi",at:13)
        englishArray.insert("Americans stole Ramen from us",at:14)
        englishArray.insert("Where can I get some food?",at:15)
    }
    
    //respone functions
    func responsesCorrect()
    {
        rightCount += 1
        tryCount = 0
        
        lblDisplayGuessResult.text = "Yeah! You got it correct! "
        
        frenchArray.remove(at: newArrayIndex)
        englishArray.remove(at: newArrayIndex)
        frenchLength = frenchArray.count
        self.pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        if frenchLength != 1
        {
            numberEntries = frenchArray.count - 1
            newArrayIndex = Int(1+arc4random_uniform(UInt32(numberEntries)))
            lblShowEnglish.text = englishArray[newArrayIndex]
            
        }
        else
        {
            tryCount = 0
            
            lblDisplayPhrase.text = "Out of words. sorry  "
            tvOutput.text = "The number you got correct is \(rightCount) \n and the number you got incorrect is \(wrongCount)"
        }
    }
    
    
    func responsesIncorrect()
    {
        tryCount += 1
        numberEntries = frenchArray.count - 1
        
        correctWord = frenchArray[newArrayIndex]
        
        if tryCount != 3
        {
            lblDisplayGuessResult.text = "Sorry. Incorrect. Try again. "
        }
            
        else
        {
            tryCount = 0
            wrongCount += 1
            lblDisplayGuessResult.text = "Sorry. The  correct phrase is \(correctWord). \nWe will now go to a new phrase."
            frenchArray.remove(at: newArrayIndex)
            englishArray.remove(at: newArrayIndex)
            frenchLength = frenchArray.count
            numberEntries = frenchArray.count - 1
            newArrayIndex = Int(1 + arc4random_uniform(UInt32(numberEntries)))
            self.pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: true)
            
            
            if frenchLength != 1
            {
                numberEntries = frenchArray.count-1
                newArrayIndex = Int(1+arc4random_uniform(UInt32(numberEntries)))
                lblShowEnglish.text = englishArray[newArrayIndex]
                
            }
            else
            {
                lblDisplayPhrase.text = "Out of words. sorry  "
                tvOutput.text = "The number you got correct is \(rightCount) and the number you got incorrect is \(wrongCount)"
            }
        }
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createArrays()
        
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        btnSpeak.layer.borderColor = UIColor.black.cgColor
        btnSpeak.layer.borderWidth = 0
        
        btnGuess.layer.borderColor = UIColor.black.cgColor
        btnGuess.layer.borderWidth = 0
        
        newArrayIndex = Int(1+arc4random_uniform(UInt32(numberEntries)))
        lblShowEnglish.text = englishArray[newArrayIndex]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //picker view functions
    
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frenchArray.count
    }

    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return frenchArray[row]
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = frenchArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 36.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerView.layer.borderColor = UIColor.blue.cgColor
        pickerView.layer.borderWidth = 0
        //pickerView.transform = CGAffineTransform(scaleX: 1.1, y: 0.6);
        
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let title = UILabel()
        if var title = view {
            title = title as! UILabel
        }
        title.font = UIFont.systemFont(ofSize: 30)
        title.textColor = UIColor.black
        title.text =  frenchArray[row]
        title.textAlignment = .center
        
        return title
        
    }

    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        lblDisplayPhrase.text = frenchArray[row]
        selectedIndex = row
        
    }

    


}

