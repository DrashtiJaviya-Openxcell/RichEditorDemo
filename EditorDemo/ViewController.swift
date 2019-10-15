//
//  ViewController.swift
//  EditorDemo
//
//  Created by Drashti on 15/10/19.
//  Copyright © 2019 Drashti. All rights reserved.
//

import UIKit
import RichEditorView

class ViewController: UIViewController {
    
    @IBOutlet var editorView: RichEditorView!
    @IBOutlet var htmlTextView: UITextView!
    
    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = RichEditorDefaultOption.all
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editorView.delegate = self
        
        let view1 = KeyboardManager(view: UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 88)))
        
        editorView.inputAccessoryView = view1.view
        editorView.placeholder = "Edit here"
        
        toolbar.delegate = self
        toolbar.editor = editorView
        editorView.html = "<b>Jesus is God.</b> He saves by grace through faith alone. Soli Deo gloria! <a href='https://perfectGod.com'>perfectGod.com</a>"
        
        // This will create a custom action that clears all the input text when it is pressed
        //        let item = RichEditorOptionItem(image: nil, title: "Clear") { toolbar in
        //            toolbar?.editor?.html = ""
        //        }
        //
        //        var options = toolbar.options
        //        options.append(item)
        //        toolbar.options = options
    }
    
}

extension ViewController: RichEditorDelegate {
    
    func richEditor(_ editor: RichEditorView, heightDidChange height: Int) { }
    
    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
        if content.isEmpty {
            htmlTextView.text = "HTML Preview"
        } else {
            htmlTextView.text = content
        }
    }
    
    func richEditorTookFocus(_ editor: RichEditorView) { }
    
    func richEditorLostFocus(_ editor: RichEditorView) { }
    
    func richEditorDidLoad(_ editor: RichEditorView) { }
    
    func richEditor(_ editor: RichEditorView, shouldInteractWith url: URL) -> Bool { return true }
    
    func richEditor(_ editor: RichEditorView, handleCustomAction content: String) { }
    
}

extension ViewController: RichEditorToolbarDelegate {
    
    fileprivate func randomColor() -> UIColor {
        let colors = [
            UIColor.red,
            UIColor.orange,
            UIColor.yellow,
            UIColor.green,
            UIColor.blue,
            UIColor.purple
        ]
        
        let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return color
    }
    
    func richEditorToolbarChangeTextColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextColor(color)
    }
    
    func richEditorToolbarChangeBackgroundColor(_ toolbar: RichEditorToolbar) {
        let color = randomColor()
        toolbar.editor?.setTextBackgroundColor(color)
    }
    
    func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar) {
        toolbar.editor?.insertImage("https://gravatar.com/avatar/696cf5da599733261059de06c4d1fe22", alt: "Gravatar")
    }
    
    func richEditorToolbarInsertLink(_ toolbar: RichEditorToolbar) {
        // Can only add links to selected text, so make sure there is a range selection first
        //        if let hasSelection = toolbar.editor?.rangeSelectionExists(), hasSelection {
        //            toolbar.editor?.insertLink("http://github.com/cjwirth/RichEditorView", title: "Github Link")
        //        }
    }
}

