//
//  ViewController.swift
//  TestToolbar
//
//  Created by Adrian Aranda on 1/4/23.
//

import UIKit
enum FontStyle {
    //    case underlined
    case italic
    case bold
    //    case strikethrough
    case h1
    case h2
    case h3
    case unorderedList
    //    case orderedList
    
}

enum Markdown: String {
    case bold = "**"
    case italic = "*"
    case h1 = "#"
    case h2 = "##"
    case h3 = "###"
    //    case underlined = "+"
    //    case strikethrough = ""
    case unorderedList = "-"
    //    case orderedList = ""
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textToolbar: UIToolbar!
    @IBOutlet weak var containerTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boldButton = UIBarButtonItem(title: "Bold", style: .done, target: self, action: #selector(self.boldButtonPressed))
        let italicButton = UIBarButtonItem(title: "Italic", style: .done, target: self, action: #selector(self.italicButtonPressed))
        let h1 = UIBarButtonItem(title: "H1", style: .done, target: self, action: #selector(self.h1ButtonPressed))
        let h2 = UIBarButtonItem(title: "H2", style: .done, target: self, action: #selector(self.h2ButtonPressed))
        let h3 = UIBarButtonItem(title: "H3", style: .done, target: self, action: #selector(self.h3ButtonPressed))
        let unorderedList = UIBarButtonItem(title: "List", style: .done, target: self, action: #selector(self.unorderedListButtonPressed))
        let toolBarButtons = [boldButton, italicButton, h1, h2, h3, unorderedList]
        
        // Configurar la toolbar con los botones
        textToolbar.setItems(toolBarButtons, animated: false)
    }
    
    @objc func boldButtonPressed (_ sender: UIBarButtonItem) {
        changeStyleMarkDown(textStyle: .bold)
    }
    
    @objc func italicButtonPressed (_ sender: UIBarButtonItem) {
        changeStyleMarkDown(textStyle: .italic)
    }
    
    @objc func h1ButtonPressed (_ sender: UIBarButtonItem) {
        changeStyleMarkDown(textStyle: .h1)
    }
    
    @objc func h2ButtonPressed (_ sender: UIBarButtonItem) {
        changeStyleMarkDown(textStyle: .h2)
    }
    
    @objc func h3ButtonPressed (_ sender: UIBarButtonItem) {
        changeStyleMarkDown(textStyle: .h3)
    }
    
    @objc func unorderedListButtonPressed (_ sender: UIBarButtonItem) {
        changeStyleMarkDown(textStyle: .unorderedList)
    }
    
    func changeStyleMarkDown (textStyle: FontStyle) {
        if let textView = containerTextView {
            
            // Obtener el rango de texto seleccionado
            let selectedRange = textView.selectedRange
            let textComplete = containerTextView.text ?? ""
            let attributedString = NSMutableAttributedString(string: textComplete)
            var lastCharacter: NSAttributedString = NSAttributedString(string: "")
            var firstCharacter: NSAttributedString = NSAttributedString(string: "")
            var value: NSAttributedString = NSAttributedString(string: "")
            
            if textStyle == .bold {
                value = NSAttributedString(string: Markdown.bold.rawValue)
            } else if textStyle == .italic {
                value = NSAttributedString(string: Markdown.italic.rawValue)
            }else if textStyle == .h1 {
                value = NSAttributedString(string: Markdown.h1.rawValue)
            }else if textStyle == .h2 {
                value = NSAttributedString(string: Markdown.h2.rawValue)
            }else if textStyle == .h3 {
                value = NSAttributedString(string: Markdown.h3.rawValue)
            }else if textStyle == .unorderedList {
                value = NSAttributedString(string: Markdown.unorderedList.rawValue)
            }
            
            let valueLength = value.length
            
            if selectedRange.length != 0 {
                firstCharacter = attributedString.attributedSubstring(from: NSRange(location: selectedRange.location, length: valueLength))
                
                if textStyle != .unorderedList {
                    lastCharacter = attributedString.attributedSubstring(from: NSRange(location: selectedRange.location + selectedRange.length - valueLength, length: valueLength))
                }
            }
            
            
            let boldActive = (firstCharacter.string == Markdown.bold.rawValue && lastCharacter.string == Markdown.bold.rawValue)
            let italicActive = (firstCharacter.string == Markdown.italic.rawValue && lastCharacter.string == Markdown.italic.rawValue)
            let h1Active = (firstCharacter.string == Markdown.h1.rawValue && lastCharacter.string == Markdown.h1.rawValue)
            let h2Active = (firstCharacter.string == Markdown.h2.rawValue && lastCharacter.string == Markdown.h2.rawValue)
            let h3Active = (firstCharacter.string == Markdown.h3.rawValue && lastCharacter.string == Markdown.h3.rawValue)
            let unorderedListActive = (firstCharacter.string == Markdown.unorderedList.rawValue)
            
            // Obtener el texto completo del text view
            
            if boldActive {
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location, length: valueLength))
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location + (selectedRange.length - valueLength) - valueLength, length: valueLength))
            } else if italicActive {
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location, length: valueLength))
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location + (selectedRange.length - valueLength) - valueLength, length: valueLength))
            } else if h1Active {
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location, length: valueLength))
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location + (selectedRange.length - valueLength) - valueLength, length: valueLength))
            } else if h2Active {
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location, length: valueLength))
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location + (selectedRange.length - valueLength) - valueLength, length: valueLength))
            } else if h3Active {
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location, length: valueLength))
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location + (selectedRange.length - valueLength) - valueLength, length: valueLength))
            } else if unorderedListActive {
                attributedString.deleteCharacters(in: NSRange(location: selectedRange.location, length: valueLength))
            } else {
                if textStyle == .bold {
                    // Agregar el asterisco antes y después del rango seleccionado
                    let valueMark = NSAttributedString(string: Markdown.bold.rawValue)
                    attributedString.insert(valueMark, at: selectedRange.location)
                    attributedString.insert(valueMark, at: selectedRange.location + selectedRange.length + valueLength)
                } else if textStyle == .italic {
                    // Agregar el asterisco antes y después del rango seleccionado
                    let valueMark = NSAttributedString(string: Markdown.italic.rawValue)
                    attributedString.insert(valueMark, at: selectedRange.location)
                    attributedString.insert(valueMark, at: selectedRange.location + selectedRange.length + valueLength)
                }else if textStyle == .h1 {
                    // Agregar el asterisco antes y después del rango seleccionado
                    let valueMark = NSAttributedString(string: Markdown.h1.rawValue)
                    attributedString.insert(valueMark, at: selectedRange.location)
                    attributedString.insert(valueMark, at: selectedRange.location + selectedRange.length + valueLength)
                }else if textStyle == .h2 {
                    // Agregar el asterisco antes y después del rango seleccionado
                    let valueMark = NSAttributedString(string: Markdown.h2.rawValue)
                    attributedString.insert(valueMark, at: selectedRange.location)
                    attributedString.insert(valueMark, at: selectedRange.location + selectedRange.length + valueLength)
                }else if textStyle == .h3 {
                    // Agregar el asterisco antes y después del rango seleccionado
                    let valueMark = NSAttributedString(string: Markdown.h3.rawValue)
                    attributedString.insert(valueMark, at: selectedRange.location)
                    attributedString.insert(valueMark, at: selectedRange.location + selectedRange.length + valueLength)
                }else if textStyle == .unorderedList {
                    // Agregar el asterisco antes y después del rango seleccionado
                    let valueMark = NSAttributedString(string: Markdown.unorderedList.rawValue)
                    attributedString.insert(valueMark, at: selectedRange.location)
                }
            }
            // Actualizar el rango seleccionado para incluir los asteriscos
            let newSelectedRange = NSRange(location: selectedRange.location + 1, length: selectedRange.length)
            
            // Asignar el attributed string modificado al text view
            textView.attributedText = attributedString
            
            // Seleccionar el rango de texto con los asteriscos incluidos
            textView.selectedRange = newSelectedRange
            containerTextView = textView
        }
    }
}
